# C5: Generate Documentation

## Purpose
**Phase 4 of C5 Generation** - Generates C5 markdown files from templates.

This skill takes data from Phases 1-3 and generates comprehensive C5 documentation showing which agents/skills/MCPs were used to create which content.

**Called By**: `c5-documentation-generator` agent (Phase 4)

---

## What It Does

1. **Creates output directory** - Ensures `docs/architecture/` exists
2. **Generates C5 README** - Overview and navigation file
3. **Generates content-type docs** - One file per content type (blog posts, B-school pages, etc.)
4. **Generates workflows doc** - Master reference of all agents/skills/MCPs
5. **Updates architecture README** - Adds C5 navigation section
6. **Writes files to disk** - Saves all generated markdown files

---

## Input

**Required** (from previous phases):
- Phase 1 output: `{ agents, skills, hooks, mcps, dataFiles }`
- Phase 2 output: `{ commits, summary }`
- Phase 3 output: `{ contentTypes, summary }`

**Optional**:
- `outputDir` - Output directory path (default: `docs/architecture/`)
- `includeGitRefs` - Include git commit references (default: true)
- `includeStatistics` - Include content statistics (default: true)

---

## Output

**Files Created**:
```
docs/architecture/
├── c5-README.md                    # C5 overview and navigation (NEW)
├── c5-blog-posts.md                # Blog automation workflow (NEW)
├── c5-bschool-pages.md             # B-school automation workflow (NEW)
├── c5-engineering-guides.md        # Engineering automation workflow (NEW)
├── c5-technical-questions.md       # Technical questions automation (NEW)
└── c5-automation-workflows.md      # Master reference (NEW)

docs/architecture/README.md         # Updated with C5 navigation
```

**Return Value**:
```json
{
  "filesCreated": [
    "docs/architecture/c5-README.md",
    "docs/architecture/c5-blog-posts.md",
    "docs/architecture/c5-bschool-pages.md",
    "docs/architecture/c5-automation-workflows.md"
  ],
  "filesUpdated": [
    "docs/architecture/README.md"
  ],
  "success": true,
  "warnings": []
}
```

---

## Implementation Instructions

### Step 1: Create Output Directory

Use **Bash tool** to ensure directory exists:

```bash
# Create directory if it doesn't exist
mkdir -p docs/architecture
```

**Verify**: Directory now exists at `docs/architecture/`

---

### Step 2: Generate C5 README

Create overview file: `docs/architecture/c5-README.md`

**Template**:

