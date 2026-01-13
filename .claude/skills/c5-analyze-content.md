# C5: Analyze Content

## Purpose
**Phase 3 of C5 Generation** - Maps content to agents/skills/MCPs used for creation.

This skill reads data files, counts content items, matches them to git commits, and infers which automation tools were used to create each type of content.

**Called By**: `c5-documentation-generator` agent (Phase 3)

---

## What It Does

1. **Reads data files** - Parses TypeScript/JavaScript data structures
2. **Identifies content types** - Determines what kind of content exists (BlogPost, IIMSchool, etc.)
3. **Counts items** - Tallies total content pieces per type
4. **Matches to commits** - Links content to git commit history (from Phase 2)
5. **Infers automation tools** - Determines which agents/skills/MCPs were used
6. **Extracts examples** - Gets real content items with metadata for documentation

---

## Input

**Required** (from previous phases):
- `dataFiles` array from Phase 1 (Discovery)
- `commits` array from Phase 2 (Git Analysis)
- `agents` array from Phase 1 (Discovery)

**Optional**:
- `exampleLimit` - Max examples per content type (default: 3)
- `contentTypes` - Specific types to analyze (default: auto-detect all)

---

## Output

Returns a JSON object mapping content to automation:

```json
{
  "contentTypes": [
    {
      "type": "BlogPost",
      "displayName": "Blog Posts",
      "file": "app/data/blog-posts.ts",
      "count": 50,
      "agentUsed": "rehearsal-blog-generator",
      "confidence": "high",
      "skillsUsed": [
        "engineering-deep-research",
        "engineering-article-writer",
        "engineering-seo-optimizer"
      ],
      "mcpsUsed": [
        "reddit-mcp",
        "web-search-mcp",
        "lighthouse-mcp"
      ],
      "creationPattern": "batch",
      "batchInfo": {
        "avgBatchSize": 4,
        "totalBatches": 12,
        "frequency": "weekly"
      },
      "examples": [
        {
          "slug": "gap-year-career-pivot-iim-interview-2026",
          "title": "Gap Year Career Pivot IIM Interview 2026",
          "dateCreated": "2026-01-13",
          "gitCommit": "9744db6",
          "wordCount": 2400,
          "seoScore": 95
        },
        {
          "slug": "economic-literacy-iim-interviews-2026",
          "title": "Economic Literacy IIM Interviews 2026",
          "dateCreated": "2026-01-13",
          "gitCommit": "9744db6",
          "wordCount": 2600,
          "seoScore": 92
        }
      ],
      "statistics": {
        "avgWordCount": 2400,
        "avgSEOScore": 92,
        "avgReadingTime": 12
      }
    },
    {
      "type": "IIMSchool",
      "displayName": "B-School Pages",
      "file": "app/data/iim-schools-v2.ts",
      "count": 20,
      "agentUsed": "b-school-page-creator",
      "confidence": "high",
      "skillsUsed": ["N/A"],
      "mcpsUsed": [
        "web-search-mcp",
        "reddit-mcp",
        "serena-mcp"
      ],
      "creationPattern": "incremental",
      "examples": [
        {
          "slug": "iim-ahmedabad",
          "title": "IIM Ahmedabad Interview Guide | Rehearsal AI",
          "dateCreated": "2025-12-15",
          "gitCommit": "abc1234"
        }
      ]
    }
  ],
  "summary": {
    "totalContentTypes": 2,
    "totalContentItems": 70,
    "automatedItems": 65,
    "manualItems": 5,
    "agentsIdentified": ["rehearsal-blog-generator", "b-school-page-creator"],
    "skillsIdentified": ["engineering-deep-research", "engineering-article-writer", "engineering-seo-optimizer"],
    "mcpsIdentified": ["reddit-mcp", "web-search-mcp", "lighthouse-mcp", "serena-mcp"]
  }
}
```

---

## Implementation Instructions

### Step 1: Read Data Files

For each file in `dataFiles` array from Phase 1, use **Read tool** to get contents:

```typescript
// For each data file
const content = await readFile(dataFile);
```

**Expected File Formats**:
- TypeScript/JavaScript with exported constants
- Arrays of objects (most common)
- Maps/Records with slug keys

