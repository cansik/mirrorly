echo "building..."
mkdir build
cd build
cmake -G "Visual Studio 15 2017" ..
dir
msbuild