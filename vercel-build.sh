#!/bin/bash
# Build script for Vercel deployment

# Exit on error
set -e

# Install Flutter
echo "Installing Flutter..."
git clone https://github.com/flutter/flutter.git -b stable --depth 1 $HOME/flutter
export PATH="$HOME/flutter/bin:$PATH"

# Verify Flutter installation
echo "Flutter version:"
flutter --version

# Enable web support
echo "Enabling web support..."
flutter config --enable-web

# Clean previous builds
echo "Cleaning previous builds..."
flutter clean

# Get dependencies
echo "Getting dependencies..."
flutter pub get

# Build the web app with base href set to /
echo "Building web app..."
flutter build web --release --base-href /

echo "Build completed successfully!"
echo "Build output location: build/web"

# List build output for debugging
ls -la build/web/
