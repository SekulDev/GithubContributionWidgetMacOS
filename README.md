# GitHub Contribution Widget for macOS

A simple macOS widget that displays your GitHub contribution graph directly on your desktop.

## About This Project

This app was created in a "one-time vibe" coding session. I had never worked with Swift or macOS development before, but I wanted to see my GitHub contributions as a desktop widget - so I just built it. It's nothing fancy, just a straightforward contribution graph on your desktop.

If you have suggestions, improvements, or bug fixes, feel free to open a pull request!

## Requirements

- macOS 11.0 (Big Sur) or later
- Xcode 12.0 or later (includes Command Line Tools and Swift 5.0+)
- Git

## Installation

### 1. Install Xcode Command Line Tools

If you don't have Xcode installed, you'll need at least the Command Line Tools:

```bash
xcode-select --install
```

### 2. Clone the Repository

```bash
git clone https://github.com/SekulDev/GithubContributionWidgetMacOS.git
cd github-contribution-widget-macos
```

### 3. Build and Install

Run the installation script:

```bash
chmod +x install.sh
./install.sh
```

This script will build the application and copy it to your Applications folder.

## Widget Setup Guide

### Step 1: Generate Personal Access Token

1. Visit [GitHub Personal Access Tokens](https://github.com/settings/tokens)
2. Click **"Generate new token"**
3. Select **"Classic"** token type
4. Choose **"No expiration"** for duration
5. Check **"user:read"** permission
6. Click **"Generate token"** and copy it securely

### Step 2: Add Widget to Desktop

1. Right-click on your desktop
2. Select **"Edit Widgets"** from the menu
3. Find **"GithubContributionWidgetMacOS"** in the list
4. Drag your preferred widget size to the desktop

### Step 3: Configure Your Widget

1. Right-click on the newly added widget
2. Enter your GitHub username
3. Paste the personal access token you generated
4. Click **"Done"** to save your settings

**You're all set!** Enjoy tracking your contributions right from your desktop.

## Contributing

Contributions are welcome! Feel free to:

- Report bugs
- Suggest new features
- Submit pull requests
- Improve documentation

## License

MIT License - feel free to use this however you want.

## Acknowledgments

Built with Swift and SwiftUI for macOS. This was a fun learning experience diving into Apple's ecosystem for the first time!

---

**Note:** This is a passion project created out of personal need. The code might not be perfect, but it works!
