:: needs chcholately installed
:: refreshenv


:: gstlib: C:\gstreamer\1.0\x86_64\lib\gstreamer-1.0\

echo %PATH%

echo "building..."
mkdir build
cd build

echo "generating visual studio build..."
cmake -G "Visual Studio 15 2017" ..

dir

:: msbuild