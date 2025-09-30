#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo "Building GitHub Contribution Widget..."

# Build the app
xcodebuild -scheme GithubContributionWidgetMacOS \
           -configuration Release \
           -derivedDataPath build \
           clean build

if [ $? -ne 0 ]; then
    echo -e "${RED}Build failed. Please check the errors above.${NC}"
    exit 1
fi

# Find the built app
APP_PATH=$(find build -name "*.app" -type d | head -n 1)

if [ -z "$APP_PATH" ]; then
    echo -e "${RED}Could not find built application.${NC}"
    exit 1
fi

# Copy to Applications
echo "Installing to Applications folder..."
cp -R "$APP_PATH" /Applications/

echo -e "${GREEN}Installation complete!${NC}"
echo "You can now find the app in your Applications folder."
echo ""
echo "Next steps:"
echo "1. Open the app to see the setup guide"
echo "2. Follow the instructions to configure your widget"
