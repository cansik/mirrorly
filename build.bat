:: needs chcholately installed
:: refreshenv


:: gstlib: C:\gstreamer\1.0\x86_64\lib\gstreamer-1.0\

set "GSTREAMER_1_0_ROOT_X86_64=C:\gstreamer\1.0\x86_64"
set "PKG_CONFIG_PATH=%GSTREAMER_1_0_ROOT_X86_64%\lib\pkgconfig"

for /f "usebackq tokens=2,*" %A in (`reg query HKCU\Environment /v PATH`) do set my_user_path=%B
setx PATH "%GSTREAMER_1_0_ROOT_X86_64%\bin;%my_user_path%"

echo %PATH%
echo %GSTREAMER_1_0_ROOT_X86_64%
echo %PKG_CONFIG_PATH%

echo "building..."
mkdir build
cd build

echo "generating visual studio build..."
cmake -G "Visual Studio 15 2017" ..

dir

:: msbuild