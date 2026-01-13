# C5: Analyze Git History

## Purpose
**Phase 2 of C5 Generation** - Analyzes git history to find automation commits and map to content.

This skill scans git commit logs to identify commits related to automation usage, extracts metadata about what was created, and builds a timeline of automation activities.

**Called By**: `c5-documentation-generator` agent (Phase 2)

---

## What It Does

1. **Searches git log** - Finds commits with automation keywords
2. **Extracts commit metadata** - Gets hash, date, message, author
3. **Identifies files changed** - Determines which data files were modified
4. **Infers agent names** - Parses commit messages for agent references
5. **Maps content additions** - Identifies what content items were added
6. **Builds timeline** - Creates chronological automation history

---

## Input

**Required**:
- Git repository must be initialized
- Commit history must be available

**Optional**:
- `timeRange` - How far back to search (default: "3 months ago")
- `dataFilePaths` - Specific data files to track (from Phase 1 discovery)

---

## Output

Returns a JSON object with automation commit history:

```json
{
  "commits": [
    {
      "hash": "9744db6",
      "shortHash": "9744db6",
      "date": "2026-01-13",
      "dateISO": "2026-01-13T10:30:00Z",
      "message": "feat: Add 4 SEO-optimized IIM interview blog posts",
      "author": "Shiva Kakkar",
      "filesChanged": [
        "app/data/blog-posts.ts"
      ],
      "linesAdded": 120,
      "linesDeleted": 5,
      "inferredAgent": "rehearsal-blog-generator",
      "contentAdded": [
        {
          "type": "BlogPost",
          "slug": "gap-year-career-pivot-iim-interview-2026",
          "file": "app/data/blog-posts.ts"
        },
        {
          "type": "BlogPost",
          "slug": "economic-literacy-iim-interviews-2026",
          "file": "app/data/blog-posts.ts"
        }
      ],
      "automationType": "content-generation"
    },
    {
      "hash": "82bc98e",
      "shortHash": "82bc98e",
      "date": "2026-01-12",
      "dateISO": "2026-01-12T15:45:00Z",
      "message": "fix: Remove redundant floating RehearsalBanner from technical-questions subpages",
      "author": "Shiva Kakkar",
      "filesChanged": [
        "app/technical-questions/[slug]/page.tsx"
      ],
      "linesAdded": 2,
      "linesDeleted": 8,
      "inferredAgent": null,
      "contentAdded": [],
      "automationType": "manual-fix"
    }
  ],
  "summary": {
    "totalCommits": 2,
    "automationCommits": 1,
    "manualCommits": 1,
    "dateRange": {
      "earliest": "2026-01-12",
      "latest": "2026-01-13"
    },
    "agentsUsed": ["rehearsal-blog-generator"],
    "filesAffected": ["app/data/blog-posts.ts", "app/technical-questions/[slug]/page.tsx"],
    "contentTypesCreated": ["BlogPost"]
  },
  "warnings": []
}
```

---

## Implementation Instructions

### Step 1: Check Git Repository

Use **Bash tool** to verify git is available:

```bash
# Check if git repo exists
git rev-parse --git-dir 2>/dev/null
```

**Expected**: Output like `.git` (confirms git repo)

**If Command Fails**: Return error: "No git repository found. C5 git analysis requires git history."

---

### Step 2: Search for Automation Commits

Use **Bash tool** with multiple grep patterns to find automation-related commits:

```bash
# Search for commits with automation keywords
git log --all --oneline --since="3 months ago" \
  --grep="feat:" \
  --grep="agent" \
  --grep="automation" \
  --grep="generated" \
  --grep="[Aa]uto" \
  --grep="batch" \
  --grep="bulk" \
  --format="%H|%h|%aI|%an|%s" \
  -i
```

**Output Format**: `hash|shortHash|dateISO|author|message` (one per line)

**Example Output**:
```
9744db6abc123|9744db6|2026-01-13T10:30:00Z|Shiva Kakkar|feat: Add 4 SEO-optimized IIM interview blog posts
82bc98edef456|82bc98e|2026-01-12T15:45:00Z|Shiva Kakkar|fix: Remove redundant floating RehearsalBanner
```

