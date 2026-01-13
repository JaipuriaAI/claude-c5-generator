# C5 Documentation Generator - Architecture Documentation

This directory contains comprehensive C4+C5 architecture documentation for the C5 Documentation Generator system.

## What is C4+C5?

**C4** is a hierarchical software architecture documentation framework with 4 levels:
1. **Context** - System boundaries, users, and external dependencies (highest level)
2. **Container** - Deployment architecture and runtime containers
3. **Component** - Logical components and their relationships
4. **Code** - Implementation details and code structure (lowest level)

**C5** (Claude Code Usage) is the 5th level we've added that documents actual automation usage:
- Which agents/skills/MCPs were used to create which content
- Real examples with git commit references
- Step-by-step workflow guides for replication

While **C4 documents "what can be done"**, **C5 documents "what was actually done"**.

## Documentation Structure

### Start with Overview
Begin here to understand the system at the highest level:

**[C4 Context Level](./c4-context.md)** - System context, personas, user journeys, external dependencies
- Who uses the system and why?
- What problems does it solve?
- What are the key features?
- How does the system fit in its environment?

### Then Explore Deployment
Understand how the system is deployed and runs:

**[C4 Container Level](./c4-container.md)** - Deployment architecture, containers, technology stack
- How is the system deployed?
- What containers/services exist?
- How do they communicate?
- What technologies are used?

### Dive into Components
Learn the logical structure and component interactions:

**[C4 Component Level](./c4-component.md)** - Logical components, data flow, pipeline architecture
- What are the main components?
- How do they interact?
- What data flows between them?
- What are the component responsibilities?

### Understand Implementation
See the actual code structure and algorithms:

**[C4 Code Level](./c4-code.md)** - Code structure, algorithms, implementation details
- What files and functions exist?
- How are algorithms implemented?
- What are the data structures?
- What are the coding patterns?

### See Automation in Action
Learn how the system documents its own automation usage:

**[C5 (Claude Code Usage)](./c5-README.md)** - Generated documentation showing automation patterns
- Which agents/skills created which content?
- What are the actual workflows?
- How can I replicate the automation?
- What are the real examples?

## Documentation Levels

### Level 1: Context (Stakeholder View)
**File**: [c4-context.md](./c4-context.md)

**Audience**: All stakeholders (developers, team leads, managers, users)

**Questions Answered**:
- What problem does the C5 system solve?
- Who are the users (personas)?
- What are the user journeys?
- What external systems does it depend on?
- What are the system boundaries?

**Key Diagrams**:
- System context diagram (system + users + external systems)
- User journey maps

**Read This If**: You want a high-level understanding of the system and its purpose

---

### Level 2: Container (Deployment View)
**File**: [c4-container.md](./c4-container.md)

**Audience**: DevOps, architects, senior developers

**Questions Answered**:
- How is the system deployed?
- What containers/services exist?
- How do containers communicate?
- What technologies are used?
- How does data flow between containers?

**Key Diagrams**:
- Container diagram (Claude Code Agent, Skills, MCP Servers, Git, File System)
- Container communication patterns
- Deployment architecture

**Read This If**: You need to understand deployment, scaling, or technology choices

---

### Level 3: Component (Logical View)
**File**: [c4-component.md](./c4-component.md)

**Audience**: Developers, architects

**Questions Answered**:
- What are the logical components?
- How do components interact?
- What are component responsibilities?
- What data structures are passed between components?
- What is the pipeline architecture?

**Key Diagrams**:
- Component diagram (Orchestrator, Discovery, Git Analysis, Content Analysis, Documentation Generation)
- Component relationships
- Data flow between components

**Component Details**:
- [Orchestrator Component](./c4-component-orchestrator.md) - Workflow coordination
- [Discovery Component](./c4-component-discovery.md) - Automation setup discovery
- [Git Analysis Component](./c4-component-git-analysis.md) - Git history analysis
- [Content Analysis Component](./c4-component-content-analysis.md) - Content mapping
- [Documentation Generation Component](./c4-component-documentation-generation.md) - Markdown generation

**Read This If**: You want to understand the system's logical structure and design

---

### Level 4: Code (Implementation View)
**File**: [c4-code.md](./c4-code.md)

**Audience**: Developers implementing features or fixing bugs

**Questions Answered**:
- What files and code elements exist?
- What are the function signatures?
- What algorithms are used?
- What are the data structures?
- How is error handling implemented?

**Key Content**:
- Agent and skill file locations
- Function signatures with parameters and return types
- Implementation algorithms (discovery, parsing, generation)
- Data structure definitions (TypeScript interfaces)
- Code-level dependency graph

**Read This If**: You need to modify code or understand implementation details

---

### Level 5: C5 (Automation Usage)
**File**: [c5-README.md](./c5-README.md)

**Audience**: All users (developers, team leads, new team members)

**Questions Answered**:
- Which agents created which content?
- What skills and MCPs were used?
- How can I replicate the workflows?
- What are real examples with git commits?
- What are the automation statistics?

