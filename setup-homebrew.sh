#!/bin/bash

# Setup script for creating Homebrew tap for dysk-mac

echo "🚀 Setting up dysk-mac for Homebrew installation..."

# Check if we're in the right directory
if [ ! -f "index.js" ] || [ ! -f "package.json" ]; then
    echo "❌ Error: Please run this script from the dysk-mac directory"
    exit 1
fi

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "❌ Error: This directory is not a git repository"
    echo "Please run: git init && git add . && git commit -m 'Initial commit'"
    exit 1
fi

# Check if we have uncommitted changes
if [ -n "$(git status --porcelain)" ]; then
    echo "⚠️  Warning: You have uncommitted changes"
    echo "Please commit your changes before proceeding"
    exit 1
fi

echo "✅ Repository looks good!"

# Create tap directory if it doesn't exist
mkdir -p tap/Formula

echo "📝 Creating Homebrew formula..."

# Check if formula already exists
if [ -f "tap/Formula/dysk-mac.rb" ]; then
    echo "⚠️  Formula already exists at tap/Formula/dysk-mac.rb"
    echo "Please review and update it manually if needed"
else
    echo "✅ Formula created at tap/Formula/dysk-mac.rb"
fi

echo ""
echo "📋 Next steps:"
echo "1. Update the repository URL in tap/Formula/dysk-mac.rb"
echo "2. Create a git tag: git tag v1.0.0"
echo "3. Push the tag: git push origin v1.0.0"
echo "4. Create a GitHub release from the tag"
echo "5. Calculate SHA256 and update the formula"
echo "6. Create a new repository named 'homebrew-dysk-mac'"
echo "7. Copy the formula to the new repository"
echo ""
echo "📖 See HOMEBREW_SETUP.md for detailed instructions"
echo ""
echo "�� Setup complete!" 