**Example Data File Structure**:
```typescript
// app/data/blog-posts.ts
export const blogPosts: BlogPost[] = [
  {
    slug: 'gap-year-career-pivot-iim-interview-2026',
    title: 'Gap Year Career Pivot IIM Interview 2026',
    category: 'IIM Interviews',
    datePublished: '2026-01-13',
    wordCount: 2400,
    readingTime: 12,
    // ... more fields
  },
  // ... more posts
];
```

---

### Step 2: Identify Content Types

Parse file contents to determine content type:

**Type Detection Strategies**:

1. **TypeScript Interface Detection**:
   - Look for type annotations: `const blogPosts: BlogPost[]`
   - Extract type name: `BlogPost`

2. **File Name Pattern**:
   - `blog-posts.ts` → BlogPost
   - `iim-schools-v2.ts` → IIMSchool
   - `engineering-content.ts` → EngineeringGuide
   - `wat-topics.ts` → WATTopic

3. **Field Analysis**:
   - If has `category: 'Blog'` → BlogPost
   - If has `school name` + `interview style` → IIMSchool
   - If has `topic` + `perspectives` → WATTopic

**Type Naming Convention**:
```typescript
function inferContentType(filepath: string, content: string): string {
  // Extract from TypeScript type annotation
  const typeMatch = content.match(/:\s*(\w+)\[\]/);
  if (typeMatch) {
    return typeMatch[1]; // e.g., "BlogPost", "IIMSchool"
  }

  // Fallback to filename
  const filename = filepath.split('/').pop().replace('.ts', '');
  return filename
    .split('-')
    .map(word => word.charAt(0).toUpperCase() + word.slice(1))
    .join(''); // e.g., "blog-posts" → "BlogPosts"
}
```

**Display Name Mapping**:
```typescript
const displayNames = {
  'BlogPost': 'Blog Posts',
  'IIMSchool': 'B-School Pages',
  'EngineeringGuide': 'Engineering Interview Guides',
  'WATTopic': 'WAT Essay Topics',
  'GDPITopic': 'GDPI Preparation Guides',
  'InterviewQuestion': 'Interview Questions'
};
```

---

### Step 3: Count Content Items

Parse data structures to count items:

**Array Format** (most common):
```typescript
// Count objects in array
const count = (content.match(/\{\s*slug:/g) || []).length;
```

**Map/Record Format**:
```typescript
// Count keys in object
const count = (content.match(/'[\w-]+'\s*:\s*\{/g) || []).length;
```

**Validation**:
- Count should be > 0
- If count is 0, log warning and skip content type

---

### Step 4: Match Content to Git Commits

For each content type, analyze git commits from Phase 2:

**Matching Strategy**:

1. **File Path Match**:
   - Find commits where `filesChanged` includes this data file
   - These commits likely added/modified this content type

2. **Slug Extraction from Commits**:
   - From Phase 2, commits have `contentAdded` array with slugs
   - Match these slugs to content in data file

3. **Date Correlation**:
   - Check if content has `datePublished` or `dateCreated` field
   - Match to commit dates (within 1-2 days tolerance)

**Example Matching Logic**:
```typescript
function matchContentToCommits(
  dataFile: string,
  commits: Commit[]
): ContentCommitMatch[] {
  return commits
    .filter(commit =>
      commit.filesChanged.includes(dataFile) &&
      commit.contentAdded.length > 0
    )
    .map(commit => ({
      commitHash: commit.hash,
      date: commit.date,
      slugsAdded: commit.contentAdded.map(c => c.slug),
      agent: commit.inferredAgent
    }));
}
```

---

### Step 5: Infer Agent/Skills/MCPs Used

Determine which automation tools created this content:

**Agent Inference**:

Priority order:
1. **From Git Commits** (Phase 2):
   - If commits have `inferredAgent` field, use that
   - Most reliable source

2. **From Agent Files** (Phase 1):
   - Read agent files to see which agents work with which data files
   - Example: `b-school-page-creator` mentions `iim-schools-v2.ts`

3. **From Content Patterns**:
   - Batch additions (4+ items in single commit) → likely agent-generated
   - Similar structure across items → likely template-based generation
   - High word counts (2000+ words) → likely agent-generated

**Skills Inference**:

