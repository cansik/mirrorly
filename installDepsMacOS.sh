#!/bin/zsh

echo "installing all dependencies for mirrorly, this can take a while!"

# updating / installing brew
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update
fi

# install cmake and pkg-config
echo "installing cmake and pkg-config..."
brew install cmake pkg-config wget

# install gstreamer
echo "installing gstreamer and all plugins..."
brew install gstreamer gst-plugins-bad

echo "all done!"