```markdown
# C5: Claude Code Usage Documentation

## What is C5?

**C5 is the 5th level of architecture documentation** (after C4: Context, Container, Component, Code).

While **C4 documents "what can be done"** (design, capabilities, architecture), **C5 documents "what was actually done"** (execution, usage, automation history).

### The Problem C5 Solves

When developers "vibe code" with Claude Code:
- They create content using agents, skills, and MCPs
- The knowledge of HOW to do it lives in their head
- When they leave, new developers can't replicate the process
- Teams lose institutional knowledge about automation workflows

**C5 creates an "automation recipe book"** showing exactly which agents/skills/MCPs were used to create which content, with real examples and step-by-step workflows.

---

## 📊 Project Automation Summary

**Content Created with Automation**: {{AUTOMATED_ITEMS}} / {{TOTAL_ITEMS}} ({{AUTOMATION_PERCENTAGE}}%)

**Automation Tools in Use**:
- **{{AGENT_COUNT}} Agents**: {{AGENT_LIST}}
- **{{SKILL_COUNT}} Skills**: {{SKILL_LIST_ABBREVIATED}}
- **{{MCP_COUNT}} MCP Servers**: {{MCP_LIST}}
- **{{HOOK_COUNT}} Hooks**: {{HOOK_LIST}}

**Content Types Automated**:
{{CONTENT_TYPE_LIST}}

---

## 📖 Navigation

### By Content Type

{{CONTENT_TYPE_NAVIGATION_LINKS}}

### Master Reference

- **[Complete Automation Workflows](c5-automation-workflows.md)** - Full details on all agents, skills, and MCPs

---

## 🚀 Quick Start: How to Use C5

### For New Developers

1. **Identify what you want to create** (blog post, B-school page, etc.)
2. **Find the corresponding C5 document** (see navigation above)
3. **Follow the step-by-step workflow** in that document
4. **Run the agent command** (e.g., `/agent rehearsal-blog-generator`)
5. **Review the generated content** and publish

### For Team Leads

Use C5 to:
- Onboard new developers instantly (no tribal knowledge needed)
- Standardize content creation workflows across team
- Track which automation tools are being used
- Identify opportunities for more automation

---

## 🔍 Quick Reference: Agent → Content Type Mapping

| Content Type | Agent Used | Command |
|-------------|------------|---------|
{{AGENT_CONTENT_TABLE_ROWS}}

---

## 📈 Automation Statistics

**Time Period**: {{DATE_RANGE}}

**Commits Analyzed**: {{TOTAL_COMMITS}}
- Automation commits: {{AUTOMATION_COMMITS}} ({{AUTOMATION_COMMIT_PERCENTAGE}}%)
- Manual commits: {{MANUAL_COMMITS}} ({{MANUAL_COMMIT_PERCENTAGE}}%)

**Most Active Agent**: {{MOST_ACTIVE_AGENT}} ({{MOST_ACTIVE_AGENT_COMMITS}} commits)

**Automation Frequency**: {{AUTOMATION_FREQUENCY}}

---

## 🛠️ Understanding the Workflow

### Typical Agent Workflow

1. **Research Phase** - Agent gathers data from MCPs (Reddit, Web Search, etc.)
2. **Content Creation Phase** - Agent uses skills to write/format content
3. **SEO Optimization Phase** - Agent optimizes for search engines
4. **Validation Phase** - Agent validates quality (Lighthouse audits, etc.)
5. **Output Phase** - Agent adds content to data files

### Skills vs MCPs

- **Skills** - Reusable capabilities (research, writing, SEO optimization)
- **MCPs** - External services (Reddit, Lighthouse, Web Search)
- **Agents** - Orchestrators that combine skills and MCPs

### Hooks

- **Git Pull Reminder** - Ensures you pull latest changes before editing
- **SEO Audit Trigger** - Automatically runs SEO audits after content changes

---

## 📝 Keeping C5 Updated

C5 documentation is regenerated by running:

\`\`\`bash
/agent c5-documentation-generator
\`\`\`

**When to regenerate**:
- After adding new agents/skills
- After major content creation sprints
- Monthly (to capture latest automation activity)

---

## 🤝 Related Documentation

- **[C4 Architecture Docs](README.md)** - System architecture (Context, Container, Component, Code)
- **[Claude Agentic Setup](CLAUDE_AGENTIC_SETUP.md)** - Complete automation capabilities reference
- **[Automation Component](c4-component-automation.md)** - Automation as a system component

---

**C5 Documentation Generated**: {{GENERATION_DATE}}
**Generated by**: C5 Documentation Generator (c5-documentation-generator agent)
```

**Placeholders to Fill**:
- `{{AUTOMATED_ITEMS}}` - From Phase 3 summary
- `{{TOTAL_ITEMS}}` - From Phase 3 summary
- `{{AUTOMATION_PERCENTAGE}}` - Calculated
- `{{AGENT_COUNT}}`, `{{AGENT_LIST}}` - From Phase 1
- `{{SKILL_COUNT}}`, `{{SKILL_LIST_ABBREVIATED}}` - From Phase 1 (truncate if >5)
- `{{MCP_COUNT}}`, `{{MCP_LIST}}` - From Phase 1
- `{{HOOK_COUNT}}`, `{{HOOK_LIST}}` - From Phase 1
- `{{CONTENT_TYPE_LIST}}` - From Phase 3 (bulleted list)
- `{{CONTENT_TYPE_NAVIGATION_LINKS}}` - Generated links to content-type docs
- `{{AGENT_CONTENT_TABLE_ROWS}}` - Table rows mapping agents to content
- `{{DATE_RANGE}}` - From Phase 2 summary
- `{{TOTAL_COMMITS}}`, `{{AUTOMATION_COMMITS}}`, `{{MANUAL_COMMITS}}` - From Phase 2
- `{{AUTOMATION_COMMIT_PERCENTAGE}}`, `{{MANUAL_COMMIT_PERCENTAGE}}` - Calculated
- `{{MOST_ACTIVE_AGENT}}`, `{{MOST_ACTIVE_AGENT_COMMITS}}` - From Phase 2 analysis
- `{{AUTOMATION_FREQUENCY}}` - From Phase 3 batch analysis
- `{{GENERATION_DATE}}` - Current date

