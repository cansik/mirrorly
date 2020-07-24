echo "installing all dependencies for mirrorly, this can take a while!"

:: install wget and pkconfig
choco install wget microsoft-build-tools pkgconfiglite

:: install gstreamer
echo "downloading gstreamer..."
wget -nv "https://gstreamer.freedesktop.org/data/pkg/windows/1.16.2/gstreamer-1.0-msvc-x86_64-1.16.2.msi" -O "gstreamer.msi"

echo "installing gstreamer..."
set GST_INSTALL_DIR=C:\gstreamer
set GST_ROOT=%GST_INSTALL_DIR%\1.0\x86_64

echo "gstreamer dir:"
dir "%GST_INSTALL_DIR%

echo "setting path dir..."
echo "Gstreamer Root: %GST_ROOT%"

msiexec /passive INSTALLDIR="%GST_INSTALL_DIR%" /i gstreamer.msi /L*V! "gstreamer.log"

echo "install log:"
:: type gstreamer.log

for /f "usebackq tokens=2,*" %A in (`reg query HKCU\Environment /v PATH`) do set my_user_path=%B
setx PATH "%PATH%;%GST_ROOT%\bin;%my_user_path%"

:: setx PATH "%PATH%;%GST_ROOT%\bin" /m

echo "Path: %PATH%"

:: download elements
echo "installing elements..."
git clone --recurse-submodules  https://github.com/cycfi/elements.git

echo "all done!"