# cpp_boilerplate
A boilerplate layout for C++ projects using CMake. 

# Layout
## CMake
This folder should contain all cmake files used in the project
## Documentation
This folder contains all documentation on the project, in uncompiled form. 
## includes
The includes folder contains all public include files when developping a library. That is, when making your library available, the user of it will need to add this folder to their include directories. CMake does this for you via the PUBLIC specifier. 
## libraries
All external libraries must be added here. See my_maths for an example. 
## sources
Just like the name suggests, the sources of the project are added here. A distinction is made between code and resources, as they are both sources. 
## tests
The tests of the project are added here. Currently, only unit tests are provided, but also static code analysis projects can be added here. 
## tools
Various tools and script that are typically required by larger projects can be added in this folder. 

## special notes
* The project_name folder is added in the include folder so that includes can happen relative to the name of the library. 
* Minimal configuring is done in the CMakeLists in the source folder. This is so the potential library that is based of this repo can be included in larger projects by simply adding the subdirectory source. 