Read agent file to see which skills it invokes:
```typescript
// From .claude/agents/rehearsal-blog-generator.md
function extractSkillsFromAgent(agentFile: string): string[] {
  const content = readFile(agentFile);

  // Look for skill invocations
  const skillMatches = content.match(/\/skill\s+([\w-]+)/g) || [];
  return skillMatches.map(m => m.replace('/skill ', ''));
}
```

**MCPs Inference**:

Read agent file to see which MCPs it uses:
```typescript
function extractMCPsFromAgent(agentFile: string): string[] {
  const content = readFile(agentFile);

  // Look for MCP mentions
  const mcpSections = [
    'MCPs Used:',
    'MCP Servers:',
    '## MCPs',
  ];

  const mcps: string[] = [];
  for (const section of mcpSections) {
    const index = content.indexOf(section);
    if (index !== -1) {
      // Extract list items after section
      const nextSection = content.indexOf('##', index + 1);
      const sectionContent = content.substring(index, nextSection);
      const mcpMatches = sectionContent.match(/-\s*\*\*(\w+-mcp)\*\*/g) || [];
      mcps.push(...mcpMatches.map(m => m.match(/(\w+-mcp)/)[1]));
    }
  }

  return [...new Set(mcps)]; // Remove duplicates
}
```

**Confidence Level**:
- `"high"` - Agent explicitly mentioned in commits or agent file clearly references data file
- `"medium"` - Agent inferred from patterns (batch additions, similar structure)
- `"low"` - Guessing based on weak signals
- `"unknown"` - Cannot determine which agent was used

---

### Step 6: Analyze Creation Patterns

Determine how content was created:

**Pattern Types**:

1. **"batch"** - Multiple items created in single commits
   - Characteristics: 3+ items per commit, regular intervals
   - Example: 4 blog posts added every week

2. **"incremental"** - Items added one at a time
   - Characteristics: 1-2 items per commit, irregular intervals
   - Example: B-school pages added as needed

3. **"bulk"** - All items created in single massive commit
   - Characteristics: 10+ items in one commit
   - Example: Initial data migration

4. **"continuous"** - Steady stream of additions
   - Characteristics: Regular cadence (daily/weekly)
   - Example: Daily blog posts

**Batch Analysis**:
```typescript
function analyzeBatchPattern(commits: Commit[]): BatchInfo {
  const batches = commits.filter(c => c.contentAdded.length >= 3);

  return {
    avgBatchSize: batches.reduce((sum, b) => sum + b.contentAdded.length, 0) / batches.length,
    totalBatches: batches.length,
    frequency: inferFrequency(batches) // 'daily', 'weekly', 'monthly'
  };
}

function inferFrequency(batches: Commit[]): string {
  if (batches.length < 2) return 'one-time';

  const dates = batches.map(b => new Date(b.date));
  const intervals = dates.slice(1).map((d, i) => d.getTime() - dates[i].getTime());
  const avgInterval = intervals.reduce((a, b) => a + b, 0) / intervals.length;

  const days = avgInterval / (1000 * 60 * 60 * 24);

  if (days < 2) return 'daily';
  if (days < 10) return 'weekly';
  if (days < 40) return 'monthly';
  return 'irregular';
}
```

---

### Step 7: Extract Example Content Items

For each content type, extract 2-5 real examples:

**Selection Strategy**:
1. **Prefer Recent**: Select from most recent commits first
2. **Prefer Diverse**: Select from different batches/dates
3. **Prefer Complete**: Select items with full metadata

**Example Extraction**:
```typescript
function extractExamples(
  dataFile: string,
  commits: Commit[],
  limit: number = 3
): Example[] {
  const examples: Example[] = [];

  // Get slugs from recent commits
  const recentCommits = commits
    .sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime())
    .slice(0, 10); // Top 10 recent

  for (const commit of recentCommits) {
    for (const item of commit.contentAdded) {
      if (item.file === dataFile && examples.length < limit) {
        // Read data file to get full item details
        const itemData = extractItemFromDataFile(dataFile, item.slug);

        examples.push({
          slug: item.slug,
          title: itemData.title || itemData.name || item.slug,
          dateCreated: commit.date,
          gitCommit: commit.shortHash,
          ...extractOptionalFields(itemData)
        });
      }
    }

    if (examples.length >= limit) break;
  }

  return examples;
}

function extractOptionalFields(itemData: any): object {
  const fields: any = {};

  if (itemData.wordCount) fields.wordCount = itemData.wordCount;
  if (itemData.readingTime) fields.readingTime = itemData.readingTime;
  if (itemData.seoScore) fields.seoScore = itemData.seoScore;
  if (itemData.category) fields.category = itemData.category;

  return fields;
}
```

