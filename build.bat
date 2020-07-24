:: needs chcholately installed
:: refreshenv

echo %PATH%

echo "Gstreamer Root: %GSTREAMER_ROOT_X86%"

echo "building..."
mkdir build
cd build

echo "generating visual studio build..."
cmake -G "Visual Studio 15 2017" ..

dir

msbuild