---

### Step 3: Generate Content-Type Documents

For each content type from Phase 3, create a separate document:

**File Naming Convention**:
- BlogPost → `c5-blog-posts.md`
- IIMSchool → `c5-bschool-pages.md`
- EngineeringGuide → `c5-engineering-guides.md`
- WATTopic → `c5-wat-topics.md`

**Template** (`c5-{content-type}.md`):

```markdown
# C5: {{CONTENT_TYPE_DISPLAY_NAME}} Created with Claude Code

## Overview

**Content Type**: {{CONTENT_TYPE}}
**Total Created**: {{COUNT}}+
**Agent Used**: `{{AGENT_NAME}}`
**Data File**: `{{DATA_FILE}}`
**Automation Confidence**: {{CONFIDENCE}}

---

## Automation Workflow

### Agent: {{AGENT_NAME}}

{{AGENT_DESCRIPTION}}

**Skills Used**:
{{SKILLS_LIST_WITH_DESCRIPTIONS}}

**MCPs Invoked**:
{{MCPS_LIST_WITH_DESCRIPTIONS}}

**Workflow Steps**:
{{WORKFLOW_STEPS}}

---

## How to Create {{CONTENT_TYPE_DISPLAY_NAME}}

### Command

\`\`\`bash
/agent {{AGENT_NAME}}
\`\`\`

### What Happens

{{WORKFLOW_NARRATIVE}}

### Expected Output

The agent will:
1. Research the topic using {{RESEARCH_MCPS}}
2. Generate {{CONTENT_TYPE_DISPLAY_NAME}} with {{AVG_WORD_COUNT}} words (average)
3. Optimize for SEO (average score: {{AVG_SEO_SCORE}}/100)
4. Add entry to `{{DATA_FILE}}`

### Review Checklist

Before publishing:
- [ ] Content is factually accurate
- [ ] SEO metadata is complete (title, description, keywords)
- [ ] Internal links are working
- [ ] Examples/citations are properly attributed
- [ ] Tone matches brand guidelines

---

## Real Examples

{{EXAMPLES_SECTION}}

---

## Content Statistics

**Total {{CONTENT_TYPE_DISPLAY_NAME}} Created**: {{COUNT}}

{{STATISTICS_TABLE}}

**Creation Pattern**: {{CREATION_PATTERN}}
{{BATCH_INFO_IF_APPLICABLE}}

**Date Range**: {{DATE_RANGE}}

---

## Agent Configuration

### Skills Breakdown

{{SKILLS_DETAILED_LIST}}

### MCP Servers Breakdown

{{MCPS_DETAILED_LIST}}

---

## Troubleshooting

### Agent Not Finding Topics

**Problem**: Agent reports "no trending topics found"
**Solution**: Adjust time range or subreddits in agent configuration

### Generated Content Too Short

**Problem**: Content is < {{MIN_WORD_COUNT}} words
**Solution**: Re-run agent with instruction to expand certain sections

### SEO Score Low

**Problem**: SEO score < 80
**Solution**: Run engineering-seo-optimizer skill manually on generated content

### Data File Conflicts

**Problem**: Git merge conflicts in `{{DATA_FILE}}`
**Solution**: Pull latest changes before running agent (see git-pull-reminder hook)

---

## Extending the Workflow

### Customizing the Agent

Fork the agent file (`.claude/agents/{{AGENT_NAME}}.md`) and modify:
- **Research sources**: Add/remove subreddits or search queries
- **Content length**: Adjust word count targets
- **SEO focus**: Change keyword strategies
- **Output format**: Modify data schema

### Adding New Skills

Create new skills in `.claude/skills/` and invoke from agent with:
\`\`\`bash
/skill your-new-skill
\`\`\`

---

## Related C5 Documentation

{{RELATED_CONTENT_TYPE_LINKS}}

**[← Back to C5 Overview](c5-README.md)**

---

**Last Updated**: {{GENERATION_DATE}}
**Generated by**: C5 Documentation Generator
```

