# C5: B-School Pages Created with Claude Code

## Overview

**Content Type**: B-School Interview Guides
**Total Created**: 36+
**Agent Used**: `b-school-page-creator`
**Data File**: `/app/data/iim-schools-v2.ts` (and modular school files)
**Automation Confidence**: High

---

## Automation Workflow

### Agent: b-school-page-creator

**Purpose**: Creates comprehensive, authoritative landing pages for business schools and educational institutes. Specializes in MBA programs, executive education, business school rankings, admissions processes, and interview preparation.

**Skills Used**:
- None explicitly defined (agent is self-contained)
- Uses MCP servers directly for research

**MCPs Invoked**:
1. **Parallel-search-mcp** (web_search_preview, web_fetch) - Gathers official school statistics, rankings, employment data
2. **reddit-mcp-buddy** (browse_subreddit, search_reddit, get_post_details) - Finds real student experiences, candid reviews, interview tips
3. **plugin:serena** (code navigation) - Manages TypeScript data file structure

**Workflow Steps**:
1. **Research Phase (30-45 min)**: Agent gathers data from official websites, Reddit, and ranking sources
2. **Content Creation Phase (60-90 min)**: Creates comprehensive page following established template
3. **Quality Validation Phase (15 min)**: Ensures consistency with existing pages
4. **Output Phase (10 min)**: Adds school entry to data files

---

## How to Create B-School Pages

### Command

```bash
/agent b-school-page-creator
```

### What Happens

1. **You provide**: School name (e.g., "IIM Ahmedabad", "INSEAD", "Harvard Business School")
2. **Agent researches**:
   - Official statistics (rankings, acceptance rate, GMAT scores, tuition)
   - Reddit discussions for real student insights
   - Employment outcomes and salary data
   - Alumni achievements and culture
3. **Agent generates**: Complete school profile with 11 standardized sections
4. **Agent writes**: TypeScript entry in appropriate data file
5. **You review**: Check accuracy, add any missing details, commit

### Expected Output

The agent creates a page with these sections:
- Hero section with school name and tagline
- Quick facts box (ranking, class size, acceptance rate, GMAT, work experience, tuition)
- Program overview
- Why [School Name] (unique value propositions)
- Curriculum & academics
- Admissions requirements and process
- Career outcomes and employment statistics
- Student life & culture
- Notable alumni
- Rankings & recognition
- Application tips

### Review Checklist

Before publishing:
- [ ] All statistics are current (2025-2026 academic year)
- [ ] Tuition and fees are accurate
- [ ] Rankings are from recent cycles
- [ ] Alumni examples are verifiable
- [ ] Writing style matches existing pages
- [ ] Internal links work correctly

---

## Real Examples

### Example 1: IIM Sambalpur, BIMTECH, IMT Hyderabad, IFMR Chennai (Jan 11, 2026)

**Created**: January 11, 2026
**Git Commit**: `01c38f9`
**Agent**: b-school-page-creator
**Batch**: 4 schools in single session

**Schools Added**:
- IIM Sambalpur (CAP IIM)
- BIMTECH Greater Noida
- IMT Hyderabad
- IFMR Graduate School of Management Chennai

**Research Sources**:
- Official school websites
- Reddit r/CAT_Preparation discussions
- NIRF rankings 2025
- Placement reports

**Result**: 4 comprehensive pages (10,000-15,000 words each) with complete interview preparation guides

### Example 2: CAP/JAP IIM Guides (Jan 11, 2026)

**Created**: January 11, 2026
**Git Commit**: `9d7b94d`
**Agent**: b-school-page-creator
**Batch**: 5 schools

**Schools Added**:
- IIM Bodh Gaya
- IIM Jammu
- IIM Nagpur
- IIM Ranchi
- IIM Raipur
- IIM Sirmaur

**Focus**: Newer IIMs participating in CAP (Common Admission Process)

**Unique Aspects**:
- CAP interview process details
- Cutoff analysis for General/OBC/SC/ST/EWS
- Profile evaluation criteria
- Placement statistics for emerging IIMs

### Example 3: Premier Institutes (Earlier batches)

