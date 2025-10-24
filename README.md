# Setup & Configuration

## FULL SETUP (e.g. on VPS instance)
1. Clone the repo
2. Run `vm_setup/configure_ubuntu.sh`
3. Run `configure.sh` and specify the WP admin email/password and URL when prompted
4. Done! Access site from the production URL specified, e.g. https://gc2026.gocongress.org/wp-admin

## LOCAL DEV SETUP
1. Ensure the Docker / Docker Compose dependencies are met on your system.
2. Clone the repo
3. Run `configure.sh` and specify the WP admin email/password when prompted, and leaving the URL blank (default) 
4. Done! Access site from http://localhost:11434/wp-admin

# Site Design and Architecture

## Web Design Choices

- **Base Image:** Official [WordPress.org](http://WordPress.org) Docker image
- **Theme:** Kadence
  - Selected as a balance of popularity and a full-featured free version
  - Alternatives evaluated:
    - Blocksy – less featureful free version, newer, less popular
    - Astra – fewer features in free version, most popular paid option
    - Twenty Twenty-Five – too basic, not well-rated

- **WordPress Plugins:**
  - **Stackable – Gutenberg Blocks:** Adds blocks, patterns, and pre-built full page designs
  - **WP Super Cache:** Server-side page caching
  - **Performance Lab:** Client-side optimizations
