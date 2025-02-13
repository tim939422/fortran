cmake_minimum_required(VERSION 3.21)
project(FortranOOP LANGUAGES Fortran)
cmake_policy(SET CMP0135 NEW)


# Get all .f90 files in the current source directory
file(GLOB program_sources "${CMAKE_CURRENT_SOURCE_DIR}/*.f90")

foreach(source_file ${program_sources})
    get_filename_component(program_name ${source_file} NAME_WE)  # Extract the program name without extension
    add_executable(${program_name} ${source_file})  # Create an executable with the same name
endforeach()