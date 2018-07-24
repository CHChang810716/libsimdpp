macro(add_version major minor)
    set(PROJECT_VERSION_MAJOR ${major})
    set(PROJECT_VERSION_MINOR ${minor})
    set(PROJECT_VERSION 
        ${major}.${minor}
    )
    set(${PROJECT_NAME}_MAJOR_VERSION ${major})
    set(${PROJECT_NAME}_MINOR_VERSION ${minor})
    set(${PROJECT_NAME}_VERSION 
        ${major}.${minor}
    )
endmacro()
add_version(2 1)
message(STATUS "${PROJECT_NAME} v${${PROJECT_NAME}_VERSION}")
set(SIMDPP_API_VERSION "${PROJECT_VERSION}")