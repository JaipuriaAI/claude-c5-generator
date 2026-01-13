# C5 Documentation Generator Agent

## Purpose
Generates **C5 (Claude Code Usage)** documentation for ANY codebase, showing which agents/skills/MCPs were used to create which content.

**C5 = Fifth level of architecture documentation** (after C4: Context, Container, Component, Code)
- **C4** documents "what can be done" (design, capabilities, architecture)
- **C5** documents "what was actually done" (execution, usage, automation history)

**Problem Solved**: When developers "vibe code" with Claude Code, automation knowledge lives in their head. When they leave, new developers can't replicate workflows. C5 creates an "automation recipe book" for instant team onboarding.

---

## Usage

```bash
/agent c5-documentation-generator
```

**Interactive Mode**: The agent will ask clarifying questions if needed.

**Configuration (Optional)**:
You can set these preferences when the agent asks:
- Output directory (default: `docs/architecture/`)
- Include git history analysis (default: yes)
- Custom data file paths (default: auto-detect)

---

## What It Does

This agent automatically:

1. **Discovers** your automation setup (`.claude/` directory)
   - Finds all agents, skills, hooks
   - Extracts MCP servers from settings
   - Auto-detects data files

2. **Analyzes** git history (optional)
   - Finds automation commits
   - Maps commits to content changes
   - Infers which agents created which content

3. **Maps** content to agents/skills/MCPs
   - Counts content items (blog posts, pages, etc.)
   - Matches content to git commits
   - Extracts real examples with dates

4. **Generates** 5-7 C5 markdown files
   - Overview documentation
   - Per-content-type workflows
   - Master automation reference
   - Navigation updates

---

## Output

The agent creates these files in `docs/architecture/`:

```
docs/architecture/
├── c5-README.md                    # C5 overview and navigation
├── c5-blog-posts.md                # How blog posts were created (if detected)
├── c5-bschool-pages.md             # How B-school pages were created (if detected)
├── c5-engineering-guides.md        # How engineering guides were created (if detected)
├── c5-technical-questions.md       # How technical questions were created (if detected)
└── c5-automation-workflows.md      # Master reference of all agents/skills/MCPs
```

Each C5 document shows:
- **Which agent** was used (e.g., `rehearsal-blog-generator`)
- **Which skills** it invoked (e.g., `engineering-deep-research`, `engineering-seo-optimizer`)
- **Which MCPs** it used (e.g., `reddit-mcp`, `web-search-mcp`, `lighthouse-mcp`)
- **Step-by-step workflow** (Research → Write → SEO → Validate)
- **Real examples** with slugs, dates, git commit references
- **How to replicate** (command + expected output)

---

## Requirements

### Must Have
- Project with `.claude/` directory
- At least 1 agent or skill in `.claude/agents/` or `.claude/skills/`

### Optional (Enhances Output)
- Git history available (for commit analysis)
- Data files in common locations (`app/data/`, `src/data/`, `data/`)
- Content created with automation (to document actual usage)

### Works With
- Any programming language/framework
- Any content type (blogs, pages, API docs, etc.)
- Any MCP servers
- Any agent/skill structure

---

## Workflow

### Phase 1: Discovery (via c5-discover-automation skill)

**Goal**: Understand the project's automation setup

**Actions**:
- Finds `.claude/` directory
- Reads all agent files (`.claude/agents/*.md`)
- Reads all skill files (`.claude/skills/*.md`)
- Reads all hook files (`.claude/hookify.*.md`)
- Parses `settings.local.json` for MCP servers
- Auto-detects data files using common patterns

**Output**: JSON object with agents, skills, hooks, MCPs, data files

---

### Phase 2: Git History Analysis (via c5-analyze-git-history skill)

**Goal**: Find automation commits and map to content

**Actions**:
- Searches git log for automation-related commits (keywords: "feat:", "agent", "automation")
- Extracts commit metadata (hash, date, message, files changed)
- Infers agent names from commit messages
- Maps commits to data files changed
- Identifies content added (slugs, entries)

**Output**: JSON array of automation commits with metadata

**Skipped If**: No git history or user opts out

---

### Phase 3: Content Analysis (via c5-analyze-content skill)

**Goal**: Map content to agents/skills/MCPs

**Actions**:
- Reads data files to identify content types
- Counts items (e.g., 50 blog posts, 20 B-school pages)
- Matches content to git commits via dates and file paths
- Infers which agent/skills/MCPs were used by:
  - Reading agent files to see which skills they invoke
  - Checking commit messages for agent names
  - Analyzing content patterns (batch additions → likely agent-generated)
- Extracts real examples (slugs, dates, commit hashes)

**Output**: JSON object with content types, counts, agent mappings, examples

---

### Phase 4: Documentation Generation (via c5-generate-docs skill)

**Goal**: Write C5 markdown files

**Actions**:
- Creates `docs/architecture/` directory if needed
- Generates C5 markdown files from templates
- Fills templates with data from Phases 1-3
- Writes files to disk
- Updates `docs/architecture/README.md` to add C5 navigation

**Output**: 5-7 markdown files + updated architecture README

---

## Skills Invoked

This agent orchestrates 4 specialized skills:

1. **c5-discover-automation** - Phase 1: Discovers automation setup
2. **c5-analyze-git-history** - Phase 2: Analyzes git commits
3. **c5-analyze-content** - Phase 3: Maps content to agents
4. **c5-generate-docs** - Phase 4: Writes C5 markdown files

Each skill is modular and can be customized independently.

---

