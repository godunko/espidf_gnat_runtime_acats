idf_component_register(
    REQUIRES espidf_gnat_runtime)

ExternalProject_Add(app_main_build
    PREFIX ${COMPONENT_DIR}
    SOURCE_DIR ${COMPONENT_DIR}
    BUILD_IN_SOURCE 1
    BUILD_ALWAYS 1
    CONFIGURE_COMMAND ""
    BUILD_COMMAND alr build -- -v
    INSTALL_COMMAND ""
    BUILD_BYPRODUCTS ${COMPONENT_DIR}/../.objs/app_main.o
)

ExternalProject_Add_Step(app_main_build run_objcopy
    COMMAND ${CMAKE_OBJCOPY} --redefine-sym _ada_main=app_main ${COMPONENT_DIR}/../.objs/app_main.o
    COMMAND ${CMAKE_AR} Tcr ${COMPONENT_DIR}/../.objs/app_main.a ${COMPONENT_DIR}/../.objs/app_main.o
    COMMAND ${CMAKE_RANLIB} ${COMPONENT_DIR}/../.objs/app_main.a
    BYPRODUCTS ${COMPONENT_DIR}/../.objs/app_main.a
    DEPENDEES build
    DEPENDERS install
    ALWAYS 1
)

add_prebuilt_library(main "${COMPONENT_LIB}"
    REQUIRES espidf_gnat_runtime)
add_dependencies(main app_main_build)
add_dependencies(app_main_build espidf_gnat_runtime)

set_target_properties(main PROPERTIES IMPORTED_LOCATION
    ${COMPONENT_DIR}/../.objs/app_main.a)

target_link_libraries(
    ${COMPONENT_LIB} INTERFACE main)
