### Setup & Configuration

#### FULL SETUP (e.g. on VPS instance)
1. Clone the repo
2. Run `vm_setup/configure_ubuntu.sh`
3. Run `configure.sh` and specify the WP admin email/password and URL when prompted
4. Done! Access site from the production URL specified, e.g. https://gc2026.gocongress.org/wp-admin

#### LOCAL DEV SETUP
1. Ensure the Docker / Docker Compose dependencies are met on your system.
2. Clone the repo
3. Run `configure.sh` and specify the WP admin email/password when prompted, and leaving the URL blank (default) 
4. Done! Access site from http://localhost:11434/wp-admin

### Site Architecture and Technology Choices

#### WordPress Platform Rationale

* **Why WordPress?**
  * Well-established CMS with a large plugin/theme ecosystem.
  * Non-technical volunteers can edit and manage content easily.
  * Mature support for caching, performance optimization, and security hardening.
  * Easier long-term maintenance than a fully custom site.

#### WordPress Implementation Details

* **Base Image:** Official [WordPress.org](https://wordpress.org) Docker image
  * Chosen for reliability, security updates, and easy containerization.
* **Theme:** Kadence
  * Selected for its feature-rich free version, strong reviews/popularity, and flexibility.
  * **Alternatives considered:**
    * *Blocksy:* less featureful free version, smaller user base.
    * *Astra:* limited free features, seemed primarily geared toward paid tiers.
    * *Twenty Twenty-Five:* too minimal, not especially popular.
* **Plugins:**
  * **Stackable – Gutenberg Blocks:** adds blocks, patterns, and pre-built designs.
  * **WP Super Cache:** improves load times with server-side caching.
  * **Performance Lab:** enhances client-side performance optimizations.