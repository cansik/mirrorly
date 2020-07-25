:: needs chcholately installed
:: refreshenv


:: gstlib: C:\gstreamer\1.0\x86_64\lib\gstreamer-1.0\

set "GSTREAMER_1_0_ROOT_X86_64=C:\gstreamer\1.0\x86_64"
set "PKG_CONFIG_PATH=%GSTREAMER_1_0_ROOT_X86_64%\lib\pkgconfig"
set "PATH=%GSTREAMER_1_0_ROOT_X86_64%\bin;%PATH%"

echo %PATH%
echo %GSTREAMER_1_0_ROOT_X86_64%
echo %PKG_CONFIG_PATH%

echo "building..."
mkdir build
cd build

echo "generating visual studio build..."
cmake -G "Visual Studio 15 2017" ..

dir

echo "loading vsdevcmd..."
type "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\Common7\Tools\VsDevCmd.bat"
"C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\Common7\Tools\VsDevCmd.bat" & msbuild mirrorly.sln

echo "running build..."
msbuild mirrorly.sln