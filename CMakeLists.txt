cmake_minimum_required(VERSION 3.16)
project(mirrorly)

set(CMAKE_CXX_STANDARD 17)

set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/)

# Required for GStreamer
find_package(PkgConfig)

# Look for GStreamer installation
pkg_check_modules(GST REQUIRED gstreamer-1.0)

# add elements
set(ELEMENTS_BUILD_EXAMPLES OFF)
add_subdirectory(elements)

set(ELEMENTS_APP_PROJECT "Mirrorly")
set(ELEMENTS_APP_TITLE "Mirrorly")
set(ELEMENTS_APP_COPYRIGHT "Copyright (c) 2020 cansik")
set(ELEMENTS_APP_ID "ch.cansik.mirrorly")
set(ELEMENTS_APP_VERSION "1.0")

find_library(COCOA_LIBRARY Cocoa)

# executable
add_executable(mirrorly src/main.cpp src/ScreenMirror.cpp src/ScreenMirror.h)

# link libs
target_link_libraries(mirrorly PRIVATE ${GST_LINK_LIBRARIES} elements ${COCOA_LIBRARY})
target_include_directories(mirrorly PRIVATE ${GST_INCLUDE_DIRS} ${CMAKE_CURRENT_SOURCE_DIR}/elements/lib/include)
target_compile_options(mirrorly PRIVATE ${GST_CFLAGS})

ADD_CUSTOM_TARGET(debug
        COMMAND ${CMAKE_COMMAND} -DCMAKE_BUILD_TYPE=Debug ${CMAKE_SOURCE_DIR}
        COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} --target all
        COMMENT "Switch CMAKE_BUILD_TYPE to Debug"
        )

ADD_CUSTOM_TARGET(release
        COMMAND ${CMAKE_COMMAND} -DCMAKE_BUILD_TYPE=Release ${CMAKE_SOURCE_DIR}
        COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} --target all
        COMMENT "Switch CMAKE_BUILD_TYPE to Release"
        )