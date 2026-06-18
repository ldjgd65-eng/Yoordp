#!/bin/bash

set -e  # Exit on any error

echo "🔄 Updating package lists..."
sudo apt update -y

echo "🔄 Upgrading system packages..."
sudo apt upgrade -y

echo "📥 Setting up NodeSource repository..."
curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -

echo "📦 Installing required packages..."
sudo apt install -y nodejs openjdk-21-jdk git unzip tmux

echo "🐙 Cloning FreeRDP repository..."
git clone https://github.com/ldjgd65-eng/FreeRDP.git

echo "📂 Navigating to FreeRDP directory..."
cd FreeRDP

echo "📦 Checking for mcpanelv1-updated.zip..."
if [ ! -f "mcpanelv1-updated.zip" ]; then
    echo "❌ Error: mcpanelv1-updated.zip not found in FreeRDP directory!"
    exit 1
fi

echo "📦 Extracting panel archive..."
unzip mcpanelv1-updated.zip

echo "📂 Navigating to panel directory..."
cd panel

echo "📦 Checking for app.js..."
if [ ! -f "app.js" ]; then
    echo "❌ Error: app.js not found in panel directory!"
    exit 1
fi

echo "📦 Installing pm2 globally..."
sudo npm install -g pm2@latest

echo "🚀 Starting app with pm2..."
pm start app.js

echo "🔄 Setting up pm2 to start on boot..."
pm startup

echo "💾 Saving pm2 process list..."
npm save

echo "✅ Setup completed successfully!"
echo "📋 To view running processes: pm2 list"
echo "📋 To view logs: pm2 logs"