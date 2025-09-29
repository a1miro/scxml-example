# Custom FindWrapOpenGL.cmake to avoid AGL framework issues on macOS
# This overrides Qt6's FindWrapOpenGL.cmake to remove AGL dependency

if(WrapOpenGL_FOUND)
    return()
endif()

find_package(OpenGL)

if(OpenGL_FOUND)
    if(NOT TARGET WrapOpenGL::WrapOpenGL)
        add_library(WrapOpenGL::WrapOpenGL INTERFACE IMPORTED)
        if(APPLE)
            # On macOS, use only the OpenGL framework, not AGL
            target_link_libraries(WrapOpenGL::WrapOpenGL INTERFACE 
                "-framework OpenGL"
                "-framework AppKit"
            )
        else()
            target_link_libraries(WrapOpenGL::WrapOpenGL INTERFACE ${OPENGL_LIBRARIES})
        endif()
        target_include_directories(WrapOpenGL::WrapOpenGL INTERFACE ${OPENGL_INCLUDE_DIR})
    endif()
    set(WrapOpenGL_FOUND TRUE)
else()
    set(WrapOpenGL_FOUND FALSE)
endif()