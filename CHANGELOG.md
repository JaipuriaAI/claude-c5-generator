# Changelog

All notable changes to the C5 Documentation Generator will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-01-13

### Added
- Initial release of C5 Documentation Generator
- 4-phase pipeline architecture:
  - Phase 1: Discovery (finds agents, skills, hooks, MCPs)
  - Phase 2: Git History Analysis (analyzes automation commits)
  - Phase 3: Content Analysis (maps content to agents/skills/MCPs)
  - Phase 4: Documentation Generation (creates 5-7 markdown files)
- Universal design works on ANY codebase with `.claude/` directory
- Auto-detection of agents, skills, hooks, MCPs
- Git history analysis with commit parsing
- Content type mapping and statistics
- Template-based documentation generation
- Installation script (`install.sh`)
- Comprehensive README with examples
- MIT License
- Contributing guidelines

### Features
- Discovers all automation tools in project
- Analyzes git commits for automation usage (last 3 months)
- Maps content to agents/skills/MCPs used
- Generates C5 overview, content-type workflows, master reference
- Updates architecture README with C5 navigation
- Provides real examples from Rehearsal AI project
- Supports projects with/without git history
- Auto-detects data files in common locations
- Handles TypeScript, JavaScript, and other languages

### Documentation
- Complete README with installation, usage, examples
- Contributing guidelines for community
- Changelog for version tracking
- Example C5 output from Rehearsal AI (98/122 items automated)
- MIT License for open source use

---

## [Unreleased]

### Planned for v2.0.0
- Interactive HTML output (searchable, filterable)
- PDF generation for offline reference
- Diagram generation from workflow data
- Integration with project wikis (Notion, Confluence)
- Automated C5 regeneration via GitHub Actions
- Multi-repo support (monorepo analysis)
- Database-backed content analysis

### Under Consideration
- Custom template support
- Multi-language documentation generation
- Historical trend tracking
- Performance metrics dashboard
- Agent usage analytics

---

## Release Notes

### v1.0.0 - Initial Release

**Highlights**:
- First public release of C5 Documentation Generator
- Universal tool that works on any Claude Code project
- Comprehensive 4-phase pipeline
- Real-world validation on Rehearsal AI project (122 content items documented)

**Known Issues**:
- Git analysis requires commits with automation keywords (use "feat:", "agent", etc.)
- Data file detection limited to common patterns (app/data/, src/data/, data/)
- Template customization requires forking skill files
- No support for database-backed content (file-based only)

**Breaking Changes**: N/A (initial release)

**Migration Guide**: N/A (initial release)

---

## How to Update

### Upgrading from v1.x to v2.x (when released)

```bash
# 1. Backup existing files
cp -r /path/to/project/.claude/agents/c5-documentation-generator.md /tmp/backup/
cp -r /path/to/project/.claude/skills/c5-*.md /tmp/backup/

# 2. Pull latest version
git clone https://github.com/yourusername/claude-c5-generator
cd claude-c5-generator
git checkout v2.0.0

# 3. Reinstall
./install.sh /path/to/project

# 4. Regenerate C5 docs
cd /path/to/project
/agent c5-documentation-generator
```

---

**Format**: [Version] - YYYY-MM-DD

**Types of Changes**:
- `Added` - New features
- `Changed` - Changes to existing functionality
- `Deprecated` - Soon-to-be removed features
- `Removed` - Removed features
- `Fixed` - Bug fixes
- `Security` - Security fixes
