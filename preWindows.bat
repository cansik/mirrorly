echo "installing all dependencies for mirrorly, this can take a while!"

REM install wget and pkconfig
choco install wget
choco install pkgconfiglite
choco install microsoft-build-tools

REM install gstreamer
wget -nv "https://gstreamer.freedesktop.org/data/pkg/windows/1.16.2/gstreamer-1.0-msvc-x86_64-1.16.2.msi" -O "gstreamer.msi"
msiexec /passive INSTALLDIR=gstreamer /i gstreamer.msi /L*V! "gstreamer.log"

echo "install log:"
type gstreamer.log

REM needs chcholately installed
refreshenv

REM download elements
git clone --recurse-submodules  https://github.com/cycfi/elements.git

echo "all done!"