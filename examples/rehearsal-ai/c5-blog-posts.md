# C5: Blog Posts Created with Claude Code

## Overview

**Content Type**: Blog Posts
**Total Created**: 52+
**Agent Used**: Various (mix of automation and manual creation)
**Data File**: `/app/data/blog-posts.ts`
**Automation Confidence**: Medium-High

---

## Automation Workflow

### Recent Batch Creation (Jan 2026)

**Agent**: Not explicitly documented (likely custom blog generation workflow)

**Recent Commits**:
- **Jan 13, 2026** (commit 9744db6): Added 4 SEO-optimized IIM interview blog posts
- **Jan 11, 2026** (commit 3ff473d): Added 6 Reddit-sourced blog posts (Tier 2/3 topics)
- **Jan 11, 2026** (commit b6f910d): Added 4 Reddit-sourced GD-PI blog posts for CAT 2026
- **Jan 10, 2026** (commit c761a2f): Added 14 new blog posts, fixed CTA buttons

**Pattern**: Batch creation (4-14 posts per commit)

**Research Sources**:
- Reddit (r/CAT_Preparation, r/MBA, r/Indian_Academia)
- Web search for trending topics
- SEO keyword research

---

## Content Creation Process

### Step 1: Topic Research
1. Identify trending topics on Reddit
2. Analyze search volume and competition
3. Find gaps in existing content

### Step 2: Content Writing
1. Create comprehensive long-form articles (2,000-3,000 words)
2. Include research citations and examples
3. Add internal linking to related content

### Step 3: SEO Optimization
1. Optimize titles and meta descriptions
2. Add relevant keywords naturally
3. Create structured data (JSON-LD schemas)

### Step 4: Quality Validation
1. Check readability scores
2. Validate SEO metadata
3. Test internal links

---

## Real Examples

### Example 1: IIM Interview Blog Posts (Jan 13, 2026)

**Batch**: 4 SEO-optimized posts
**Git Commit**: `9744db6`
**Date Created**: January 13, 2026

**Topics Added**:
- Gap year career pivot strategies for IIM interviews
- Economic literacy importance in IIM interviews
- IIM interview preparation strategies
- Research-backed interview psychology

**Characteristics**:
- Word count: 2,400-2,600 words average
- Reading time: 12-14 minutes
- SEO optimization: Comprehensive keyword targeting
- Citations: Academic research and interview psychology

### Example 2: Reddit-Sourced GD-PI Blog Posts (Jan 11, 2026)

**Batch**: 4 posts
**Git Commit**: `b6f910d`
**Date Created**: January 11, 2026

**Topics Added**:
- GD-PI preparation strategies from Reddit
- Common mistakes in CAT 2026 interviews
- Real student experiences and tips
- Interview psychology insights

### Example 3: Tier 2/3 MBA Topics (Jan 11, 2026)

**Batch**: 6 posts
**Git Commit**: `3ff473d`
**Date Created**: January 11, 2026

**Focus**: Targeting Tier 2/3 MBA aspirants with specific pain points identified from Reddit discussions

---

## Content Statistics

**Total Blog Posts Created**: 52+

| Metric | Value |
|--------|-------|
| Average Word Count | 2,400-2,600 words |
| Average Reading Time | 12-14 minutes |
| Average SEO Score | 90+/100 |
| Categories | IIM Interviews, GDPI Preparation, Career Strategy, MBA Admissions |

**Creation Pattern**: Batch creation (4-14 posts per batch, weekly cadence)

**Date Range**: October 2025 - January 2026

---

## How to Create Blog Posts

### Current Process (Manual + Automation)

```bash
# 1. Research trending topics
# Use Reddit MCPs, web search

# 2. Draft content
# Write long-form article with research citations

# 3. Add to data file
# Update app/data/blog-posts.ts

# 4. Run SEO validation
# Lighthouse audit for SEO score
```

### Recommended Automation

For a dedicated blog generation agent:

```markdown
## Suggested Agent: blog-post-generator

### Skills Needed:
1. **topic-research-skill** - Finds trending topics from Reddit/web
2. **article-writer-skill** - Creates long-form content with citations
3. **seo-optimizer-skill** - Optimizes titles, meta, keywords
4. **ts-formatter-skill** - Formats BlogPost TypeScript entry

### MCPs Used:
- reddit-mcp-buddy (browse_subreddit, search_reddit)
- Parallel-search-mcp (web_search_preview, web_fetch)
- lighthouse (get_seo_analysis)

### Workflow:
1. Research phase (30 min): Scan Reddit for trending topics
2. Writing phase (60 min): Generate 2,400+ word article
3. SEO phase (15 min): Optimize metadata and keywords
4. Output phase (5 min): Add to blog-posts.ts
```

---

## SEO Optimization Details

### Implemented SEO Strategies

**On-Page SEO**:
- Keyword-optimized titles (60-70 characters)
- Meta descriptions (155-160 characters)
- Header hierarchy (H1 → H2 → H3)
- Internal linking to related content
- External linking to authoritative sources

**Structured Data**:
- BlogPosting schema (JSON-LD)
- Breadcrumb schema
- Author schema (Person type)
- Organization schema (Rehearsal AI)

**Technical SEO**:
- Fast page load times (static generation)
- Mobile-responsive design
- Optimized images with alt text
- Clean URL structure (/blog/[slug])

---

## Related C5 Documentation

- **[B-School Pages](c5-bschool-pages.md)** - 36+ B-school interview guides
- **[Engineering Guides](c5-engineering-guides.md)** - 10+ company interview guides
- **[WAT Topics](c5-wat-topics.md)** - 24+ essay topics

**[← Back to C5 Overview](c5-README.md)**

---

**Last Updated**: January 13, 2026
**Generated by**: C5 Documentation Generator
