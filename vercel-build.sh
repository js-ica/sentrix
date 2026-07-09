#!/bin/bash
# Build script for Vercel deployment

# Install Flutter
git clone https://github.com/flutter/flutter.git -b stable --depth 1 $HOME/flutter
export PATH="$HOME/flutter/bin:$PATH"

# Enable web support
flutter config --enable-web

# Build the web app
flutter build web --release

# The output will be in build/web