# Setting up dysk-mac for Homebrew Installation

This guide will help you make `dysk-mac` available via Homebrew installation.

## Prerequisites

1. A GitHub account
2. Homebrew installed on your Mac
3. Git installed

## Step 1: Prepare Your Repository

### 1.1 Update package.json

Make sure your `package.json` has the correct bin configuration:

```json
{
  "bin": {
    "dysk-mac": "./index.js"
  }
}
```

### 1.2 Create a Release

1. Commit all your changes
2. Create a git tag for version 1.0.0:
   ```bash
   git tag v1.0.0
   git push origin v1.0.0
   ```
3. Go to GitHub and create a release from this tag

## Step 2: Create a Homebrew Tap

### 2.1 Create a New Repository for the Tap

Create a new GitHub repository named `homebrew-dysk-mac` (the `homebrew-` prefix is important).

### 2.2 Add the Formula

Copy the formula from `tap/Formula/dysk-mac.rb` to your new repository.

### 2.3 Calculate SHA256

After creating the release, calculate the SHA256 of your release tarball:

```bash
curl -L https://github.com/nudelx/dysk-mac/archive/refs/tags/v1.0.0.tar.gz | shasum -a 256
```

Update the `sha256` line in the formula with the calculated value.

## Step 3: Test Your Tap Locally

### 3.1 Add Your Tap

```bash
brew tap nudelx/dysk-mac
```

### 3.2 Install Your Formula

```bash
brew install dysk-mac
```

### 3.3 Test the Installation

```bash
dysk-mac --help
```

## Step 4: Make it Available to Others

### 4.1 Push Your Tap

Push your `homebrew-dysk-mac` repository to GitHub.

### 4.2 Users Can Install

Anyone can now install your tool with:

```bash
brew tap nudelx/dysk-mac
brew install dysk-mac
```

## Alternative: Submit to Homebrew Core

If your tool becomes popular, you can submit it to the main Homebrew repository:

1. Fork the Homebrew/homebrew-core repository
2. Add your formula to `Formula/dysk-mac.rb`
3. Submit a pull request

## Troubleshooting

### Common Issues

1. **SHA256 mismatch**: Make sure you're using the correct SHA256 for your release
2. **Dependencies**: Ensure all dependencies are properly declared
3. **Permissions**: Make sure the script is executable

### Testing Your Formula

Test your formula locally:

```bash
brew install --build-from-source ./tap/Formula/dysk-mac.rb
```

## File Structure

Your final repository structure should look like:

```
dysk-mac/
├── index.js
├── diskutil.js
├── utils.js
├── package.json
├── README.md
└── tap/
    └── Formula/
        └── dysk-mac.rb
```

## Updating Versions

When you release a new version:

1. Update the version in `package.json`
2. Create a new git tag
3. Update the formula with the new version and SHA256
4. Push the updated formula to your tap repository

## Example Usage After Installation

Once installed via Homebrew, users can run:

```bash
# Basic usage
dysk-mac

# JSON output
dysk-mac --json

# Filter by usage
dysk-mac --filter "usedPercent > 80"

# Sort by free space
dysk-mac --sort free

# CSV output
dysk-mac --csv
```