**Placeholders for Content-Type Docs**:
- `{{CONTENT_TYPE_DISPLAY_NAME}}` - e.g., "Blog Posts"
- `{{CONTENT_TYPE}}` - e.g., "BlogPost"
- `{{COUNT}}` - From Phase 3
- `{{AGENT_NAME}}` - From Phase 3
- `{{DATA_FILE}}` - From Phase 3
- `{{CONFIDENCE}}` - From Phase 3
- `{{AGENT_DESCRIPTION}}` - From Phase 1 agent file
- `{{SKILLS_LIST_WITH_DESCRIPTIONS}}` - From Phase 1 skills files
- `{{MCPS_LIST_WITH_DESCRIPTIONS}}` - From Phase 1 MCP list
- `{{WORKFLOW_STEPS}}` - Numbered list (extract from agent file or infer)
- `{{WORKFLOW_NARRATIVE}}` - Prose description of workflow
- `{{RESEARCH_MCPS}}` - MCPs used for research
- `{{AVG_WORD_COUNT}}`, `{{AVG_SEO_SCORE}}` - From Phase 3 statistics
- `{{EXAMPLES_SECTION}}` - From Phase 3 examples (3-5 items)
- `{{STATISTICS_TABLE}}` - Markdown table with stats
- `{{CREATION_PATTERN}}` - From Phase 3
- `{{BATCH_INFO_IF_APPLICABLE}}` - If pattern is "batch", include batch details
- `{{DATE_RANGE}}` - From Phase 3 examples
- `{{SKILLS_DETAILED_LIST}}` - Bulleted list with skill purposes
- `{{MCPS_DETAILED_LIST}}` - Bulleted list with MCP operations
- `{{MIN_WORD_COUNT}}` - Expected minimum
- `{{RELATED_CONTENT_TYPE_LINKS}}` - Links to other content-type docs

---

### Step 4: Generate Automation Workflows Master Reference

Create comprehensive reference: `docs/architecture/c5-automation-workflows.md`

**Template**:

