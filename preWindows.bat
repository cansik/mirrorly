echo "installing all dependencies for mirrorly, this can take a while!"

:: install wget and pkconfig
choco install wget microsoft-build-tools pkgconfiglite

:: install gstreamer
echo "downloading gstreamer..."
wget -nv "https://gstreamer.freedesktop.org/data/pkg/windows/1.16.2/gstreamer-1.0-msvc-x86_64-1.16.2.msi" -O "gstreamer.msi"

echo "installing gstreamer..."
msiexec /passive INSTALLDIR="C:\gstreamer" /i gstreamer.msi /L*V! "gstreamer.log"

echo "install log:"
type gstreamer.log

echo "gstreamer dir:"
dir C:\gstreamer

echo "c:"
dir C:\

echo "setting path dir..."
echo "Gstreamer Root: %GSTREAMER_ROOT_X86%"

setx GSTREAMER_ROOT_X86 "C:\gstreamer" /m
setx PATH "%PATH%;%GSTREAMER_ROOT_X86%\bin" /m

echo "Gstreamer Root: %GSTREAMER_ROOT_X86%"
echo "Gstreamer Bin: %GSTREAMER_ROOT_X86%\bin"

:: download elements
echo "installing elements..."
git clone --recurse-submodules  https://github.com/cycfi/elements.git

echo "all done!"