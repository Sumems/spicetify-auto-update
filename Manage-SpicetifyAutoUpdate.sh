#!/bin/bash

# ==========================================
# Spicetify Shortcut Manager for Linux
# Author: Sumems
# ==========================================

APP_NAME="Spotify (Spicetify)"
DESKTOP_FILE="$HOME/.local/share/applications/spotify-spicetify.desktop"

install_automation() {
    echo ""
    echo "=== INSTALLING SHORTCUT ==="
    
    # Check if Spicetify is in PATH or widely available
    if ! command -v spicetify &> /dev/null; then
        echo "[WARNING] 'spicetify' command not found in PATH."
        echo "Please ensure Spicetify is installed and added to your PATH."
    fi

    # Create .desktop file content
    cat <<EOF > "$DESKTOP_FILE"
[Desktop Entry]
Type=Application
Name=$APP_NAME
Comment=Launch Spotify with Spicetify Auto-Update
Exec=sh -c "spicetify update && spotify"
Icon=spotify
Terminal=false
Categories=Audio;Music;Player;AudioVideo;
StartupWMClass=spotify
EOF

    # Make it executable (optional but good practice)
    chmod +x "$DESKTOP_FILE"

    echo "[OK] Desktop Entry Created: $DESKTOP_FILE"
    echo "You should now see '$APP_NAME' in your application menu."
    echo ""
    echo "Installation Complete!"
}

uninstall_automation() {
    echo ""
    echo "=== UNINSTALLING SHORTCUT ==="
    
    if [ -f "$DESKTOP_FILE" ]; then
        rm "$DESKTOP_FILE"
        echo "[OK] Desktop Entry Removed."
    else
        echo "[INFO] Desktop Entry not found."
    fi
    
    echo ""
    echo "Uninstallation Complete."
}

# Interactive Menu
clear
echo "Spicetify Shortcut Manager (Linux)"
echo "=================================="
echo "1. Install Shortcut"
echo "2. Uninstall Shortcut"
echo "3. Exit"
echo "=================================="

read -p "Choose an option (1-3): " choice

case $choice in
    1) install_automation ;;
    2) uninstall_automation ;;
    3) echo "Exiting..." ;;
    *) echo "Invalid option. Exiting..." ;;
esac
