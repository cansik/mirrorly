cmake_minimum_required(VERSION 3.16)
project(mirrorly)

set(CMAKE_CXX_STANDARD 17)

set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/)

# Required for GStreamer
find_package(PkgConfig)

# Look for GStreamer installation
pkg_check_modules(GST REQUIRED gstreamer-1.0)

# GStreamer
add_executable(mirrorly src/main.cpp src/ScreenMirror.cpp src/ScreenMirror.h)

target_link_libraries(mirrorly PRIVATE ${GST_LINK_LIBRARIES})
target_include_directories(mirrorly PRIVATE ${GST_INCLUDE_DIRS})
target_compile_options(mirrorly PRIVATE ${GST_CFLAGS})