```markdown
# C5: Complete Automation Workflows Reference

## Overview

This document provides complete technical details on all Claude Code automation tools used in this project.

**Quick Links**:
- [Agents](#agents)
- [Skills](#skills)
- [Hookify Hooks](#hooks)
- [MCP Servers](#mcp-servers)

---

## Agents

{{AGENTS_SECTION}}

---

## Skills

{{SKILLS_SECTION}}

---

## Hooks

{{HOOKS_SECTION}}

---

## MCP Servers

{{MCPS_SECTION}}

---

## Workflow Diagrams

### Agent Orchestration Flow

\`\`\`mermaid
graph TD
    User[User] -->|/agent command| Agent[Agent]
    Agent -->|invokes| Skill1[Skill 1]
    Agent -->|invokes| Skill2[Skill 2]
    Skill1 -->|calls| MCP1[MCP Server 1]
    Skill2 -->|calls| MCP2[MCP Server 2]
    Agent -->|writes| DataFile[Data File]
    DataFile -->|triggers| Hook[Hookify Hook]
    Hook -->|validates| DataFile
\`\`\`

### Content Creation Pipeline

{{CONTENT_PIPELINE_DIAGRAM}}

---

## Configuration Files

### Agent Files Location
\`\`\`
.claude/agents/
├── {{AGENT_FILES_LIST}}
\`\`\`

### Skill Files Location
\`\`\`
.claude/skills/
├── {{SKILL_FILES_LIST}}
\`\`\`

### Hook Files Location
\`\`\`
.claude/
├── {{HOOK_FILES_LIST}}
\`\`\`

### MCP Configuration
\`\`\`json
// .claude/settings.local.json
{
  "mcpServers": {
    {{MCP_CONFIG_SNIPPET}}
  }
}
\`\`\`

---

## Usage Patterns

### Pattern 1: Single-Agent Content Generation

\`\`\`bash
# 1. Run agent
/agent {{EXAMPLE_AGENT}}

# 2. Agent automatically:
#    - Invokes skills
#    - Calls MCPs
#    - Generates content
#    - Writes to data file

# 3. Review and commit
git add {{EXAMPLE_DATA_FILE}}
git commit -m "feat: Add content via {{EXAMPLE_AGENT}}"
\`\`\`

### Pattern 2: Multi-Skill Workflow

\`\`\`bash
# 1. Research phase
/skill {{RESEARCH_SKILL}}

# 2. Writing phase
/skill {{WRITING_SKILL}}

# 3. SEO phase
/skill {{SEO_SKILL}}
\`\`\`

### Pattern 3: Hook-Triggered Validation

\`\`\`bash
# 1. Modify data file
# 2. Hook automatically triggers
# 3. Validation runs (git pull check, SEO audit, etc.)
# 4. Warnings displayed if issues found
\`\`\`

---

## Best Practices

### Agent Development

1. **Keep agents focused** - One agent per content type
2. **Reuse skills** - Don't duplicate logic in multiple agents
3. **Document workflows** - Update agent files with clear steps
4. **Test thoroughly** - Validate output before committing

### Skill Development

1. **Make skills atomic** - Each skill does one thing well
2. **Accept parameters** - Make skills configurable
3. **Return structured data** - Use consistent output formats
4. **Handle errors gracefully** - Don't fail silently

### MCP Integration

1. **Cache responses** - Avoid redundant API calls
2. **Rate limit awareness** - Respect API limits
3. **Fallback strategies** - Have backup data sources
4. **Error handling** - MCPs may be unavailable

### Hook Configuration

1. **Keep hooks lightweight** - Fast execution
2. **Non-blocking** - Don't prevent commits
3. **Clear messaging** - Actionable warnings
4. **Scoped triggers** - Only trigger when relevant

---

## Extending the System

### Adding a New Agent

1. Create `.claude/agents/your-agent.md`
2. Define purpose, workflow, skills/MCPs used
3. Test with `/agent your-agent`
4. Update C5 docs with `/agent c5-documentation-generator`

### Adding a New Skill

1. Create `.claude/skills/your-skill.md`
2. Define inputs, outputs, implementation
3. Invoke from agent with `/skill your-skill`
4. Update C5 docs

### Adding a New MCP Server

1. Add to `.claude/settings.local.json`
2. Restart Claude Code
3. Invoke from skills
4. Update C5 docs

### Adding a New Hook

1. Create `.claude/hookify.your-hook.local.md`
2. Define trigger condition and action
3. Test by modifying relevant files
4. Update C5 docs

---

## Troubleshooting

{{TROUBLESHOOTING_SECTION}}

---

**[← Back to C5 Overview](c5-README.md)**

---

**Last Updated**: {{GENERATION_DATE}}
**Generated by**: C5 Documentation Generator
```

**Sections to Generate**:

**{{AGENTS_SECTION}}**:
```markdown
### {{AGENT_NAME}}

**Purpose**: {{AGENT_PURPOSE}}

**File**: `{{AGENT_FILE}}`

**Skills Used**:
{{SKILLS_USED}}

**MCPs Used**:
{{MCPS_USED}}

**Usage**:
\`\`\`bash
/agent {{AGENT_NAME}}
\`\`\`

**Output**: Creates content in `{{DATA_FILE}}`

---
```

**{{SKILLS_SECTION}}**:
```markdown
### {{SKILL_NAME}}

**Purpose**: {{SKILL_PURPOSE}}

**File**: `{{SKILL_FILE}}`

**Used By**: {{AGENTS_USING_THIS_SKILL}}

**Usage**:
\`\`\`bash
/skill {{SKILL_NAME}}
\`\`\`

---
```

**{{HOOKS_SECTION}}**:
```markdown
### {{HOOK_NAME}}

**Trigger**: {{TRIGGER_CONDITION}}

**Action**: {{ACTION_DESCRIPTION}}

**File**: `{{HOOK_FILE}}`

---
```

**{{MCPS_SECTION}}**:
```markdown
### {{MCP_NAME}}

**Operations**: {{OPERATIONS_LIST}}

**Used By**: {{AGENTS_OR_SKILLS_USING_THIS_MCP}}

**Configuration**:
\`\`\`json
{{MCP_CONFIG}}
\`\`\`

---
```

---

### Step 5: Update Architecture README

Add C5 navigation to existing `docs/architecture/README.md`:

**Insert After Line 42** (after "Start with Automation" section):

