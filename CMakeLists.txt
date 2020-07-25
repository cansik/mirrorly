cmake_minimum_required(VERSION 3.10)
project(mirrorly)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/)

# Required for GStreamer
find_package(PkgConfig)

# Look for GStreamer installation
pkg_check_modules(GST REQUIRED gstreamer-1.0)

# add elements
# set(ELEMENTS_LIBRARY_ROOT ${PROJECT_SOURCE_DIR}/elements/lib)
# add_subdirectory(${ELEMENTS_LIBRARY_ROOT})

set(ELEMENTS_ROOT ${PROJECT_SOURCE_DIR}/elements)
get_filename_component(ELEMENTS_ROOT "${ELEMENTS_ROOT}" ABSOLUTE)
set (CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH};${ELEMENTS_ROOT}/cmake")

set(ELEMENTS_BUILD_EXAMPLES OFF)
add_subdirectory(${ELEMENTS_ROOT} elements)
include(ElementsConfigCommon)

set(ELEMENTS_APP_PROJECT "Mirrorly")
set(ELEMENTS_APP_TITLE "Mirrorly")
set(ELEMENTS_APP_COPYRIGHT "Copyright (c) 2020 cansik")
set(ELEMENTS_APP_ID "ch.cansik.mirrorly")
set(ELEMENTS_APP_VERSION "1.0")

set(ELEMENTS_APP_RESOURCES)

# reset project name because of elements
project(mirrorly)

# executable
add_executable(mirrorly)

# add cocoa if on macos
if (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    set(OS_FRAMEWORK "-framework Cocoa")
endif()

# add scorelib.h
if (WIN32)
    set(OS_FRAMEWORK shcore.lib)
endif()

# link libs
target_sources(mirrorly PRIVATE src/main.cpp src/ScreenMirror.cpp src/ScreenMirror.h)
target_include_directories(mirrorly PRIVATE ${CMAKE_CURRENT_SOURCE_DIR} ${GST_INCLUDE_DIRS})
target_link_libraries(mirrorly PRIVATE ${GST_LINK_LIBRARIES} cycfi::elements ${OS_FRAMEWORK})
target_compile_options(mirrorly PRIVATE ${GST_CFLAGS}
        $<$<CXX_COMPILER_ID:GNU>:-Wall -Wextra -Wpedantic>
        $<$<CXX_COMPILER_ID:Clang>:-Wall -Wpedantic>
        $<$<CXX_COMPILER_ID:MSVC>:/W4>
        )

target_compile_features(mirrorly PRIVATE cxx_std_17)

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