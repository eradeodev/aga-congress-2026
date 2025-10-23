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

## WordPress Setup Steps (after `configure.sh`)
(Note: we eventually want to automate this)

1. **Customize Theme:**
    - Customize → Homepage Settings → set Homepage to Home → Publish
    - Customize → Footer → remove “{theme-credit}” → Publish

2. **WP Super Cache Settings:**
    - Settings → WP Super Cache → Enable “Caching On” → Update Status
    - Advanced → Enable “304 Browser caching” and “Mobile device support” → Update Status
    - Preload → Enable “Preload mode” and “Preload tags” → Preload Cache Now → Save Settings

3. **Delete Unused Plugins:** ‘Hello Dolly’ and ‘Akismet Anti-spam Protection’


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
  - **WP Super Cache:** Server-side page caching; cut local page load time in half  
  - **Performance Lab:** Enabled features:  
    - Embed Optimizer  
    - Enhanced Responsive Images  
    - Image Placeholders  
    - Image Prioritizer  
    - Instant Back/Forward  
    - Modern Image Formats  
    - Speculative Loading  
  - **WP Activity Log:**  
    - Disabled “Weekly Activity log highlights email”  
    - Set activity log retention to delete events older than 3 months  
