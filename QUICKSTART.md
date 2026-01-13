# Quick Start Guide

Get up and running with C5 Documentation Generator in 5 minutes.

## Prerequisites

- Claude Code installed
- Project with `.claude/` directory (or create one)
- (Optional) Git repository for better results

## Installation

### Option 1: Using Installation Script (Recommended)

```bash
# Clone the repository
git clone https://github.com/yourusername/claude-c5-generator
cd claude-c5-generator

# Run installation script
./install.sh /path/to/your-project

# Navigate to your project
cd /path/to/your-project

# Run the agent
/agent c5-documentation-generator
```

### Option 2: Manual Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/claude-c5-generator
cd claude-c5-generator

# Copy agent
cp .claude/agents/c5-documentation-generator.md /path/to/your-project/.claude/agents/

# Copy skills
cp .claude/skills/c5-*.md /path/to/your-project/.claude/skills/

# Navigate to your project
cd /path/to/your-project

# Run the agent
/agent c5-documentation-generator
```

## First Run

When you run the agent for the first time:

1. **Discovery Phase** - Scans your `.claude/` directory
   ```
   Found 2 agents, 8 skills, 2 hooks, 4 MCPs, 35 data files
   ```

2. **Git Analysis Phase** - Analyzes commit history
   ```
   Analyzing git history... Found 15 automation commits
   ```

3. **Content Analysis Phase** - Maps content to agents
   ```
   Analyzing content... Found 4 content types (122 items total)
   ```

4. **Documentation Generation Phase** - Creates markdown files
   ```
   Generating documentation...
   ✓ c5-README.md
   ✓ c5-blog-posts.md
   ✓ c5-bschool-pages.md
   ✓ c5-automation-workflows.md
   ```

## View Generated Documentation

```bash
# List generated files
ls docs/architecture/c5-*.md

# View overview
cat docs/architecture/c5-README.md

# Open in your editor
code docs/architecture/c5-README.md
```

## What You Get

After running the agent, you'll have:

```
docs/architecture/
├── c5-README.md                    # Overview and navigation
├── c5-{content-type}.md            # Workflows for each content type
└── c5-automation-workflows.md      # Master reference
```

Each file documents:
- Which agents created which content
- Which skills and MCPs were used
- Real examples with git commits
- Step-by-step workflows

## Common Issues

### "No .claude/ directory found"

**Solution**: Create the directory structure:
```bash
mkdir -p .claude/agents .claude/skills
```

### "No agents found"

**Solution**: Make sure you have at least one agent or skill:
```bash
ls .claude/agents/*.md
ls .claude/skills/*.md
```

### "Git repository not found"

**Solution**: Initialize git (optional):
```bash
git init
```

Phase 2 (git analysis) will be skipped if no git repo exists, but the agent will still work!

### "No content detected"

**Solution**: The agent looks for data files in common locations:
- `app/data/*.ts`
- `src/data/*.ts`
- `data/*.ts`

If your data files are elsewhere, specify custom paths.

## Next Steps

1. **Read the generated C5 docs** - Understand your automation usage
2. **Share with your team** - Help them understand workflows
3. **Regenerate periodically** - Keep docs up to date
4. **Customize templates** - Fork skills to match your style

## Getting Help

- **README**: [README.md](README.md)
- **Contributing**: [CONTRIBUTING.md](CONTRIBUTING.md)
- **Issues**: https://github.com/yourusername/claude-c5-generator/issues

## Example Output

See what C5 documentation looks like:

- [Example: Rehearsal AI](examples/rehearsal-ai/)
  - 98/122 items automated (80%)
  - 3 agents, 12 skills, 4 MCPs
  - 20+ automation commits analyzed

---

**Time to first C5 docs**: ~2 minutes

**Documentation quality**: Comprehensive, with real examples

**Maintenance**: Regenerate monthly or after major changes

---

Happy documenting! 🎉
