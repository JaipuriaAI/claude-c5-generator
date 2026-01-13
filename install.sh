#!/bin/bash

# C5 Documentation Generator - Installation Script
# Installs the C5 agent and skills into your project's .claude/ directory

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print colored output
print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# Banner
echo ""
echo "╔════════════════════════════════════════════════════╗"
echo "║  C5 Documentation Generator - Installation Script  ║"
echo "╚════════════════════════════════════════════════════╝"
echo ""

# Check if target directory is provided
if [ -z "$1" ]; then
    print_error "No target directory specified"
    echo ""
    echo "Usage: ./install.sh /path/to/your-project"
    echo ""
    echo "Example:"
    echo "  ./install.sh ~/projects/my-awesome-project"
    echo ""
    exit 1
fi

TARGET_DIR="$1"

# Check if target directory exists
if [ ! -d "$TARGET_DIR" ]; then
    print_error "Directory not found: $TARGET_DIR"
    exit 1
fi

print_info "Target directory: $TARGET_DIR"
echo ""

# Check if .claude/ directory exists
CLAUDE_DIR="$TARGET_DIR/.claude"
if [ ! -d "$CLAUDE_DIR" ]; then
    print_warning ".claude/ directory not found"
    print_info "Creating .claude/ directory structure..."
    mkdir -p "$CLAUDE_DIR/agents"
    mkdir -p "$CLAUDE_DIR/skills"
    print_success "Created .claude/ directory"
else
    print_success "Found .claude/ directory"
fi

# Ensure agents/ and skills/ subdirectories exist
mkdir -p "$CLAUDE_DIR/agents"
mkdir -p "$CLAUDE_DIR/skills"

echo ""
print_info "Installing C5 Documentation Generator..."
echo ""

# Copy agent file
AGENT_FILE="c5-documentation-generator.md"
print_info "Installing agent: $AGENT_FILE"
cp ".claude/agents/$AGENT_FILE" "$CLAUDE_DIR/agents/"
print_success "Installed agent"

# Copy skill files
SKILL_FILES=(
    "c5-discover-automation.md"
    "c5-analyze-git-history.md"
    "c5-analyze-content.md"
    "c5-generate-docs.md"
)

echo ""
print_info "Installing skills..."
for skill in "${SKILL_FILES[@]}"; do
    print_info "  - $skill"
    cp ".claude/skills/$skill" "$CLAUDE_DIR/skills/"
done
print_success "Installed ${#SKILL_FILES[@]} skills"

# Summary
echo ""
echo "╔════════════════════════════════════════════════════╗"
echo "║              Installation Complete! ✓              ║"
echo "╚════════════════════════════════════════════════════╝"
echo ""
print_success "C5 Documentation Generator installed successfully!"
echo ""

# Print next steps
print_info "Next steps:"
echo ""
echo "  1. Navigate to your project directory:"
echo "     cd $TARGET_DIR"
echo ""
echo "  2. Run the C5 agent:"
echo "     /agent c5-documentation-generator"
echo ""
echo "  3. View generated documentation:"
echo "     ls docs/architecture/c5-*.md"
echo ""

# Print file locations
print_info "Installed files:"
echo "  Agent:"
echo "    $CLAUDE_DIR/agents/$AGENT_FILE"
echo ""
echo "  Skills:"
for skill in "${SKILL_FILES[@]}"; do
    echo "    $CLAUDE_DIR/skills/$skill"
done
echo ""

# Check for git
if command -v git &> /dev/null; then
    if [ -d "$TARGET_DIR/.git" ]; then
        print_success "Git repository detected - Phase 2 (git analysis) will work!"
    else
        print_warning "No git repository found - Phase 2 (git analysis) will be skipped"
        print_info "Initialize git to enable git history analysis:"
        echo "     cd $TARGET_DIR && git init"
        echo ""
    fi
else
    print_warning "Git not installed - Phase 2 (git analysis) will be skipped"
fi

# Final message
print_info "For more information, visit:"
echo "  https://github.com/yourusername/claude-c5-generator"
echo ""
print_success "Happy documenting! 🎉"
echo ""
