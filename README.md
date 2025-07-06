# 💾 dysk-mac

A command-line disk utility for macOS that provides detailed information about mounted disks, including usage statistics, disk types, and external drive detection.

## Features

- 📊 **Disk Information**: View detailed information about all mounted disks
- 🔍 **Filtering**: Filter disks based on usage percentage, free space, and other criteria
- 📈 **Sorting**: Sort results by any disk property
- 📋 **Multiple Output Formats**: Display as table, JSON, or CSV
- 💾 **Smart Detection**: Automatically detects SSD vs HDD, external drives, and removable media
- 🎯 **macOS Optimized**: Uses native macOS `diskutil` and `df` commands

## Installation

### Option 1: Homebrew (Recommended)

Install via Homebrew tap:

```bash
brew tap nudelx/dysk-mac
brew install dysk-mac
```

### Option 2: Manual Installation

1. Clone or download this repository
2. Install dependencies:
   ```bash
   npm install
   ```
3. Make the script executable:
   ```bash
   chmod +x index.js
   ```
4. (Optional) Create a global link:
   ```bash
   npm link
   ```

## Usage

### Basic Usage

Display all mounted disks in a formatted table:

```bash
./index.js
# or if globally linked:
dysk-mac
```

### Command Line Options

| Option     | Description                    | Example                                |
| ---------- | ------------------------------ | -------------------------------------- |
| `--json`   | Output as JSON format          | `dysk-mac --json`                      |
| `--csv`    | Output as CSV format           | `dysk-mac --csv`                       |
| `--filter` | Filter disks using expressions | `dysk-mac --filter "usedPercent > 80"` |
| `--sort`   | Sort by disk property          | `dysk-mac --sort free`                 |

### Examples

#### 1. Basic Disk Information

```bash
dysk-mac
```

Output:

```
┌────────────────┬────────────────────────────┬───────────┬───────────┬────────┬───────────┬──────┬──────────┐
│ Disk           │ Mount                      │ Size (GB) │ Used (GB) │ Used % │ Free (GB) │ Type │ External │
├────────────────┼────────────────────────────┼───────────┼───────────┼────────┼───────────┼──────┼──────────┤
│ /dev/disk3s1s1 │ /                          │ 460.4     │ 10.5      │ 5%     │ 249.9     │ HDD  │ No       │
│ /dev/disk3s6   │ /System/Volumes/VM         │ 460.4     │ 0.0       │ 1%     │ 249.9     │ HDD  │ No       │
│ /dev/disk3s5   │ /System/Volumes/Data       │ 460.4     │ 192.3     │ 44%    │ 249.9     │ HDD  │ No       │
└────────────────┴────────────────────────────┴───────────┴───────────┴────────┴───────────┴──────┴──────────┘
```

#### 2. Filter Disks by Usage

Show only disks with more than 70% usage:

```bash
dysk-mac --filter "usedPercent > 70"
```

#### 3. Sort by Free Space

Display disks sorted by available free space (largest first):

```bash
dysk-mac --sort free
```

#### 4. JSON Output

Get machine-readable JSON format:

```bash
dysk-mac --json
```

Output:

```json
[
  {
    "filesystem": "/dev/disk1s1",
    "size": 500107862016,
    "used": 375080869888,
    "free": 125026992128,
    "usedPercent": 75,
    "mount": "/",
    "type": "SSD",
    "removable": false,
    "external": false
  }
]
```

#### 5. CSV Output

Export data for spreadsheet analysis:

```bash
dysk-mac --csv
```

#### 6. Combined Filtering and Sorting

Find external drives with low free space, sorted by usage:

```bash
dysk-mac --filter "external && free < 50e9" --sort usedPercent
```

### Filter Expressions

The `--filter` option accepts JavaScript expressions that can reference any disk property:

| Property      | Description                 | Example                            |
| ------------- | --------------------------- | ---------------------------------- |
| `usedPercent` | Percentage of disk used     | `usedPercent > 80`                 |
| `free`        | Free space in bytes         | `free < 10e9` (less than 10GB)     |
| `size`        | Total disk size in bytes    | `size > 500e9` (larger than 500GB) |
| `external`    | Boolean for external drives | `external` (only external drives)  |
| `type`        | Disk type ("SSD" or "HDD")  | `type === "SSD"`                   |
| `removable`   | Boolean for removable media | `removable`                        |

### Advanced Filter Examples

```bash
# Show only SSDs with high usage
dysk-mac --filter "type === 'SSD' && usedPercent > 90"

# Show external drives with less than 20GB free
dysk-mac --filter "external && free < 20e9"

# Show non-system drives (not mounted at /)
dysk-mac --filter "mount !== '/'"

# Show drives with more than 1TB total size
dysk-mac --filter "size > 1e12"
```

## Output Fields

| Field         | Description                              |
| ------------- | ---------------------------------------- |
| **Disk**      | Device path (e.g., `/dev/disk1s1`)       |
| **Mount**     | Mount point (e.g., `/`, `/Volumes/Data`) |
| **Size (GB)** | Total disk size in gigabytes             |
| **Used (GB)** | Used space in gigabytes                  |
| **Used %**    | Percentage of disk space used            |
| **Free (GB)** | Available space in gigabytes             |
| **Type**      | Disk type: SSD or HDD                    |
| **External**  | Whether the drive is external (Yes/No)   |

## Requirements

- macOS (uses `diskutil` and `df` commands)
- Node.js 14+ (for ES modules support)

## Dependencies

- `cli-table3`: For formatted table output
- `yargs`: For command-line argument parsing

## License

MIT License - feel free to use and modify as needed.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## Troubleshooting

### Permission Issues

If you get permission errors, ensure the script is executable:

```bash
chmod +x index.js
```

### No Output

If no disks are shown, check that you have mounted disks and the script has permission to run `diskutil` commands.

### Filter Not Working

Make sure your filter expression is valid JavaScript. Common issues:

- Use `&&` for AND, `||` for OR
- Use `===` for exact equality
- Numbers should be in bytes (use `e9` for GB, `e12` for TB)

## For Developers

### Setting up Homebrew Tap

To make this tool available via Homebrew, see `HOMEBREW_SETUP.md` for detailed instructions.

Quick setup:

```bash
./setup-homebrew.sh
```

### Building from Source

```bash
git clone https://github.com/yourusername/dysk-mac.git
cd dysk-mac
npm install
chmod +x index.js
./index.js
```
