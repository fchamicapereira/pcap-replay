cmake_minimum_required(VERSION 3.5)
project(pcap-replay)

###############################################################################
# Configuring C++ standard version
###############################################################################

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

###############################################################################
# Configuring C standard version
###############################################################################

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED True)
set(CMAKE_C_EXTENSIONS True)

###############################################################################
# Setting some complation flags
###############################################################################

add_compile_options(-m64 -O3 -march=native -g -Wall -Wextra -Werror -Wfatal-errors)

###############################################################################
# Setting output targets
###############################################################################

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

###############################################################################
# Getting the modules
###############################################################################

set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")

###############################################################################
# libPCAP
###############################################################################

find_package(PCAP REQUIRED)

if (PCAP_FOUND)
    message(STATUS "Found libpcap")
    include_directories(${PCAP_INCLUDE_DIR})
    link_directories(${PCAP_LIBRARIES}/../)

    message(PCAP_INCLUDE_DIR="${PCAP_INCLUDE_DIR}")
    message(PCAP_LIBRARIES="${PCAP_LIBRARIES}")

else()
    message (FATAL_ERROR "libpcap not found")
endif()

###############################################################################
# DPDK
###############################################################################

find_package(DPDK REQUIRED)

message(DPDK_INCLUDE_DIRS="${DPDK_INCLUDE_DIRS}")
message(DPDK_LIBRARY_DIRS="${DPDK_LIBRARY_DIRS}")

include_directories(${DPDK_INCLUDE_DIRS})
link_directories(${DPDK_LIBRARY_DIRS})

###############################################################################
# Getting the source files
###############################################################################

file(GLOB SOURCES ${PROJECT_SOURCE_DIR}/src/*.c ${PROJECT_SOURCE_DIR}/src/*.cpp)

###############################################################################
# Building the executable
###############################################################################

add_executable(${PROJECT_NAME} ${SOURCES})

# https://stackoverflow.com/questions/56381463/executable-missing-full-library-path-after-build
# cmake black magic...
target_link_options(${PROJECT_NAME} PUBLIC "-Wl,--disable-new-dtags")

target_link_libraries(${PROJECT_NAME} ${DPDK_LIBRARIES})
target_link_libraries(${PROJECT_NAME} ${PCAP_LIBRARIES})
