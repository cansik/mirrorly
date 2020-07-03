cmake_minimum_required(VERSION 3.16)
project(mirrorly)

set(CMAKE_CXX_STANDARD 17)

set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/)

# GStreamer
find_package(GStreamer COMPONENTS gstreamer-sdp gstreamer-webrtc)
if (GStreamer_FOUND)
    include_directories(${GSTREAMER_INCLUDE_DIRS})
endif ()

# libsoup
find_package(LibSoup)

add_executable(mirrorly src/main.cpp)
target_link_libraries(mirrorly PRIVATE ${GSTREAMER_LIBRARIES})