# Contributing to C5 Documentation Generator

Thank you for your interest in contributing to the C5 Documentation Generator! This guide will help you get started.

## Ways to Contribute

### 1. Report Bugs

Found a bug? Please open an issue with:
- Clear description of the problem
- Steps to reproduce
- Expected vs actual behavior
- Project details (language, framework, agent/skill count)
- Error messages or logs

### 2. Suggest Features

Have an idea? Open an issue with:
- Clear description of the feature
- Use case (why is this useful?)
- Proposed implementation (if you have ideas)
- Examples from other projects

### 3. Improve Documentation

- Fix typos or unclear explanations
- Add more examples
- Improve README sections
- Translate documentation

### 4. Submit Code

- Fix bugs
- Implement new features
- Improve performance
- Add support for new patterns

### 5. Share Examples

Generated C5 docs for your project? Share it!
- Add to `examples/` directory
- Include project description
- Show automation stats

---

## Development Setup

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/claude-c5-generator
cd claude-c5-generator
```

### 2. Test on a Sample Project

```bash
# Copy files to a test project
cp -r .claude/agents/c5-documentation-generator.md /path/to/test-project/.claude/agents/
cp -r .claude/skills/c5-*.md /path/to/test-project/.claude/skills/

# Run the agent
cd /path/to/test-project
/agent c5-documentation-generator
```

### 3. Make Changes

Edit the agent or skill files:
- `.claude/agents/c5-documentation-generator.md` - Main orchestrator
- `.claude/skills/c5-discover-automation.md` - Phase 1 logic
- `.claude/skills/c5-analyze-git-history.md` - Phase 2 logic
- `.claude/skills/c5-analyze-content.md` - Phase 3 logic
- `.claude/skills/c5-generate-docs.md` - Phase 4 logic

### 4. Test Your Changes

Run the agent again to see your changes in action:

```bash
/agent c5-documentation-generator
```

Verify the generated C5 documentation looks correct.

---

## Code Guidelines

### Agent File Structure

```markdown
---
name: agent-name
description: Brief description with examples
model: opus
---

[Agent instructions here]
```

### Skill File Structure

```markdown
# Skill Name

## Purpose
One-line description

## What It Does
Numbered list of steps

## Input
Required and optional parameters

## Output
JSON format with example

## Implementation Instructions
Step-by-step implementation

## Error Handling
Common errors and solutions

## Testing
Test cases

## Version
Version and compatibility info
```

### Commit Messages

Use conventional commit format:

```
feat: Add support for Python projects
fix: Correct git commit parsing regex
docs: Update README installation instructions
refactor: Simplify content type detection
test: Add test cases for Phase 3
```

---

## Pull Request Process

### 1. Fork the Repository

Click "Fork" on GitHub to create your copy.

### 2. Create a Branch

```bash
git checkout -b feature/your-feature-name
```

### 3. Make Your Changes

- Follow code guidelines
- Add comments for complex logic
- Update documentation if needed

### 4. Test Thoroughly

- Test on multiple projects (if possible)
- Verify all 4 phases work correctly
- Check generated documentation looks good

### 5. Commit Your Changes

```bash
git add .
git commit -m "feat: Add your feature description"
```

### 6. Push to Your Fork

```bash
git push origin feature/your-feature-name
```

### 7. Open a Pull Request

Go to GitHub and open a PR with:
- Clear title describing the change
- Description of what changed and why
- Screenshots (if UI/documentation changes)
- Testing steps (how to verify)

---

## Areas for Contribution

### High Priority

- **Database content support** - Analyze content from databases, not just files
- **Multi-language support** - Better detection for Python, Ruby, Go projects
- **Custom MCP integration** - Document usage of custom MCP servers
- **Performance optimization** - Speed up git analysis for large repos

### Medium Priority

- **Interactive HTML output** - Searchable, filterable C5 documentation
- **Diagram generation** - Mermaid diagrams from workflow data
- **GitHub Actions integration** - Auto-regenerate C5 on push
- **Wiki integration** - Export to Notion, Confluence

### Low Priority

- **PDF export** - Generate PDF from C5 markdown
- **Multi-repo support** - Analyze monorepos with multiple .claude/ directories
- **Historical trends** - Track automation usage over time

---

## Community Guidelines

### Be Respectful

- Treat everyone with respect
- Welcome newcomers
- Provide constructive feedback
- Assume good intentions

### Be Helpful

- Answer questions when you can
- Share your C5 examples
- Help debug issues
- Review pull requests

### Be Collaborative

- Discuss big changes before implementing
- Ask for feedback on your ideas
- Give credit where due
- Build on others' work

---

## Getting Help

- **Documentation**: Read [README.md](README.md) first
- **Issues**: Search existing issues before creating new ones
- **Discussions**: Ask questions in GitHub Discussions
- **Twitter/X**: Tag [@yourusername](https://twitter.com/yourusername)

---

## Recognition

Contributors will be:
- Added to CONTRIBUTORS.md
- Mentioned in release notes
- Thanked in the README

Significant contributions may be recognized with:
- Maintainer status
- Co-authorship on future releases
- Speaking opportunities (if interested)

---

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

**Thank you for contributing to C5!** 🎉
