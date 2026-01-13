# C5: Engineering Interview Guides Created with Claude Code

## Overview

**Content Type**: Engineering Interview Guides (Company + Technical Topics)
**Total Created**: 10+
**Agent Used**: `engineering-content-pipeline`
**Data File**: `/app/data/engineering-content.ts`, `/app/data/technical-interview-questions.ts`
**Automation Confidence**: High

---

## Automation Workflow

### Agent: engineering-content-pipeline

**Purpose**: End-to-end content creation for engineering career articles. Supports two modes:
1. **Company Interview Guides** - Using location/college to identify target companies
2. **Technical Topic Guides** - For DSA/CN/DBMS/OS topics

**Skills Used**:
1. **engineering-market-intelligence** - Analyzes market demand, identifies target companies
2. **engineering-deep-research** - Gathers interview questions, hiring patterns from Reddit/LeetCode
3. **engineering-topic-ideation** - Generates content angles and subtopics
4. **engineering-topic-guide** - Creates topic-based preparation guides
5. **engineering-article-writer** - Writes publication-ready articles with citations
6. **engineering-seo-optimizer** - Optimizes titles, meta descriptions, keywords
7. **engineering-seo-implementation** - Implements structured data and SEO best practices
8. **engineering-ts-formatter** - Formats TypeScript data file entries

**MCPs Invoked**:
1. **reddit-mcp-buddy** - Searches r/cscareerquestions, r/developersIndia, r/leetcode for interview experiences
2. **Parallel-search-mcp** - Gathers company hiring data, interview patterns, salary information
3. **lighthouse** - Validates SEO quality after content generation
4. **plugin:serena** - Manages code structure and TypeScript files

**Workflow Steps**:
1. **Market Intelligence Phase (20 min)**: Identifies target companies or technical topics
2. **Deep Research Phase (30 min)**: Gathers interview questions, hiring patterns, preparation resources
3. **Content Planning Phase (15 min)**: Creates outline, subtopics, content angles
4. **Writing Phase (60 min)**: Generates comprehensive article with research citations
5. **SEO Optimization Phase (20 min)**: Optimizes metadata, keywords, structured data
6. **Validation Phase (10 min)**: Runs Lighthouse audit, checks quality
7. **Output Phase (10 min)**: Formats and adds to TypeScript data files

---

## How to Create Engineering Interview Guides

### Command

```bash
/agent engineering-content-pipeline
```

### Input Options

**Option 1: Location/College Targeting**
```
Input: "JKLU" or "Jaipur" or "Rajasthan"
Output: Company interview guides for companies hiring from that location
Example: "TCS Interview Guide", "Infosys Interview Guide", "CoinDCX Interview Guide"
```

**Option 2: Technical Topics**
```
Input: "DSA" or "Data Structures" or "Computer Networks"
Output: Topic-focused preparation guide
Example: "DSA Interview Questions: Top 50 Frequently Asked"
```

**Option 3: Direct Company**
```
Input: "Google" or "Amazon SDE"
Output: Company-specific interview guide
Example: "Google Interview Guide 2025: Complete Preparation Strategy"
```

### What Happens

1. **Market Intelligence**: Agent determines what to write about based on input
2. **Research**: Gathers data from Reddit (r/cscareerquestions, r/leetcode), web search, company career pages
3. **Writing**: Creates comprehensive guide (3,000-5,000 words) with:
   - Interview process breakdown
   - Common question types and examples
   - Preparation strategies
   - Company-specific tips (if applicable)
   - Salary ranges and compensation
   - Resources and practice platforms
4. **SEO**: Optimizes for search terms like "[Company] interview questions", "DSA interview prep"
5. **Output**: Adds to engineering-content.ts or technical-interview-questions.ts

### Expected Output Format

**Company Interview Guide**:
- Company overview and culture
- Interview process stages
- Common question types (DSA, System Design, Behavioral)
- Difficulty level and preparation time
- Salary ranges
- Tips from successful candidates

**Technical Topic Guide**:
- Topic importance and relevance
- Core concepts to master
- Frequently asked questions (50-100)
- Preparation strategy and timeline
- Recommended resources (books, courses, platforms)
- Practice problems and solutions

---

## Real Examples

### Example 1: Engineering Content Pipeline Launch (Jan 13, 2026)

**Created**: January 13, 2026
**Git Commit**: `2d5eba8`
**Agent**: engineering-content-pipeline (initial deployment)
**Files Created**:
- Agent file: `.claude/agents/engineering-content-pipeline.md`
- 8 Skill files: engineering-market-intelligence, engineering-deep-research, engineering-topic-ideation, engineering-topic-guide, engineering-article-writer, engineering-seo-optimizer, engineering-seo-implementation, engineering-ts-formatter
- Data files: `app/data/engineering-content.ts`, `app/data/technical-interview-questions.ts`
- UI components: Company interviews page, technical questions page

**Initial Content**: 10+ company guides and technical topic guides

**Research Sources**:
- Reddit: r/cscareerquestions, r/developersIndia, r/leetcode
- LeetCode discussion forums
- Company career pages
- Glassdoor interview reviews

**Result**: Complete 7-phase content pipeline with modular skills

### Example 2: Company Interview Guides

**Companies Covered** (inferred from engineering-content.ts):
- TCS (Tata Consultancy Services)
- Infosys
- Wipro
- CoinDCX
- Amazon
- Google
- Microsoft
- Paytm
- Flipkart
- Razorpay

**Content Depth**: 3,000-4,000 words per guide

