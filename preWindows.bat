echo "installing all dependencies for mirrorly, this can take a while!"

REM install wget
choco install wget

REM install gstreamer
wget "https://gstreamer.freedesktop.org/data/pkg/windows/1.16.2/gstreamer-1.0-msvc-x86_64-1.16.2.msi" -O "gstreamer.msi"
dir
msiexec /passive INSTALLDIR=gstreamer /i gstreamer.msi
dir

REM needs chcholately installed
refreshenv

REM download elements
git clone --recurse-submodules  https://github.com/cycfi/elements.git

echo "all done!"