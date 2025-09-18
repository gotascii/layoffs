# Layoffs Tracker for Tidbyt

A Tidbyt display app that shows real-time layoff statistics from [layoffs.fyi](https://layoffs.fyi), displaying the number of companies and employees affected by layoffs.

## Overview

This project scrapes layoff data from layoffs.fyi and displays it on a Tidbyt LED display. It shows:

- Total number of companies with layoffs
- Total number of employees affected
- Clean, colorful display optimized for the Tidbyt's 64x32 pixel screen

## Features

- Real-time data fetching from layoffs.fyi
- Automated Docker containerization
- GitHub Actions CI/CD pipeline
- ARM64 support for Raspberry Pi deployment
- Configurable display colors and fonts

## Files

- `layoffs.star` - Main Starlark script that fetches and displays layoff data
- `Dockerfile` - Multi-stage Docker build using Alpine Linux with Pixlet
- `.github/workflows/build.yml` - GitHub Actions workflow for automated builds
- `.env` - Environment variables for Tidbyt API configuration

## Setup

### Prerequisites

- Tidbyt device
- Tidbyt API token
- Docker (for containerized deployment)

### Environment Variables

Create a `.env` file with your Tidbyt credentials:

```bash
TIDBYT_API_TOKEN=your_api_token_here
TIDBYT_DEVICE_ID=your_device_id_here
```

### Local Development

1. Install [Pixlet](https://github.com/tidbyt/pixlet)
2. Clone this repository
3. Run the app locally:

   ```bash
   pixlet render layoffs.star
   pixlet push $TIDBYT_DEVICE_ID layoffs.webp --api-token $TIDBYT_API_TOKEN
   ```

### Docker Deployment

The project includes a Dockerfile that builds a complete environment with Pixlet:

```bash
docker build -t layoffs-tracker .
docker run --env-file .env layoffs-tracker
```

### Automated Deployment

The GitHub Actions workflow automatically:

1. Builds a Docker image for ARM64 (Raspberry Pi)
2. Pushes to GitHub Container Registry
3. Triggers on pushes to main branch

Pull the pre-built image:

```bash
docker pull ghcr.io/gotascii/layoffs:latest
```

## Display Configuration

The app uses the following display settings:

- Font: `tom-thumb` (compact 4x6 pixel font)
- Background: Dark gray (`#111`)
- Title: Blue (`#55f`)
- Labels: Light gray (`#eee`)
- Numbers: Red (`#f00`)

## Data Source

The app scrapes data from [layoffs.fyi](https://layoffs.fyi) by:

1. Fetching the main page HTML
2. Parsing elements with ID `#numbers2024`
3. Extracting `.big-number` class values for company and employee counts

## Contributing

1. Fork the repository
2. Make your changes
3. Test locally with Pixlet
4. Submit a pull request

## License

This project is provided as-is for personal use with Tidbyt devices.