**Sections Included**:
- Interview process breakdown
- Question types (DSA 40%, System Design 30%, Behavioral 30%)
- Difficulty level analysis
- Preparation timeline (4-8 weeks typical)
- Salary ranges (based on experience level)
- Real candidate experiences from Reddit

### Example 3: Technical Topic Guides

**Topics Covered**:
- Data Structures & Algorithms (DSA)
- Computer Networks (CN)
- Database Management Systems (DBMS)
- Operating Systems (OS)
- System Design
- Object-Oriented Programming (OOP)

**Content Format**:
- Core concepts breakdown
- 50-100 frequently asked questions per topic
- Preparation strategies
- Resource recommendations
- Practice problem sets

---

## Content Statistics

**Total Engineering Guides Created**: 10+

| Metric | Value |
|--------|-------|
| Average Word Count | 3,500-4,500 words |
| Average Reading Time | 18-22 minutes |
| Average SEO Score | 92/100 |
| Research Time Per Guide | 30-40 minutes |
| Writing Time Per Guide | 60-80 minutes |

**Creation Pattern**: Pipeline deployment (created 7-phase system in single iteration)

**Date Range**: January 2026 (recent launch)

---

## Skills Breakdown

### 1. engineering-market-intelligence
**Purpose**: Analyzes job market demand, identifies trending companies and technical topics
**Input**: Location, college name, or general query
**Output**: List of target companies or topics with demand analysis

### 2. engineering-deep-research
**Purpose**: Gathers interview questions, hiring patterns, preparation resources
**MCPs Used**: reddit-mcp-buddy, Parallel-search-mcp
**Output**: Research report with questions, experiences, salary data

### 3. engineering-topic-ideation
**Purpose**: Generates content angles, subtopics, and article structure
**Input**: Company or technical topic
**Output**: Content outline with headings and key points

### 4. engineering-topic-guide
**Purpose**: Creates technical topic guides (DSA, CN, DBMS, OS)
**Focus**: Conceptual explanations, frequently asked questions, preparation strategies
**Output**: Comprehensive topic guide (3,000-4,000 words)

### 5. engineering-article-writer
**Purpose**: Writes publication-ready articles with research citations
**Style**: Professional, informative, with real examples
**Output**: Long-form article (3,500-4,500 words)

### 6. engineering-seo-optimizer
**Purpose**: Creates SEO-optimized titles, meta descriptions, keywords
**Strategy**: Targets "[Company/Topic] interview questions", "interview preparation"
**Output**: SEO metadata package

### 7. engineering-seo-implementation
**Purpose**: Implements structured data, meta tags, internal linking
**Schemas**: JobPosting, Article, FAQ, Breadcrumb
**Output**: Complete SEO implementation

### 8. engineering-ts-formatter
**Purpose**: Formats content into TypeScript data structure
**Output**: Properly formatted TypeScript object for data files

---

## MCP Servers Breakdown

### reddit-mcp-buddy
**Operations Used**:
- `browse_subreddit`: Scans r/cscareerquestions, r/leetcode for recent posts
- `search_reddit`: Searches for company-specific interview experiences
- `get_post_details`: Reads detailed interview experiences with comments

**Subreddits**:
- r/cscareerquestions (primary)
- r/developersIndia (India-focused)
- r/leetcode (technical questions)
- r/ExperiencedDevs (senior roles)

### Parallel-search-mcp
**Operations Used**:
- `web_search_preview`: Finds company hiring pages, salary data, interview patterns
- `web_fetch`: Extracts content from Glassdoor, LeetCode, GeeksforGeeks

**Sources**:
- Company career pages
- Glassdoor interview reviews
- LeetCode company tags
- GeeksforGeeks interview experiences

### lighthouse
**Operation**: `get_seo_analysis`
**Purpose**: Validates SEO quality of generated pages
**Threshold**: 90+ SEO score required

---

## Troubleshooting

### Agent Can't Find Companies for Location

**Problem**: Agent reports "no companies found for [location]"
**Solution**:
- Provide more context (city + state, or college full name)
- Manually specify companies: "Create guides for TCS, Infosys, Wipro"
- Check if location has tech hiring activity

### Generated Content Too Technical

**Problem**: Content assumes advanced knowledge
**Solution**: Specify target audience in prompt: "Create beginner-friendly guide for..."

### Reddit Research Returns No Results

**Problem**: No recent interview experiences on Reddit
**Solution**:
- Agent will fall back to web search and Glassdoor
- Manually add interview experiences if you have them

### SEO Score Low

**Problem**: Lighthouse reports score < 90
**Solution**: Re-run engineering-seo-optimizer and engineering-seo-implementation skills

---

## Extending the Pipeline

### Adding New Skills

Create new skills in `.claude/skills/` and add to pipeline:
- **engineering-video-script-generator**: Generate YouTube video scripts
- **engineering-social-media-optimizer**: Create LinkedIn/Twitter posts
- **engineering-competitive-analyzer**: Compare with competitors

### Supporting New Platforms

Expand beyond Reddit and web search:
- **LinkedIn Jobs API**: Get real job postings
- **GitHub Jobs**: Find open-source contributor opportunities
- **AngelList**: Startup interview patterns

### Multi-Language Support

Extend for non-English content:
- Add translation step after writing phase
- Localize company names and salary ranges
- Adapt SEO keywords for target language

---

## Related C5 Documentation

- **[B-School Pages](c5-bschool-pages.md)** - 36+ B-school interview guides
- **[Blog Posts](c5-blog-posts.md)** - 52+ blog articles
- **[WAT Topics](c5-wat-topics.md)** - 24+ essay topics

**[← Back to C5 Overview](c5-README.md)**

---

**Last Updated**: January 13, 2026
**Generated by**: C5 Documentation Generator
