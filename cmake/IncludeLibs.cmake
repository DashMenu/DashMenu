cmake_minimum_required(VERSION 3.21)
add_library(third_party INTERFACE)

# Include libraries
add_library(imgui INTERFACE)
CPMAddPackage("gh:DashMenu/imgui#dac32cb")
target_include_directories(imgui INTERFACE ${imgui_SOURCE_DIR})
target_sources(imgui INTERFACE
    ${imgui_SOURCE_DIR}/imgui.cpp
    ${imgui_SOURCE_DIR}/imgui_widgets.cpp
    ${imgui_SOURCE_DIR}/imgui_tables.cpp
    ${imgui_SOURCE_DIR}/imgui_draw.cpp
    ${imgui_SOURCE_DIR}/imgui_demo.cpp
    ${imgui_SOURCE_DIR}/misc/cpp/imgui_stdlib.cpp
)
set(HAS_IMGUI ON)

CPMAddPackage("gh:DashMenu/gd-imgui-cocos#2a18eac")
CPMAddPackage("gh:DashMenu/GDReplayFormat#4950cc2")
CPMAddPackage("gh:DashMenu/rift#c3f1c29")
CPMAddPackage("gh:DashMenu/subprocess#e12740b")
CPMAddPackage(
    NAME DashMenu_cppjson
    GITHUB_REPOSITORY nlohmann/json
    VERSION 3.11.3
)

# Fix debug build
if (CMAKE_BUILD_TYPE STREQUAL "Debug" AND WIN32)
    target_compile_definitions(rift PRIVATE _HAS_ITERATOR_DEBUGGING=0)
endif()

# Link them to the project
target_link_libraries(third_party INTERFACE
    libGDR
    subprocess
    imgui
    imgui-cocos
    DashMenu_cppjson::DashMenu_cppjson
    rift
)
