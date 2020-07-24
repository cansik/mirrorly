#!/bin/bash

echo "installing all dependencies for mirrorly, this can take a while!"

# updating / installing
sudo apt update

# install cmake and pkg-config
echo "installing build deps..."
sudo apt -y install build-essential pkg-config wget
sudo snap install cmake --classic

# install deps
sudo apt -y install libcairo2-dev
sudo apt -y install libgtk-3-dev
sudo apt -y install libboost-all-dev

# install gstreamer
echo "installing gstreamer and all plugins..."
sudo apt -y install libgstreamer1.0-dev libgstreamer-plugins-bad1.0-dev
sudo apt -y install libnice-dev

# download elements
git clone --recurse-submodules  https://github.com/cycfi/elements.git

echo "all done!"