**Parse Each Line**:
1. Split by `|` delimiter
2. Extract hash, shortHash, dateISO, author, message
3. Convert dateISO to simple date format (YYYY-MM-DD)

---

### Step 3: Get Files Changed for Each Commit

For each commit found in Step 2, use **Bash tool** to get files modified:

```bash
# Get files changed in specific commit
git show {hash} --name-only --format=""
```

**Example Output**:
```
app/data/blog-posts.ts
app/data/iim-schools-v2.ts
```

**Filter Rules**:
- Only include data files (from Phase 1 discovery)
- Exclude test files (*.test.ts, *.spec.ts)
- Exclude config files (package.json, tsconfig.json)
- Focus on files in data directories

---

### Step 4: Get Line Changes for Each Commit

For each commit, use **Bash tool** to count lines added/deleted:

```bash
# Get line stats for commit
git show {hash} --shortstat --format=""
```

**Example Output**:
```
 1 file changed, 120 insertions(+), 5 deletions(-)
```

**Parse**:
- Extract `120` as linesAdded
- Extract `5` as linesDeleted

---

### Step 5: Infer Agent Names from Commit Messages

Parse commit messages to identify agent usage:

**Pattern Matching**:
1. Check for agent names mentioned explicitly:
   - `"blog generator"` → `rehearsal-blog-generator`
   - `"b-school-page-creator"` → `b-school-page-creator`
   - `"engineering-content-pipeline"` → `engineering-content-pipeline`

2. Check for automation indicators:
   - `"feat:"` prefix suggests new feature (likely automation)
   - `"generated"`, `"automated"`, `"batch"`, `"bulk"` keywords
   - Multiple items added in single commit (4+ similar items)

3. Infer from files changed:
   - If `blog-posts.ts` changed → likely `rehearsal-blog-generator`
   - If `iim-schools-v2.ts` changed → likely `b-school-page-creator`
   - If `engineering-content.ts` changed → likely `engineering-content-pipeline`

**Inferrence Logic**:
```typescript
function inferAgent(message: string, filesChanged: string[]): string | null {
  // Explicit agent mentions
  if (message.includes('blog generator') || message.includes('blog-generator')) {
    return 'rehearsal-blog-generator';
  }
  if (message.includes('b-school') || message.includes('bschool')) {
    return 'b-school-page-creator';
  }
  if (message.includes('engineering-content') || message.includes('engineering content')) {
    return 'engineering-content-pipeline';
  }

  // File-based inference
  if (filesChanged.some(f => f.includes('blog-posts'))) {
    return 'rehearsal-blog-generator';
  }
  if (filesChanged.some(f => f.includes('iim-schools'))) {
    return 'b-school-page-creator';
  }
  if (filesChanged.some(f => f.includes('engineering-content'))) {
    return 'engineering-content-pipeline';
  }

  // Keyword-based inference
  if (message.match(/feat:|generated|automated|batch|bulk/i)) {
    return 'unknown-agent'; // Likely automation but can't determine which
  }

  return null; // Manual commit
}
```

---

### Step 6: Identify Content Added

For each commit that modified data files, use **Bash tool** to see diff:

```bash
# Get diff for specific file in commit
git diff {hash}^ {hash} -- {filepath}
```

**Example Output**:
```diff
+  {
+    slug: 'gap-year-career-pivot-iim-interview-2026',
+    title: 'Gap Year Career Pivot IIM Interview 2026',
+    category: 'IIM Interviews',
+    ...
+  },
+  {
+    slug: 'economic-literacy-iim-interviews-2026',
+    title: 'Economic Literacy IIM Interviews 2026',
+    category: 'IIM Interviews',
+    ...
+  },
```

**Parse Strategy**:
1. Look for lines starting with `+` (additions)
2. Identify slug patterns: `slug: 'some-slug-here'`
3. Extract slug values
4. Infer content type from file name:
   - `blog-posts.ts` → BlogPost
   - `iim-schools-v2.ts` → IIMSchool
   - `engineering-content.ts` → EngineeringGuide