```markdown
---

## Level 5: C5 (Claude Code Usage)

### [C5 Usage Documentation](c5-README.md)

**What it shows:** Actual automation usage - which agents/skills/MCPs created which content

**Contents:**
- Overview of C5 concept (execution vs capabilities)
- Project automation summary ({{AUTOMATED_ITEMS}}/{{TOTAL_ITEMS}} automated)
- Navigation to content-type workflows
- Agent → content type mapping
- Automation statistics and timeline

**Read this if:**
- You're new to the team and need to create content
- You want to replicate existing automation workflows
- You're onboarding other developers
- You need to understand what agents do

**Content-Type Workflows:**
{{CONTENT_TYPE_LINKS_IN_README}}

**Master Reference:**
- [Complete Automation Workflows](c5-automation-workflows.md) - All agents, skills, hooks, MCPs

---
```

**Implementation**:
1. Read existing `docs/architecture/README.md`
2. Find insertion point (after line 42 or after "Start with Automation" section)
3. Insert C5 navigation section
4. Write updated content back to file

---

### Step 6: Write Files to Disk

Use **Write tool** to create all files:

```typescript
// For each file generated:
await writeFile(filepath, content);

// Track created files
filesCreated.push(filepath);
```

**Files to Write**:
1. `docs/architecture/c5-README.md`
2. `docs/architecture/c5-{content-type}.md` (one per content type)
3. `docs/architecture/c5-automation-workflows.md`
4. `docs/architecture/README.md` (update existing)

---

## Template Helper Functions

### Generate Content Type Navigation Links