**Schools Created**:
- ISB Hyderabad
- Great Lakes Chennai
- SCMHRD Pune
- SIBM Pune
- GIM Goa
- LIBA Chennai
- IIM Rohtak
- IIM Udaipur

**Research Depth**: 2-3 hours per school (deeper research for premier institutes)

---

## Content Statistics

**Total B-School Pages Created**: 36+

| Metric | Value |
|--------|-------|
| Average Page Word Count | 12,000-15,000 words |
| Average Research Time | 45-60 minutes per school |
| Average Writing Time | 90-120 minutes per school |
| Sections Per Page | 11 standardized sections |

**Creation Pattern**: Incremental (1-6 schools per batch, weekly/bi-weekly)

**Date Range**: October 2025 - January 2026

**School Categories**:
- **Ultra Elite IIMs**: IIM-A, IIM-B, IIM-C, FMS Delhi (3 schools)
- **Elite IIMs**: IIM-L, IIM-K, IIM-I (3 schools)
- **CAP IIMs**: IIM Bodh Gaya, Jammu, Nagpur, Ranchi, Raipur, Rohtak, Sambalpur, Sirmaur, Udaipur (10 schools)
- **SNAP Schools**: SIBM Pune, SCMHRD Pune (2 schools)
- **Premier Private**: ISB Hyderabad, Great Lakes Chennai, GIM Goa, LIBA Chennai, BIMTECH, IMT Hyderabad, IFMR Chennai (7 schools)

---

## Agent Configuration

### Research Protocol

**Web Search Phase**:
- Official school statistics (class size, acceptance rate, GMAT/GRE, work experience)
- Current tuition and fees
- Latest rankings (US News, Financial Times, Bloomberg, QS, Poets&Quants)
- Employment statistics and salary data
- Notable alumni achievements
- Campus facilities and location details

**Reddit Research Phase**:
- Real student experiences and candid reviews
- Common questions prospective students ask
- Culture and community insights
- Interview experiences and tips
- Pros and cons from current students and alumni
- Comparisons with peer schools

**Subreddits Used**:
- r/CAT_Preparation (primary)
- r/MBA
- r/Indian_Academia
- r/IndianSchoolSystem

---

## Troubleshooting

### Agent Not Finding School Data

**Problem**: Agent reports "insufficient data" for school
**Solution**: Provide more specific school name, include location (e.g., "IIM Rohtak, India" instead of just "IIM Rohtak")

### Generated Content Too Generic

**Problem**: Content lacks depth or unique insights
**Solution**:
- Ensure Reddit research phase completes fully
- Check if subreddit discussions exist for the school
- Manually add unique aspects after generation

### Inconsistent Formatting

**Problem**: Generated page doesn't match existing format
**Solution**: Agent should reference existing pages - if issue persists, manually adjust sections to match template

### Tuition/Rankings Out of Date

**Problem**: Statistics are from previous years
**Solution**: Agent uses most recent data available, but verify and update manually if needed (especially for newly released rankings)

---

## Extending the Workflow

### Customizing the Agent

Fork the agent file (`.claude/agents/b-school-page-creator.md`) and modify:
- **Research depth**: Add more data sources or subreddits
- **Content sections**: Add/remove sections from template
- **Writing style**: Adjust tone (more formal vs conversational)
- **Output format**: Change TypeScript schema if needed

### Adding New School Categories

When adding schools from new categories (e.g., European B-schools):
1. Update research sources (add relevant subreddits, ranking sources)
2. Adjust quick facts template (GMAT → GRE for some schools)
3. Update tuition format (USD vs EUR vs INR)
4. Modify admissions section for country-specific processes

---

## Related C5 Documentation

- **[Blog Posts](c5-blog-posts.md)** - 52+ blog articles
- **[Engineering Guides](c5-engineering-guides.md)** - 10+ company interview guides
- **[WAT Topics](c5-wat-topics.md)** - 24+ essay topics

**[← Back to C5 Overview](c5-README.md)**

---

**Last Updated**: January 13, 2026
**Generated by**: C5 Documentation Generator
