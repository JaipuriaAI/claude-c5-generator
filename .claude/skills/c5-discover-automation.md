# C5: Discover Automation Setup

## Purpose
**Phase 1 of C5 Generation** - Discovers automation setup in the codebase.

This skill analyzes the `.claude/` directory to find all agents, skills, hooks, and MCP servers, then auto-detects data files that were likely created with automation.

**Called By**: `c5-documentation-generator` agent (Phase 1)

---

## What It Does

1. **Finds `.claude/` directory** - Locates project's Claude Code configuration
2. **Reads agent files** - Discovers all agents in `.claude/agents/*.md`
3. **Reads skill files** - Discovers all skills in `.claude/skills/*.md`
4. **Reads hook files** - Discovers all hookify hooks in `.claude/hookify.*.md`
5. **Extracts MCP servers** - Parses `settings.local.json` for MCP configuration
6. **Auto-detects data files** - Finds data files using common patterns

---

## Input

**None** - This skill is self-contained and discovers everything automatically.

---

## Output

Returns a JSON object with automation setup:

```json
{
  "agents": [
    {
      "name": "b-school-page-creator",
      "file": ".claude/agents/b-school-page-creator.md",
      "purpose": "Creates comprehensive B-school landing pages",
      "skillsUsed": ["N/A"],
      "mcpsUsed": ["web-search-mcp", "reddit-mcp", "serena-mcp"]
    },
    {
      "name": "rehearsal-blog-generator",
      "file": ".claude/agents/rehearsal-blog-generator.md",
      "purpose": "Researches trending interview topics and creates SEO-optimized blog posts",
      "skillsUsed": ["engineering-deep-research", "engineering-article-writer", "engineering-seo-optimizer"],
      "mcpsUsed": ["reddit-mcp", "web-search-mcp", "lighthouse-mcp"]
    }
  ],
  "skills": [
    {
      "name": "engineering-deep-research",
      "file": ".claude/skills/engineering-deep-research.md",
      "purpose": "Gathers sources from Reddit, Glassdoor, LeetCode"
    },
    {
      "name": "engineering-seo-optimizer",
      "file": ".claude/skills/engineering-seo-optimizer.md",
      "purpose": "Creates SEO-optimized headlines"
    }
  ],
  "hooks": [
    {
      "name": "git-pull-reminder",
      "file": ".claude/hookify.git-pull-reminder.local.md",
      "trigger": "file changes to app/data/",
      "action": "Reminds to pull before editing content"
    },
    {
      "name": "seo-audit-reminder",
      "file": ".claude/hookify.seo-audit-reminder.local.md",
      "trigger": "content changes",
      "action": "Reminds to run SEO audits"
    }
  ],
  "mcps": [
    {
      "name": "reddit-mcp",
      "operations": ["browse_subreddit", "search_reddit", "get_post_details", "user_analysis"]
    },
    {
      "name": "lighthouse-mcp",
      "operations": ["run_audit", "get_performance_score", "get_core_web_vitals"]
    },
    {
      "name": "serena-mcp",
      "operations": ["find_symbol", "read_file", "get_symbols_overview"]
    },
    {
      "name": "web-search-mcp",
      "operations": ["web_search_preview", "web_fetch"]
    }
  ],
  "dataFiles": [
    "app/data/blog-posts.ts",
    "app/data/iim-schools-v2.ts",
    "app/data/engineering-content.ts",
    "app/data/technical-interview-questions.ts"
  ],
  "claudeDirectory": ".claude/"
}
```

---

## Implementation Instructions

### Step 1: Find `.claude/` Directory

Use **Glob tool** to search for `.claude/` directory:

```bash
# Pattern to search
.claude/
```

**Expected**: Directory exists at project root

**If Not Found**: Return error message: "No .claude/ directory found. This project doesn't appear to use Claude Code automation."

---

### Step 2: Read All Agent Files

Use **Glob tool** to find agent files:

```bash
# Pattern to search
.claude/agents/*.md
```

For each agent file found:
1. **Read** the file using Read tool
2. **Extract**:
   - Agent name (from filename, remove `.md`)
   - Purpose (from "Purpose" or "What it does" section)
   - Skills used (look for mentions of `/skill` commands or skill names)
   - MCPs used (look for MCP server names like `reddit-mcp`, `web-search-mcp`)

**Example Parsing**:
```markdown
# B-School Page Creator Agent

## Purpose
Creates comprehensive B-school landing pages

## MCPs Used
- web-search-mcp (for official data)
- reddit-mcp (for student experiences)
```

**Extracted**:
```json
{
  "name": "b-school-page-creator",
  "file": ".claude/agents/b-school-page-creator.md",
  "purpose": "Creates comprehensive B-school landing pages",
  "skillsUsed": ["N/A"],
  "mcpsUsed": ["web-search-mcp", "reddit-mcp"]
}
```

---

### Step 3: Read All Skill Files

Use **Glob tool** to find skill files:

```bash
# Pattern to search
.claude/skills/*.md
```

For each skill file found:
1. **Read** the file using Read tool
2. **Extract**:
   - Skill name (from filename, remove `.md`)
   - Purpose (from "Purpose" or "What it does" section)

**Example Parsing**:
```markdown
# Engineering Deep Research

## Purpose
Gathers sources from Reddit, Glassdoor, LeetCode for interview guides
```

**Extracted**:
```json
{
  "name": "engineering-deep-research",
  "file": ".claude/skills/engineering-deep-research.md",
  "purpose": "Gathers sources from Reddit, Glassdoor, LeetCode"
}
```

---

### Step 4: Read All Hook Files

Use **Glob tool** to find hook files:

```bash
# Pattern to search (hookify hooks)
.claude/hookify.*.md
```

For each hook file found:
1. **Read** the file using Read tool
2. **Extract**:
   - Hook name (from filename, remove `hookify.` prefix and `.local.md` suffix)
   - Trigger condition (from file content)
   - Action performed (from file content)

**Example Parsing**:
```markdown
# Git Pull Reminder Hook

Triggers when: Files in app/data/ are modified
Action: Reminds developer to pull latest changes before editing
```

**Extracted**:
```json
{
  "name": "git-pull-reminder",
  "file": ".claude/hookify.git-pull-reminder.local.md",
  "trigger": "file changes to app/data/",
  "action": "Reminds to pull before editing content"
}
```

---

### Step 5: Extract MCP Servers

Use **Read tool** to read `.claude/settings.local.json`:

```bash
# File to read
.claude/settings.local.json
```

**Parse JSON** to extract MCP servers configuration.

**Example settings.local.json**:
```json
{
  "mcpServers": {
    "reddit-mcp-buddy": {
      "command": "npx",
      "args": ["-y", "reddit-mcp-buddy"],
      "env": {}
    },
    "lighthouse": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-lighthouse"]
    },
    "plugin:serena": {
      "command": "uvx",
      "args": ["serena-mcp-plugin"]
    },
    "Parallel-search-mcp": {
      "command": "uvx",
      "args": ["parallel-search-mcp"]
    }
  }
}
```

**Extracted**:
```json
{
  "mcps": [
    {
      "name": "reddit-mcp",
      "operations": ["browse_subreddit", "search_reddit", "get_post_details", "user_analysis"]
    },
    {
      "name": "lighthouse-mcp",
      "operations": ["run_audit", "get_performance_score", "get_core_web_vitals"]
    },
    {
      "name": "serena-mcp",
      "operations": ["find_symbol", "read_file", "get_symbols_overview"]
    },
    {
      "name": "web-search-mcp",
      "operations": ["web_search_preview", "web_fetch"]
    }
  ]
}
```

**Note**: Operation names are inferred based on common MCP patterns. Can be verified by reading CLAUDE_AGENTIC_SETUP.md if available.

**If settings.local.json Not Found**: Return empty MCPs array.

---

### Step 6: Auto-Detect Data Files

Use **Glob tool** with multiple patterns to find data files:

```bash
# Common data file patterns
app/data/*.ts
app/data/*.js
src/data/*.ts
src/data/*.js
data/*.ts
data/*.js
content/*.ts
content/*.js
lib/data/*.ts
lib/data/*.js
```

**Combine all found files** into `dataFiles` array.

**Filter Criteria**:
- Only include `.ts` and `.js` files
- Exclude test files (`*.test.ts`, `*.spec.ts`)
- Exclude type definition files (`*.d.ts`)
- Prefer files with "data" in path

**Example Found Files**:
```json
{
  "dataFiles": [
    "app/data/blog-posts.ts",
    "app/data/iim-schools-v2.ts",
    "app/data/engineering-content.ts",
    "app/data/technical-interview-questions.ts",
    "app/data/colleges.ts"
  ]
}
```

**If No Data Files Found**: Return empty array (agent will note this in C5 docs).

---

## Error Handling

### No .claude/ Directory
**Error**: "No .claude/ directory found"
**Action**: Return error, suggest user set up Claude Code first

### No Agents/Skills Found
**Warning**: "No agents or skills found in .claude/ directory"
**Action**: Continue with empty arrays, note in output

### settings.local.json Missing
**Warning**: "No settings.local.json found, MCP discovery skipped"
**Action**: Continue with empty MCPs array

### No Data Files Found
**Info**: "No data files detected, will skip content analysis phase"
**Action**: Continue with empty dataFiles array

---

## Output Format

**Always return valid JSON** with this structure:

```typescript
{
  agents: Agent[];
  skills: Skill[];
  hooks: Hook[];
  mcps: MCP[];
  dataFiles: string[];
  claudeDirectory: string;
  errors?: string[];
  warnings?: string[];
}

interface Agent {
  name: string;
  file: string;
  purpose: string;
  skillsUsed: string[];
  mcpsUsed: string[];
}

interface Skill {
  name: string;
  file: string;
  purpose: string;
}

interface Hook {
  name: string;
  file: string;
  trigger: string;
  action: string;
}

interface MCP {
  name: string;
  operations: string[];
}
```

---

## Testing

### Test Case 1: Rehearsal AI Project

**Expected Output**:
- 2 agents (b-school-page-creator, engineering-content-pipeline) + others
- 8 skills (engineering-* skills)
- 2 hooks (git-pull-reminder, seo-audit-reminder)
- 4 MCPs (reddit-mcp, lighthouse-mcp, serena-mcp, web-search-mcp)
- 5+ data files in app/data/

### Test Case 2: Minimal Project

**Setup**: Only 1 agent, no skills, no hooks
**Expected Output**:
- 1 agent
- Empty skills array
- Empty hooks array
- MCPs from settings.local.json
- Data files if detected

### Test Case 3: No Automation

**Setup**: .claude/ directory exists but empty
**Expected Output**:
- Empty agents array with warning
- Empty skills array
- Empty hooks array
- Empty MCPs array
- Empty data files array

---

## Performance

**Expected Time**: < 10 seconds for most projects

**Optimizations**:
- Use Glob tool for fast file discovery
- Parallel reads of multiple files when possible
- Cache parsed JSON (settings.local.json)

---

## Version

**Skill Version**: 1.0.0
**Last Updated**: January 2026
**Compatible With**: c5-documentation-generator v1.0.0