```typescript
function generateContentTypeLinks(contentTypes: ContentType[]): string {
  return contentTypes
    .map(ct => `- **[${ct.displayName}](c5-${slugify(ct.displayName)}.md)** - ${ct.count}+ items created with \`${ct.agentUsed || 'unknown agent'}\``)
    .join('\n');
}
```

### Generate Agent-Content Mapping Table

```typescript
function generateAgentContentTable(contentTypes: ContentType[]): string {
  const rows = contentTypes
    .filter(ct => ct.agentUsed)
    .map(ct => `| ${ct.displayName} | \`${ct.agentUsed}\` | \`/agent ${ct.agentUsed}\` |`);

  return rows.join('\n');
}
```

### Generate Examples Section

```typescript
function generateExamplesSection(examples: Example[]): string {
  return examples.map((ex, i) => `
### Example ${i + 1}: ${ex.title}

**Created**: ${ex.dateCreated}
**Slug**: \`${ex.slug}\`
${ex.gitCommit ? `**Git Commit**: \`${ex.gitCommit}\`\n` : ''}
${ex.wordCount ? `**Word Count**: ${ex.wordCount} words\n` : ''}
${ex.readingTime ? `**Reading Time**: ${ex.readingTime} minutes\n` : ''}
${ex.seoScore ? `**SEO Score**: ${ex.seoScore}/100\n` : ''}

**Agent Used**: \`${ex.agentUsed || 'unknown'}\`
**Skills Used**: ${ex.skillsUsed?.join(', ') || 'N/A'}
**MCPs Used**: ${ex.mcpsUsed?.join(', ') || 'N/A'}
`).join('\n---\n');
}
```

### Generate Statistics Table

```typescript
function generateStatisticsTable(stats: Statistics): string {
  const rows = [];

  if (stats.avgWordCount) {
    rows.push(`| Average Word Count | ${stats.avgWordCount} |`);
  }
  if (stats.avgReadingTime) {
    rows.push(`| Average Reading Time | ${stats.avgReadingTime} minutes |`);
  }
  if (stats.avgSEOScore) {
    rows.push(`| Average SEO Score | ${stats.avgSEOScore}/100 |`);
  }
  if (stats.categories) {
    rows.push(`| Categories | ${stats.categories.join(', ')} |`);
  }

  return `| Metric | Value |\n|--------|-------|\n${rows.join('\n')}`;
}
```

### Slugify Function

```typescript
function slugify(text: string): string {
  return text
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '');
}
```

---

## Error Handling

### Cannot Create Directory
**Error**: `mkdir` fails (permissions issue)
**Action**: Return error, suggest user creates directory manually

### Cannot Write File
**Error**: Write tool fails for a file
**Action**: Skip file, add to warnings, continue with other files

### Cannot Read Existing README
**Error**: `docs/architecture/README.md` doesn't exist
**Action**: Create new README with C5 section only

### Template Placeholder Missing Data
**Warning**: Data from previous phases is null/undefined
**Action**: Replace placeholder with "N/A" or "Unknown", add warning

---

## Validation

### Before Writing Files

**Validate**:
1. All placeholder values are filled (no `{{PLACEHOLDER}}` in final output)
2. Markdown syntax is valid (no unclosed code blocks, broken links)
3. File paths are correct (use forward slashes, absolute from project root)
4. Content-type filenames match convention (`c5-{slug}.md`)

### After Writing Files

**Check**:
1. All files exist on disk
2. File sizes are reasonable (> 1KB, typically 5-20KB)
3. No empty files created

---

## Output Format

**Always return valid JSON**:

```typescript
{
  filesCreated: string[];    // Paths of new files
  filesUpdated: string[];    // Paths of updated files
  success: boolean;          // Overall success
  warnings?: string[];       // Non-fatal issues
  errors?: string[];         // Fatal issues
}
```

---

## Testing

### Test Case 1: Rehearsal AI Project

**Expected Files Created**:
- `c5-README.md`
- `c5-blog-posts.md`
- `c5-bschool-pages.md`
- `c5-engineering-guides.md`
- `c5-wat-topics.md`
- `c5-automation-workflows.md`

**Expected File Updated**:
- `docs/architecture/README.md`

**Validation**:
- All placeholders filled
- Examples section has 3+ items per content type
- Agent-content mapping table has 3+ rows

### Test Case 2: Minimal Project

**Setup**: 1 content type, 1 agent, no git history

**Expected Files Created**:
- `c5-README.md` (basic)
- `c5-{content-type}.md` (1 file)
- `c5-automation-workflows.md` (1 agent, no commits section)

**Expected**: No errors, minimal warnings

### Test Case 3: No Architecture Directory

**Setup**: Project has no `docs/` folder

**Expected**:
- Create `docs/architecture/` directory
- Create all C5 files
- Create new `README.md` (C5 section only)

---

## Performance

**Expected Time**: < 5 seconds for most projects

**File Generation**:
- C5 README: ~5KB (instant)
- Content-type docs: ~10-15KB each (1-2 seconds total)
- Automation workflows: ~20-30KB (1-2 seconds)
- README update: ~500 bytes (instant)

**Total Output**: ~50-100KB (5-7 markdown files)

---

## Integration with Other Phases

### Input from Phase 1 (Discovery)
- Uses agent/skill/hook/MCP data for workflows doc
- Uses agent files to extract workflow descriptions

### Input from Phase 2 (Git Analysis)
- Uses commits for examples section (git commit references)
- Uses summary for automation statistics

### Input from Phase 3 (Content Analysis)
- Uses content types for navigation and content-type docs
- Uses examples for real content showcase
- Uses statistics for aggregate data

---

## Example Usage in Agent

```markdown
## Phase 4: Documentation Generation

Generating C5 markdown files...

Creating directory: docs/architecture/

Writing files:
✓ c5-README.md (7.2 KB)
✓ c5-blog-posts.md (12.4 KB)
✓ c5-bschool-pages.md (10.1 KB)
✓ c5-engineering-guides.md (9.8 KB)
✓ c5-automation-workflows.md (24.5 KB)
✓ README.md (updated, +800 bytes)

Total: 6 files created/updated (64.0 KB)

C5 documentation generation complete!

📖 View the docs:
- Overview: docs/architecture/c5-README.md
- Workflows: docs/architecture/c5-automation-workflows.md

Next step: Test the agent on your project!
```

---

## Limitations

### Cannot Generate
- Interactive diagrams (only Mermaid in markdown)
- Custom CSS/styling
- Dynamic content (all static markdown)

### May Not Capture
- Complex workflows requiring multiple manual steps
- Undocumented agent configurations
- Agents that were used but left no git history

---

## Future Enhancements

### v2.0 Ideas
- Interactive HTML output (searchable, filterable)
- PDF generation for offline reference
- Diagram generation from workflow data
- Integration with project wikis (Notion, Confluence)
- Automated C5 regeneration via GitHub Actions

---

## Version

**Skill Version**: 1.0.0
**Last Updated**: January 2026
**Compatible With**: c5-documentation-generator v1.0.0
