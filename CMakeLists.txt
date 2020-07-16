cmake_minimum_required(VERSION 3.10)
project(mirrorly)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/)

# include Conan dependencies
include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

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

find_library(COCOA_LIBRARY Cocoa)

# executable
add_executable(mirrorly)

# link libs
target_sources(mirrorly PRIVATE src/main.cpp src/ScreenMirror.cpp src/ScreenMirror.h)
target_link_libraries(mirrorly PRIVATE ${CONAN_LIBS} cycfi::elements ${COCOA_LIBRARY})

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