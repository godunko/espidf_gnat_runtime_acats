cmake_minimum_required(VERSION 3.16)
list(APPEND EXTRA_COMPONENT_DIRS "${CMAKE_CURRENT_LIST_DIR}/../../../components/espidf_gnat_runtime")
include($ENV{IDF_PATH}/tools/cmake/project.cmake)
project(acats_c6)
