# C5 Documentation Generator

**Automatically generate C5 (Claude Code Usage) documentation for ANY codebase.**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code](https://img.shields.io/badge/Claude-Code-orange)](https://claude.ai/claude-code)

## What is C5?

**C5 is the 5th level of architecture documentation** (after C4: Context, Container, Component, Code).

While **C4 documents "what can be done"** (capabilities, design, architecture), **C5 documents "what was actually done"** (execution history, automation usage).

### The Problem C5 Solves

When developers "vibe code" with Claude Code:
- They create content using agents, skills, and MCPs
- The knowledge of **HOW** they did it lives in their head
- When they leave, new developers can't replicate the process
- Teams lose institutional knowledge about automation workflows

**C5 creates an "automation recipe book"** showing exactly which agents/skills/MCPs were used to create which content, with real examples and step-by-step workflows.

---

## Quick Start

### 1. Install the Agent & Skills

```bash
# Clone this repository
git clone https://github.com/yourusername/claude-c5-generator
cd claude-c5-generator

# Copy to your project's .claude/ directory
cp -r .claude/agents/c5-documentation-generator.md /path/to/your-project/.claude/agents/
cp -r .claude/skills/c5-*.md /path/to/your-project/.claude/skills/
```

**Or use the installation script:**

```bash
./install.sh /path/to/your-project
```

### 2. Run the Agent

```bash
# In your project directory
cd /path/to/your-project
/agent c5-documentation-generator
```

### 3. View Your C5 Documentation

The agent creates 5-7 markdown files in `docs/architecture/`:

```
docs/architecture/
├── c5-README.md                    # C5 overview and navigation
├── c5-{content-type}.md            # Per-content-type workflows
└── c5-automation-workflows.md      # Master reference
```

---

## What It Does

The C5 Documentation Generator analyzes your project and creates comprehensive documentation showing:

- **Which agents** were used to create which content
- **Which skills and MCPs** each agent invoked
- **Real examples** with git commit references
- **Step-by-step workflows** for replicating content creation
- **Automation statistics** (batch sizes, frequencies, dates)

### 4-Phase Pipeline

1. **Discovery Phase** - Scans `.claude/` directory for agents, skills, hooks, MCPs
2. **Git Analysis Phase** - Analyzes commit history for automation usage
3. **Content Analysis Phase** - Maps content to agents/skills/MCPs
4. **Documentation Generation Phase** - Creates 5-7 C5 markdown files

---

## Requirements

### Must Have
- Project with `.claude/` directory
- At least 1 agent or skill in `.claude/agents/` or `.claude/skills/`

### Optional (Enhances Output)
- Git history available (for commit analysis and examples)
- Data files in common locations (`app/data/`, `src/data/`, `data/`)
- Content created with automation (to document actual usage)

### Works With
- **Any programming language** (TypeScript, Python, JavaScript, etc.)
- **Any framework** (Next.js, React, Django, etc.)
- **Any content type** (blogs, pages, API docs, etc.)
- **Any MCP servers** (Reddit, Lighthouse, Web Search, custom MCPs)

---

## Example Output

See real C5 documentation generated for the [Rehearsal AI project](examples/rehearsal-ai/):

- **[c5-README.md](examples/rehearsal-ai/c5-README.md)** - Overview (98/122 items automated - 80%)
- **[c5-blog-posts.md](examples/rehearsal-ai/c5-blog-posts.md)** - 52+ blog posts workflow
- **[c5-bschool-pages.md](examples/rehearsal-ai/c5-bschool-pages.md)** - 36+ B-school pages workflow
- **[c5-engineering-guides.md](examples/rehearsal-ai/c5-engineering-guides.md)** - 10+ engineering guides workflow
- **[c5-automation-workflows.md](examples/rehearsal-ai/c5-automation-workflows.md)** - Master reference

**Project Stats**:
- 3 agents documented
- 12 skills documented
- 4 MCP servers documented
- 20+ automation commits analyzed
- 122 total content items mapped

---

## How It Works

### Phase 1: Discovery

Discovers all automation tools in your project:

```bash
# Finds:
.claude/agents/*.md          # All agents
.claude/skills/*.md          # All skills
.claude/hookify.*.md         # Hookify hooks
.claude/settings.local.json  # MCP servers
app/data/*.ts                # Data files (auto-detected)
```

**Output**: JSON object with agents, skills, hooks, MCPs, data files

### Phase 2: Git History Analysis

Analyzes git commits to find automation usage:

```bash
# Searches for:
- Commits with "feat:", "agent", "automation" keywords
- Files changed (data files)
- Content added (slugs, entries)
- Agent names in commit messages
```

**Output**: JSON array of automation commits with metadata

### Phase 3: Content Analysis

Maps content to agents/skills/MCPs:

```bash
# Analyzes:
- Data file structure (BlogPost, IIMSchool, etc.)
- Content counts (50 blog posts, 36 B-school pages)
- Creation patterns (batch, incremental, bulk)
- Agent/skills/MCPs used (inferred from commits + agent files)
```

**Output**: JSON object with content types, examples, statistics

### Phase 4: Documentation Generation

Generates C5 markdown files:

```bash
# Creates:
docs/architecture/c5-README.md              # Overview
docs/architecture/c5-{content-type}.md      # Per-content workflows
docs/architecture/c5-automation-workflows.md # Master reference
```

Updates `docs/architecture/README.md` with C5 navigation

---

## Configuration

### Optional Parameters

When running the agent, you can specify:

- `outputDir` - Output directory (default: `docs/architecture/`)
- `includeGitAnalysis` - Analyze git history (default: true)
- `dataFilePaths` - Custom data file paths (default: auto-detect)

### Customization

Fork the skills to customize:

- **Template formatting** - Change markdown structure/style
- **Git commit parsing** - Adjust regex patterns for your commit format
- **Content type detection** - Add custom data file patterns
- **Output structure** - Change directory structure or file naming

---

## Use Cases

### For Individual Developers
- Document your automation workflows for future reference
- Create onboarding guides for new team members
- Share automation patterns with the community

### For Teams
- **Instant onboarding**: New developers see exact workflows used
- **Knowledge transfer**: "Vibe coding" knowledge becomes documented
- **Process replication**: Anyone can replicate content creation

### For Open Source Projects
- Show contributors how automation is used
- Document agent/skill/MCP configurations
- Build community around automation patterns

---

## FAQ

### Q: Does this work on projects without git history?

**A:** Yes! Git analysis (Phase 2) is optional. The agent can still generate C5 docs using Phase 1 (discovery) and Phase 3 (content analysis) alone.

### Q: What if my data files are in non-standard locations?

**A:** The agent auto-detects common patterns (`app/data/`, `src/data/`, `data/`). For custom locations, you can specify `dataFilePaths` parameter.

### Q: Can I use this on private codebases?

**A:** Absolutely! The agent runs entirely locally. Generated C5 docs stay in your project directory.

### Q: How often should I regenerate C5 docs?

**A:** Regenerate after:
- Adding new agents/skills
- Major content creation sprints
- Monthly (to capture latest automation activity)

### Q: Can I customize the generated documentation?

**A:** Yes! Fork the 4 skills (`.claude/skills/c5-*.md`) and modify:
- Templates (Phase 4: c5-generate-docs.md)
- Git parsing logic (Phase 2: c5-analyze-git-history.md)
- Content detection (Phase 3: c5-analyze-content.md)

---

## Contributing

Contributions are welcome! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

**Ways to contribute**:
- Add support for new data file patterns
- Improve git commit parsing
- Add new template styles
- Report bugs or suggest features
- Share your C5 examples

---

## Roadmap

### v1.0.0 (Current)
- ✅ 4-phase pipeline (Discovery, Git Analysis, Content Analysis, Doc Generation)
- ✅ Universal design (works on any codebase)
- ✅ Auto-detection of agents, skills, hooks, MCPs
- ✅ Git history analysis
- ✅ Content type mapping
- ✅ Template-based documentation generation

### v2.0.0 (Planned)
- [ ] Interactive HTML output (searchable, filterable)
- [ ] PDF generation for offline reference
- [ ] Diagram generation from workflow data
- [ ] Integration with project wikis (Notion, Confluence)
- [ ] Automated C5 regeneration via GitHub Actions
- [ ] Multi-repo support (monorepo analysis)
- [ ] Database-backed content analysis

---

## Real-World Examples

### Rehearsal AI (Interview Prep Platform)

**Automation Summary**:
- 98/122 items automated (80%)
- 3 agents (b-school-page-creator, engineering-content-pipeline, c5-documentation-generator)
- 12 skills (engineering-*, c5-*)
- 4 MCP servers (reddit-mcp-buddy, Parallel-search-mcp, lighthouse, plugin:serena)

**Content Created**:
- 52 blog posts (batch creation, 4-14 per commit)
- 36 B-school pages (incremental, 1-6 per commit)
- 10 engineering guides (7-phase pipeline)

**See full C5 documentation**: [examples/rehearsal-ai/](examples/rehearsal-ai/)

### Your Project Here

Generated C5 documentation for your project? Share it with the community!

Submit a PR to add your example to `examples/` directory.

---

## Technical Details

### Model Requirements

The agent uses **Claude Opus** for complex multi-phase analysis:
- Phase 1 (Discovery): Haiku would work
- Phase 2 (Git Analysis): Sonnet recommended
- Phase 3 (Content Analysis): Opus recommended
- Phase 4 (Doc Generation): Opus required

**Token Usage**: ~50,000-100,000 tokens (varies by project size)

### Performance

- **Discovery Phase**: < 10 seconds
- **Git Analysis Phase**: < 5 seconds (3 months history)
- **Content Analysis Phase**: < 10 seconds
- **Doc Generation Phase**: < 5 seconds

**Total**: ~30-45 seconds for most projects

---

## License

MIT License - see [LICENSE](LICENSE) for details.

Use freely in any project, commercial or non-commercial.

---

## Support

- **Issues**: https://github.com/yourusername/claude-c5-generator/issues
- **Discussions**: https://github.com/yourusername/claude-c5-generator/discussions
- **Twitter/X**: [@yourusername](https://twitter.com/yourusername)

---

## Acknowledgments

Created by **Shiva Kakkar** as part of the [Rehearsal AI](https://tryrehearsal.ai) project.

Inspired by the need to document "vibe coding" workflows and transfer automation knowledge across teams.

Special thanks to:
- Anthropic team for Claude Code
- Claude Code community for feedback
- Early adopters and contributors

---

## Star History

If you find this tool useful, please consider starring the repository!

[![Star History Chart](https://api.star-history.com/svg?repos=yourusername/claude-c5-generator&type=Date)](https://star-history.com/#yourusername/claude-c5-generator&Date)

---

**Built with Claude Code** 🤖
