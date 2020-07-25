echo "installing all dependencies for mirrorly, this can take a while!"

:: install wget and pkconfig
choco install wget pkgconfiglite
choco install visualstudio2019buildtools visualstudio2019-workload-nativedesktop

:: install gstreamer
echo "downloading gstreamer..."
wget -nv "https://gstreamer.freedesktop.org/data/pkg/windows/1.16.2/gstreamer-1.0-devel-msvc-x86_64-1.16.2.msi" -O "gstreamer.msi"

echo "installing gstreamer..."
set GST_INSTALL_DIR=C:\gstreamer
set GST_ROOT=%GST_INSTALL_DIR%\1.0\x86_64

echo "gstreamer dir:"
dir %GST_INSTALL_DIR%

echo "setting path dir..."
echo "Gstreamer Root: %GST_ROOT%"

msiexec /passive INSTALLDIR="%GST_INSTALL_DIR%" /i gstreamer.msi /L*V! "gstreamer.log"

echo "install log:"
:: type gstreamer.log

setx PATH "%GST_ROOT%\bin;%PATH%" /m
set "PATH=%GST_ROOT%\bin;%PATH%"
echo "Path: %PATH%"

:: refreshenv

:: download elements
echo "installing elements..."
git clone --recurse-submodules  https://github.com/cycfi/elements.git

echo "all done!"