---

### Step 8: Calculate Statistics

For each content type, compute aggregate statistics:

**Common Statistics**:
```typescript
function calculateStatistics(items: any[]): Statistics {
  return {
    avgWordCount: avg(items.map(i => i.wordCount).filter(Boolean)),
    avgReadingTime: avg(items.map(i => i.readingTime).filter(Boolean)),
    avgSEOScore: avg(items.map(i => i.seoScore).filter(Boolean)),
    categories: unique(items.map(i => i.category).filter(Boolean)),
    dateRange: {
      earliest: min(items.map(i => i.datePublished || i.dateCreated).filter(Boolean)),
      latest: max(items.map(i => i.datePublished || i.dateCreated).filter(Boolean))
    }
  };
}

function avg(numbers: number[]): number {
  if (numbers.length === 0) return 0;
  return Math.round(numbers.reduce((a, b) => a + b, 0) / numbers.length);
}
```

---

### Step 9: Build Summary

Aggregate across all content types:

```typescript
{
  summary: {
    totalContentTypes: contentTypes.length,
    totalContentItems: contentTypes.reduce((sum, ct) => sum + ct.count, 0),
    automatedItems: contentTypes
      .filter(ct => ct.agentUsed)
      .reduce((sum, ct) => sum + ct.count, 0),
    manualItems: contentTypes
      .filter(ct => !ct.agentUsed)
      .reduce((sum, ct) => sum + ct.count, 0),
    agentsIdentified: unique(contentTypes.map(ct => ct.agentUsed).filter(Boolean)),
    skillsIdentified: unique(contentTypes.flatMap(ct => ct.skillsUsed)),
    mcpsIdentified: unique(contentTypes.flatMap(ct => ct.mcpsUsed))
  }
}
```

---

## Error Handling

### Cannot Read Data File
**Error**: Read tool fails for data file
**Action**: Skip file, add warning: "Could not read {file}"

### Cannot Parse Data File
**Error**: Data file has invalid TypeScript/JavaScript syntax
**Action**: Skip file, add warning: "Could not parse {file}: {error}"

### No Content Found
**Warning**: Data file exists but contains no content items
**Action**: Set count to 0, add info message

### Cannot Infer Agent
**Info**: No git commits or patterns to infer agent from
**Action**: Set agentUsed to null, confidence to "unknown"

### Cannot Extract Examples
**Warning**: No git history or cannot find items in data file
**Action**: Return empty examples array

---

## Special Handling

### Shared Data Structures

Some data files export shared constants (sources, exercises, misconceptions):

```typescript
// Example: wat-topics.ts
export const watWritingSources: WATSource[];
export const watTopics: WATTopic[];
export const watExercises: WATExercise[];
```

**Handling Strategy**:
- Only count primary content array (`watTopics`)
- Note shared structures in metadata
- Don't count support data as separate content type

### Legacy vs V2 Files

Some projects have both old and new versions:
- `iim-schools.ts` (legacy)
- `iim-schools-v2.ts` (current)

**Handling Strategy**:
- Prefer V2/latest version
- Only analyze current version
- Add note about legacy files in warnings

### Complex Data Structures

Some files have nested content:
```typescript
export const schoolData = {
  'iim-ahmedabad': { /* school data */ },
  'iim-bangalore': { /* school data */ },
  // ...
};
```

**Handling Strategy**:
- Count top-level keys as items
- Extract slugs from keys
- Parse nested objects for metadata

---

## Output Format

**Always return valid JSON** with this structure:

```typescript
{
  contentTypes: ContentType[];
  summary: Summary;
  warnings?: string[];
}

interface ContentType {
  type: string;              // BlogPost, IIMSchool, etc.
  displayName: string;       // Human-readable name
  file: string;              // Data file path
  count: number;             // Total items
  agentUsed: string | null;  // Agent name or null
  confidence: 'high' | 'medium' | 'low' | 'unknown';
  skillsUsed: string[];      // Skills invoked by agent
  mcpsUsed: string[];        // MCPs used by agent
  creationPattern: 'batch' | 'incremental' | 'bulk' | 'continuous' | 'unknown';
  batchInfo?: BatchInfo;     // Only if creationPattern is 'batch'
  examples: Example[];       // 2-5 real examples
  statistics?: Statistics;   // Aggregate stats
}

interface BatchInfo {
  avgBatchSize: number;
  totalBatches: number;
  frequency: 'daily' | 'weekly' | 'monthly' | 'irregular' | 'one-time';
}

interface Example {
  slug: string;
  title: string;
  dateCreated: string;
  gitCommit: string;
  [key: string]: any;  // Optional fields (wordCount, seoScore, etc.)
}

interface Statistics {
  avgWordCount?: number;
  avgReadingTime?: number;
  avgSEOScore?: number;
  categories?: string[];
  dateRange?: {
    earliest: string;
    latest: string;
  };
}

interface Summary {
  totalContentTypes: number;
  totalContentItems: number;
  automatedItems: number;
  manualItems: number;
  agentsIdentified: string[];
  skillsIdentified: string[];
  mcpsIdentified: string[];
}
```

---

## Testing

### Test Case 1: Rehearsal AI Project

**Expected Content Types**:
- BlogPost (50+ items)
- IIMSchool (20+ items)
- EngineeringGuide (7+ items)
- WATTopic (22+ items)

**Expected Agents**:
- rehearsal-blog-generator → BlogPost
- b-school-page-creator → IIMSchool
- engineering-content-pipeline → EngineeringGuide

**Expected Patterns**:
- BlogPost: batch (4 per commit, weekly)
- IIMSchool: incremental (1-2 per commit)

### Test Case 2: Minimal Project

**Setup**: 1 data file with 10 items, no git history
**Expected Output**:
- 1 content type with count: 10
- agentUsed: null
- confidence: "unknown"
- creationPattern: "unknown"
- Empty examples array

### Test Case 3: Mixed Automation + Manual

**Expected**:
- Some content types with agentUsed
- Some content types with agentUsed: null
- Correct split in summary (automatedItems vs manualItems)

---

## Performance

**Expected Time**: < 10 seconds for most projects

**Large Projects** (10+ data files, 1000+ items):
- May take 20-30 seconds
- Consider parallelizing file reads

**Optimizations**:
- Cache file reads
- Skip detailed analysis for files with 0 items
- Limit example extraction (default: 3 per type)

---

## Integration with Other Phases

### Input from Phase 1 (Discovery)
- Uses `dataFiles` array to know which files to analyze
- Uses `agents` array to read agent files for skills/MCPs

### Input from Phase 2 (Git Analysis)
- Uses `commits` array to match content to automation
- Uses `inferredAgent` from commits for confidence

### Output to Phase 4 (Doc Generation)
- Provides content type documentation structure
- Provides real examples for each type
- Provides agent/skills/MCPs mappings
- Provides statistics for content sections

---

## Example Usage in Agent

```markdown
## Phase 3: Content Analysis

Analyzing data files to map content to automation...

Found 4 content types:
1. BlogPost (50 items) → rehearsal-blog-generator
2. IIMSchool (20 items) → b-school-page-creator
3. EngineeringGuide (7 items) → engineering-content-pipeline
4. WATTopic (22 items) → unknown agent

Total content items: 99
- Automated: 77 (78%)
- Manual: 22 (22%)

Skills identified: 8 (engineering-deep-research, engineering-article-writer, ...)
MCPs identified: 4 (reddit-mcp, web-search-mcp, lighthouse-mcp, serena-mcp)

Proceeding to Phase 4: Documentation Generation...
```

---

## Limitations

### Cannot Detect
- Content created before git history
- Content modified outside of version control
- Manually created content with no distinguishing features

### May Miss
- Complex nested data structures
- Non-standard file formats
- Content in unexpected locations

### Workarounds
- User can specify custom data file paths
- Manual annotation via agent file comments
- Fallback to "unknown" for uncertain cases

---

## Future Enhancements

### v2.0 Ideas
- Support for database-backed content (analyze DB schemas)
- API endpoint analysis (dynamic content)
- Content quality scoring (beyond SEO metrics)
- Duplicate detection (similar content items)
- Content recommendations (what to create next)

---

## Version

**Skill Version**: 1.0.0
**Last Updated**: January 2026
**Compatible With**: c5-documentation-generator v1.0.0
