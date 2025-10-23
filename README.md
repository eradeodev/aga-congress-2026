# FULL SETUP (e.g. on VPS instance)
1. Clone the repo
2. Run `vm_setup/configure_ubuntu.sh`
3. Run `configure.sh` and specify the WP admin email/password and URL when prompted
4. Done! Access site from the production URL specified, e.g. https://gc2026.gocongress.org/wp-admin

# LOCAL DEV SETUP
1. Ensure the Docker / Docker Compose dependencies are met on your system.
2. Clone the repo
3. Run `configure.sh` and specify the WP admin email/password when prompted, and leaving the URL blank (default) 
4. Done! Access site from http://localhost:11434/wp-admin
