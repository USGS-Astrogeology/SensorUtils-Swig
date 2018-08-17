# Include python
include(FindPythonAnaconda.cmake)
include_directories(${PYTHON_INCLUDE_DIR})

set(CMAKE_SWIG_FLAGS "")
set(CMAKE_SWIG_OUTDIR sensorutils)
set_source_files_properties(../Sensor.i 
                            PROPERTIES CPLUSPLUS ON)

# Find dependencies
find_path(SENSORUTILS_INCLUDE_DIR NAMES Sensor.h 
                          PATH_SUFFIXES sensorcore 
                          PATHS ${PYTHON_INCLUDE_DIR}/../sensorutils)
find_library(SENSORUTILS_LIBRARY NAMES sensorutils)
message("-- Found SensorUtils Include: ${SENSORUTILS_INCLUDE_DIR}")
message("-- Found Sensor Utils Lib: ${SENSORUTILS_LIBRARY}")

include_directories(${SENSORUTILS_INCLUDE_DIR})

# Add and link
swig_add_library(sensorutils
                 LANGUAGE python 
                 SOURCES ../Sensor.i)
set_target_properties(_sensorutils PROPERTIES LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SWIG_OUTDIR})
swig_link_libraries(sensorutils ${SENSORUTILS_LIBRARY} ${PYTHON_LIBRARY})

# Build out a standard directory structure
file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/tests)

# Move the static files to move
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/setup.py.in
               ${CMAKE_CURRENT_BINARY_DIR}/setup.py) 
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/__init__.py
               ${CMAKE_CURRENT_BINARY_DIR}/sensorutils/__init__.py)