## Model Configuration

**Model**: Claude Opus (claude-opus-4-5-20251101)

**Why Opus**:
- Complex multi-phase analysis required
- Large codebases with many files
- Sophisticated git history parsing
- Template-based documentation generation
- Context retention across 4 phases

**Token Usage**: ~50,000-100,000 tokens (varies by project size)

---

## Example Generated C5

### Example: Blog Posts Documentation

```markdown
# C5: Blog Posts Created with Claude Code

## Overview

**Content Type**: Blog Posts
**Total Created**: 50+
**Agent Used**: `rehearsal-blog-generator`
**Data File**: `/app/data/blog-posts.ts`

## Automation Workflow

### Agent: rehearsal-blog-generator

**Skills Used**:
1. **engineering-deep-research** - Gathers sources from Reddit, Glassdoor, LeetCode
2. **engineering-article-writer** - Writes research-backed articles with citations
3. **engineering-seo-optimizer** - Creates SEO-optimized headlines
4. **engineering-seo-implementation** - Adds meta tags, keywords, structured data

**MCPs Invoked**:
1. **reddit-mcp** - Searches r/CAT_Preparation, r/MBA for trending topics
2. **web-search-mcp** - Gathers statistics, research papers, IIM placement reports
3. **lighthouse-mcp** - Validates SEO quality after generation

**Workflow Steps**:
1. **Research Phase**: Agent searches Reddit for trending interview topics
2. **Writing Phase**: Creates long-form content (2,000-3,000 words) with research citations
3. **SEO Phase**: Optimizes headlines, meta tags, keywords for search visibility
4. **Output**: Adds BlogPost entry to blog-posts.ts with complete metadata

## How to Create a Blog Post

### Command
```bash
/agent rehearsal-blog-generator
```

### What Happens
1. Agent researches Reddit for trending topics
2. Agent generates SEO-optimized blog post
3. Agent adds post to `/app/data/blog-posts.ts`
4. You review and publish

## Real Examples

### Example 1: Gap Year Career Pivot Post
**Created**: 2026-01-13
**Slug**: `gap-year-career-pivot-iim-interview-2026`
**Git Commit**: `9744db6`
**Agent**: rehearsal-blog-generator
**Skills Used**: engineering-deep-research, engineering-article-writer, engineering-seo-optimizer
**MCPs Used**: reddit-mcp (3 searches in r/CAT_Preparation), web-search-mcp (5 web searches)
**Result**: 2,400-word article with 12-minute reading time, SEO score 95/100

## Content Statistics

- **Total Blog Posts Created**: 50+
- **Avg Word Count**: 2,400 words
- **Avg SEO Score**: 92/100
- **Topics Covered**: IIM interviews, GDPI preparation, career pivots
```

---

## Customization

### For Your Project
Fork and customize the 4 skills to adjust:
- **Template formatting** - Change markdown structure/style
- **Git commit parsing** - Adjust regex patterns for your commit message format
- **Content type detection** - Add custom data file patterns
- **Output structure** - Change directory structure or file naming

### Sharing With Others
This agent can be shared as a standalone package:
1. Copy `.claude/agents/c5-documentation-generator.md` (this file)
2. Copy `.claude/skills/c5-*.md` (4 skill files)
3. Users install in their `.claude/` directory
4. Works with any codebase using Claude Code

---

## Distribution

**GitHub Repository**: https://github.com/yourusername/claude-c5-generator

**Installation** (for users):
```bash
# Clone the repo
git clone https://github.com/yourusername/claude-c5-generator

# Copy to your project
cp -r claude-c5-generator/.claude/agents/c5-documentation-generator.md .claude/agents/
cp -r claude-c5-generator/.claude/skills/c5-*.md .claude/skills/

# Run the agent
/agent c5-documentation-generator
```

**Universal Tool**: Works in any project with `.claude/` directory, not just this one.

---

## Benefits

### For Teams
- **Instant Onboarding**: New developers see exact workflows used
- **Knowledge Transfer**: "Vibe coding" knowledge becomes documented
- **Process Replication**: Anyone can replicate content creation

### For Community
- **Standardized Format**: C5 becomes standard across Claude Code projects
- **Learn From Others**: See how successful projects use automation
- **Best Practices**: Build ecosystem of automation patterns

### For You
- **Recognition**: Pioneer the C5 standard
- **Help Others**: Enable thousands of developers worldwide
- **Open Source**: Contribute to Claude Code ecosystem

---

## Troubleshooting

### "No .claude/ directory found"
**Solution**: Create `.claude/agents/` or `.claude/skills/` directory first

### "No content detected"
**Solution**: The agent looks for common data file patterns. Specify custom paths when prompted.

### "Git history analysis failed"
**Solution**: Either run `git init` or opt out of git analysis when prompted

### "Generated docs are empty"
**Solution**: Make sure you have agents/skills with actual usage. The agent documents actual automation, not potential automation.

---

## Support

- **Issues**: https://github.com/yourusername/claude-c5-generator/issues
- **Discussions**: https://github.com/yourusername/claude-c5-generator/discussions
- **Contributing**: Pull requests welcome!

---

## License

MIT License - Use freely in any project

---

## Created By

**Shiva Kakkar** - Innovating automation documentation for Claude Code
- GitHub: [@yourusername](https://github.com/yourusername)
- X: [@yourusername](https://x.com/yourusername)

---

**Version**: 1.0.0
**Last Updated**: January 2026
**Model**: Claude Opus (claude-opus-4-5-20251101)