**Key Content**:
- Agent-to-content-type mapping
- Per-content-type workflow guides
- Real examples with metadata
- Step-by-step replication instructions
- Automation statistics (80% automated, batch sizes, frequencies)

**Additional Files**:
- [c5-blog-posts.md](./c5-blog-posts.md) - Blog creation workflow (if exists)
- [c5-automation-workflows.md](./c5-automation-workflows.md) - Master automation reference

**Read This If**: You want to understand or replicate automation workflows

---

## Quick Navigation

### By Audience

**I'm a new developer joining the team:**
1. Start with [C4 Context](./c4-context.md) to understand the system
2. Read [C5 README](./c5-README.md) to learn automation workflows
3. Explore [C4 Component](./c4-component.md) to understand architecture
4. Dive into [C4 Code](./c4-code.md) when you need implementation details

**I'm a team lead documenting automation:**
1. Read [C4 Context](./c4-context.md) to understand user journeys
2. Run the C5 agent to generate [C5 documentation](./c5-README.md)
3. Share C5 docs with team for knowledge transfer

**I'm an architect evaluating the system:**
1. Start with [C4 Context](./c4-context.md) for high-level view
2. Read [C4 Container](./c4-container.md) for deployment architecture
3. Explore [C4 Component](./c4-component.md) for logical design
4. Review [C4 Code](./c4-code.md) for implementation approach

**I'm contributing to the codebase:**
1. Read [C4 Component](./c4-component.md) to understand architecture
2. Dive into [C4 Code](./c4-code.md) for implementation details
3. Check [C5 README](./c5-README.md) to see how the system uses its own automation

### By Question

**"What does the C5 system do?"** → [C4 Context](./c4-context.md)

**"How is it deployed?"** → [C4 Container](./c4-container.md)

**"How does it work internally?"** → [C4 Component](./c4-component.md)

**"How is the code structured?"** → [C4 Code](./c4-code.md)

**"How do I replicate the automation?"** → [C5 README](./c5-README.md)

**"Which component handles discovery?"** → [Discovery Component](./c4-component-discovery.md)

**"Which component analyzes git history?"** → [Git Analysis Component](./c4-component-git-analysis.md)

**"Which component generates docs?"** → [Documentation Generation Component](./c4-component-documentation-generation.md)

## Documentation Standards

### Diagrams
All architecture diagrams use **Mermaid syntax** (specifically C4 diagram extensions):
- Context diagrams show system + users + external systems
- Container diagrams show deployment architecture
- Component diagrams show logical components and relationships
- Code diagrams (if any) show class/function relationships

### Conventions
- **System boundary**: Clearly defined in Context level
- **External systems**: Documented with integration types and protocols
- **Components**: Described with purpose, interfaces, and dependencies
- **Data structures**: Defined with TypeScript-style interfaces
- **File paths**: Always absolute from project root

### Updates
This documentation should be updated when:
- System architecture changes (new components, modified data flow)
- New external dependencies are added
- Deployment model changes
- Significant code refactoring occurs
- New features are added

To regenerate C5 documentation: `/agent c5-documentation-generator`

## Key Concepts

### Pipeline Architecture
The C5 system uses a 4-phase pipeline pattern:
1. **Discovery** → Finds automation setup
2. **Git Analysis** → Analyzes commit history
3. **Content Analysis** → Maps content to automation
4. **Documentation** → Generates markdown files

Each phase outputs structured JSON data consumed by subsequent phases.

### Components vs Containers
- **Components** = Logical units (Orchestrator, Discovery, Git Analysis, Content Analysis, Documentation Generation)
- **Containers** = Deployment units (Claude Code Agent Container, Skills Container, MCP Servers Container, Git Repository, File System)

One container (Skills Container) hosts 4 components (Discovery, Git Analysis, Content Analysis, Documentation Generation).

### Personas
The system serves multiple user types:
- **Developers** - Document automation workflows
- **Team Leads** - Transfer knowledge, track adoption
- **New Team Members** - Learn automation patterns
- **Contributors** - Understand project automation
- **Programmatic Users** - Claude Code Platform, Git, OS

### C5 Philosophy
C5 documents **actual usage** (execution history) rather than **capabilities** (design):
- Shows which agents created which content
- Provides real examples with git commits
- Documents creation patterns (batch, incremental)
- Enables workflow replication

## Related Documentation

- **[System README](../../README.md)** - Project overview, quick start, installation
- **[Contributing Guide](../../CONTRIBUTING.md)** - How to contribute to the project
- **[License](../../LICENSE)** - MIT License details

## Maintenance

**Last Updated**: 2026-01-13
**Documentation Version**: 1.0.0
**System Version**: C5 Documentation Generator v1.0.0
**Maintained By**: Shiva Kakkar

**Regeneration Command**: `/agent c5-documentation-generator`

---

**Questions or feedback?** Open an issue at https://github.com/JaipuriaAI/claude-c5-generator/issues
