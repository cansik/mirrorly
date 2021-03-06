#!/usr/bin/env bash

echo "installing all dependencies for mirrorly, this can take a while!"

# updating / installing brew
if test -z "$TRAVIS"
then
  echo "\$TRAVIS is empty - not running on travis"
  which -s brew
  if [[ $? != 0 ]] ; then
      # Install Homebrew
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
      brew update
  fi
else
  echo "\$TRAVIS is NOT empty - running on travis"
  export HOMEBREW_NO_AUTO_UPDATE=1
fi

# install cmake and pkg-config
echo "installing cmake and pkg-config..."
brew install cmake pkg-config wget

# install gstreamer
echo "installing gstreamer and all plugins..."
brew install gstreamer gst-plugins-bad

# install elemnts dependencies
echo "installing cairo and fontconfig..."
brew install cairo
brew install fontconfig

# download elements
git clone --recurse-submodules  https://github.com/cycfi/elements.git
cd elements
git checkout develop
cd ..

echo "all done!"