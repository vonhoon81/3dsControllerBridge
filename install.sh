#!/data/data/com.termux/files/usr/bin/bash

echo -e "\033[1;36m🎮 3DS Controller Bridge Installer 🎮\033[0m"
echo "Setting up your environment..."

# 1. Update and Install Node.js + Wget
pkg update -y > /dev/null 2>&1
pkg install nodejs wget -y

# 2. Create Directory
mkdir -p ~/3ds-bridge
cd ~/3ds-bridge

# 3. Install Express (Fast, no init needed)
if [ ! -d "node_modules" ]; then
    echo "Installing dependencies..."
    npm install express --no-bin-links --no-package-lock
fi

# 4. Download Latest Files from vonhoon81/3dsControllerBridge
echo "Fetching latest version..."
REPO_URL="https://raw.githubusercontent.com/vonhoon81/3dsControllerBridge/main"
wget -q -O server.js "$REPO_URL/server.js"
wget -q -O index.html "$REPO_URL/index.html"

# 5. Create the 'One-Tap' Shortcut automatically
mkdir -p ~/.shortcuts
SHORTCUT_FILE="$HOME/.shortcuts/3DS_Bridge"

echo "#!/data/data/com.termux/files/usr/bin/bash" > "$SHORTCUT_FILE"
echo "pkill -f 'node server.js'" >> "$SHORTCUT_FILE"
echo "cd ~/3ds-bridge" >> "$SHORTCUT_FILE"
echo "node server.js > /dev/null 2>&1 &" >> "$SHORTCUT_FILE"
echo "sleep 1" >> "$SHORTCUT_FILE"
echo "am start -a android.intent.action.VIEW -d http://localhost:3000" >> "$SHORTCUT_FILE"

chmod +x "$SHORTCUT_FILE"

echo -e "\033[1;32m✅ Installation Complete!\033[0m"
echo "Launching Server..."

# 6. Launch it right now
pkill -f "node server.js"
node server.js > /dev/null 2>&1 &
sleep 2
am start -a android.intent.action.VIEW -d http://localhost:3000

echo ""
echo "👉 To play later, use the '3DS_Bridge' widget on your home screen!"
echo "   (Requires Termux:Widget app from F-Droid)"
