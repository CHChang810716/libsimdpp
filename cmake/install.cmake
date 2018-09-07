include(CMakePackageConfigHelpers)
set(generated_dir       "${CMAKE_CURRENT_BINARY_DIR}/generated")
set(config_install_dir  "lib/cmake/${PROJECT_NAME}")
set(version_config      "${generated_dir}/${PROJECT_NAME}ConfigVersion.cmake")
set(project_config      "${generated_dir}/${PROJECT_NAME}Config.cmake")
set(targets_export_name "${PROJECT_NAME}Targets")
set(namespace           "${PROJECT_NAME}::")

include(GNUInstallDirs)

write_basic_package_version_file(
    "${version_config}" COMPATIBILITY SameMajorVersion
)

configure_package_config_file(
    "cmake/Config.cmake.in"
    "${project_config}"
    INSTALL_DESTINATION "${config_install_dir}"
)
install(TARGETS ${exe_targets} ${lib_targets} ${test_targets}
    EXPORT "${targets_export_name}"
    BUNDLE DESTINATION . COMPONENT Runtime
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR} COMPONENT Runtime
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR} COMPONENT Library
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR} COMPONENT Library
)
install(
    DIRECTORY simdpp
    DESTINATION include 
    COMPONENT Headers
)
install(
    FILES       
        "${project_config}"
        "${version_config}"
        "cmake/SimdppMultiarch.cmake"
    DESTINATION "${config_install_dir}"
)

install(
    EXPORT      "${targets_export_name}"
    NAMESPACE   "${namespace}"
    DESTINATION "${config_install_dir}"
)
if(INSTALL_DEPS)
    configure_file(cmake/bundle.cmake.in ${CMAKE_BINARY_DIR}/bundle.cmake @ONLY)
    install(
        SCRIPT ${CMAKE_BINARY_DIR}/bundle.cmake
        COMPONENT Dependencies
    )
endif()