**Regex Pattern**:
```regex
/slug:\s*['"]([\w-]+)['"]/g
```

**Build contentAdded Array**:
```typescript
contentAdded: [
  {
    type: "BlogPost",
    slug: "gap-year-career-pivot-iim-interview-2026",
    file: "app/data/blog-posts.ts"
  },
  {
    type: "BlogPost",
    slug: "economic-literacy-iim-interviews-2026",
    file: "app/data/blog-posts.ts"
  }
]
```

---

### Step 7: Classify Automation Type

For each commit, determine automation type:

**Types**:
- `"content-generation"` - New content added via agent
- `"content-update"` - Existing content modified via agent
- `"manual-fix"` - Manual changes by developer
- `"infrastructure"` - Agent/skill/hook changes
- `"refactor"` - Code refactoring
- `"unknown"` - Cannot determine

**Classification Logic**:
```typescript
function classifyAutomationType(commit: Commit): string {
  // Infrastructure changes
  if (commit.filesChanged.some(f => f.includes('.claude/'))) {
    return 'infrastructure';
  }

  // Content generation
  if (commit.inferredAgent && commit.contentAdded.length > 0) {
    return 'content-generation';
  }

  // Content update
  if (commit.inferredAgent && commit.linesAdded > 0 && commit.contentAdded.length === 0) {
    return 'content-update';
  }

  // Manual fix (fix: prefix, no agent)
  if (commit.message.startsWith('fix:') && !commit.inferredAgent) {
    return 'manual-fix';
  }

  // Refactor
  if (commit.message.includes('refactor')) {
    return 'refactor';
  }

  return 'unknown';
}
```

---

### Step 8: Build Summary Statistics

Aggregate data across all commits:

```typescript
{
  summary: {
    totalCommits: commits.length,
    automationCommits: commits.filter(c => c.inferredAgent).length,
    manualCommits: commits.filter(c => !c.inferredAgent).length,
    dateRange: {
      earliest: min(commits.map(c => c.date)),
      latest: max(commits.map(c => c.date))
    },
    agentsUsed: unique(commits.map(c => c.inferredAgent).filter(Boolean)),
    filesAffected: unique(commits.flatMap(c => c.filesChanged)),
    contentTypesCreated: unique(commits.flatMap(c => c.contentAdded.map(ca => ca.type)))
  }
}
```

---

## Error Handling

### No Git Repository
**Error**: `git rev-parse` fails
**Action**: Return error with message: "No git repository found. Git analysis skipped."

### No Automation Commits Found
**Warning**: `git log` returns empty
**Action**: Return empty commits array with warning: "No automation-related commits found in last 3 months."

### Git Command Fails
**Error**: Any git command returns non-zero exit code
**Action**: Log specific error, continue with partial data, add warning to output

### Cannot Parse Commit
**Warning**: Commit parsing fails (malformed message, missing metadata)
**Action**: Skip commit, add warning: "Skipped commit {hash}: {reason}"

### Cannot Infer Agent
**Info**: Agent name cannot be determined
**Action**: Set `inferredAgent: null`, set `automationType: "unknown"`

---

## Optimization Strategies

### Time Range
**Default**: "3 months ago"
**Rationale**: Most relevant recent automation activity
**Configurable**: User can specify different range

### Commit Limit
**Default**: No limit (get all matching commits)
**Optional**: Add `--max-count=50` to limit to 50 most recent

### File Filtering
**Strategy**: Only analyze commits touching data files from Phase 1
**Implementation**:
```bash
git log --since="3 months ago" -- app/data/*.ts src/data/*.ts
```

### Parallel Processing
**If Available**: Process multiple commits in parallel
**Fallback**: Sequential processing

---

## Output Format

**Always return valid JSON** with this structure:

```typescript
{
  commits: Commit[];
  summary: Summary;
  warnings?: string[];
  errors?: string[];
}

interface Commit {
  hash: string;               // Full commit hash
  shortHash: string;          // 7-char short hash
  date: string;               // YYYY-MM-DD format
  dateISO: string;            // ISO 8601 format
  message: string;            // Commit message
  author: string;             // Author name
  filesChanged: string[];     // Array of file paths
  linesAdded: number;         // Lines added
  linesDeleted: number;       // Lines deleted
  inferredAgent: string | null;  // Agent name or null
  contentAdded: ContentItem[];   // Content items created
  automationType: string;     // Classification
}

interface ContentItem {
  type: string;    // BlogPost, IIMSchool, etc.
  slug: string;    // Content slug
  file: string;    // Data file path
}

interface Summary {
  totalCommits: number;
  automationCommits: number;
  manualCommits: number;
  dateRange: {
    earliest: string;
    latest: string;
  };
  agentsUsed: string[];
  filesAffected: string[];
  contentTypesCreated: string[];
}
```

---

## Testing

### Test Case 1: Rehearsal AI Project

**Expected Commits** (last 3 months):
- 4+ automation commits (blog posts, school pages)
- Agents identified: `rehearsal-blog-generator`, `b-school-page-creator`
- Content types: BlogPost, IIMSchool

**Expected Summary**:
- `automationCommits` > 0
- `agentsUsed` includes known agents
- `contentTypesCreated` includes BlogPost

### Test Case 2: Project with No Automation

**Setup**: Standard Next.js project, no `.claude/` directory
**Expected Output**:
- Empty commits array OR only manual commits
- `automationCommits: 0`
- Warning: "No automation-related commits found"

### Test Case 3: Mixed Manual + Automation

**Expected**:
- Both automation and manual commits identified
- Correct classification (content-generation vs manual-fix)
- Agent names correctly inferred

### Test Case 4: No Git History

**Setup**: Project without git or fresh repo
**Expected Output**:
- Error: "No git repository found"
- Empty commits array
- No summary data

---

## Performance

**Expected Time**: < 5 seconds for most projects (3 months history)

**Large Projects** (1000+ commits):
- May take 10-20 seconds
- Consider adding commit limit (--max-count=100)

**Optimizations**:
- Use `--since` to limit time range
- Filter by file paths early (avoid analyzing all commits)
- Cache git results if running multiple times

---

## Integration with Other Phases

### Input from Phase 1 (Discovery)
- Uses `dataFiles` array to filter relevant commits
- Uses `agents` array to improve agent name inference

### Output to Phase 3 (Content Analysis)
- Provides timeline of content creation
- Maps commits to content slugs
- Identifies which agent created which content

### Output to Phase 4 (Doc Generation)
- Real examples with git commit references
- Timeline of automation usage
- Statistics for "Content Statistics" sections

---

## Example Usage in Agent

```markdown
## Phase 2: Git History Analysis

The agent will now analyze your git history to find automation commits.

Running git log analysis...

Found 15 commits in last 3 months:
- 8 automation commits
- 7 manual commits

Agents identified:
- rehearsal-blog-generator (4 commits)
- b-school-page-creator (3 commits)
- engineering-content-pipeline (1 commit)

Content created via automation:
- 12 blog posts (app/data/blog-posts.ts)
- 5 B-school pages (app/data/iim-schools-v2.ts)
- 3 engineering guides (app/data/engineering-content.ts)

Proceeding to Phase 3: Content Analysis...
```

---

## Limitations

### Cannot Detect
- Automation that didn't create git commits
- Content created before git history starts
- Uncommitted automation work

### May Miss
- Commits without standard keywords
- Agent usage not mentioned in commit messages
- Content added to files not in data directories

### Workarounds
- Phase 3 can infer automation from content patterns (batch additions)
- User can manually specify agent usage via prompts
- Git analysis is optional (can skip if not available)

---

## Future Enhancements

### v2.0 Ideas
- Support for squashed commits
- Branch analysis (feature branches)
- Pull request metadata integration
- CI/CD run correlation (link commits to automation runs)
- Multi-repo support (monorepo analysis)

---

## Version

**Skill Version**: 1.0.0
**Last Updated**: January 2026
**Compatible With**: c5-documentation-generator v1.0.0
