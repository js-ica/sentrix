# sentrix

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Deploying to Vercel

This project is configured for easy deployment to Vercel.

### Prerequisites

- A Vercel account (sign up at [vercel.com](https://vercel.com))
- Vercel CLI installed (optional, for CLI deployment)

### Deploy via Vercel Dashboard

1. Push your code to a Git repository (GitHub, GitLab, or Bitbucket)
2. Import your repository in the Vercel dashboard
3. Vercel will automatically detect the configuration and use the `vercel.json` and `vercel-build.sh` files
4. Click "Deploy" and your app will be built and deployed

### Deploy via Vercel CLI

1. Install Vercel CLI: `npm i -g vercel`
2. Run `vercel` in the project root directory
3. Follow the prompts to deploy

The `vercel.json` file configures the build process to use a custom build script that installs Flutter and builds the web app. The `vercel-build.sh` script handles the Flutter installation and web build process.
