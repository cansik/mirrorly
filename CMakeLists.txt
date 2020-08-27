cmake_minimum_required(VERSION 3.10)
project(mirrorly LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 17)

# Required for GStreamer
find_package(PkgConfig)

# Look for GStreamer installation
pkg_check_modules(GST REQUIRED gstreamer-1.0)

# elements
set(ELEMENTS_ROOT ${PROJECT_SOURCE_DIR}/elements)
get_filename_component(ELEMENTS_ROOT "${ELEMENTS_ROOT}" ABSOLUTE)
set (CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH};${ELEMENTS_ROOT}/cmake")

set(ELEMENTS_BUILD_EXAMPLES OFF)

# If we are building outside the project, you need to set ELEMENTS_ROOT:
if (NOT ELEMENTS_BUILD_EXAMPLES)
    include(ElementsConfigCommon)
    set(ELEMENTS_BUILD_EXAMPLES OFF)
    add_subdirectory(${ELEMENTS_ROOT} elements)
endif()

set(ELEMENTS_APP_PROJECT "mirrorly")
set(ELEMENTS_APP_TITLE "Elements Example")
set(ELEMENTS_APP_COPYRIGHT "Copyright (c) 2020 cansik")
set(ELEMENTS_APP_ID "ch.cansik.example")
set(ELEMENTS_APP_VERSION "1.0")

set(ELEMENTS_APP_RESOURCES)
include(ElementsConfigApp)

# link libs
target_sources(mirrorly PRIVATE src/ScreenMirror.cpp src/ScreenMirror.h)
target_include_directories(mirrorly PRIVATE ${CMAKE_CURRENT_SOURCE_DIR} ${GST_INCLUDE_DIRS})
target_link_libraries(mirrorly PRIVATE ${GST_LINK_LIBRARIES} cycfi::elements ${OS_FRAMEWORK})

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