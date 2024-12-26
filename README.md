# cpp_boilerplate
A boilerplate layout for C++ projects using CMake. 

```
project\_root/
├── cmake/              # CMake configuration/helper files
├── documentation/      # Project documentation (uncompiled)
├── includes/           # Public header files for the library
├── libraries/          # External dependencies or third-party libraries
├── sources/            # Source code files and resources
├── tests/              # Unit tests and static code analysis
├── tools/              # Various project utilities and scripts
└── CMakeLists.txt      # Top-level CMake configuration
```

Getting started
----------------
This section will explain what parts you should change to make to turn this boilerplate into your next project!
1. Copy this repo and place it it in your development environemnt.
    * Alternatively you can use the template feature of Github to get started. 
2. Update the top-level CMakeLists.txt.
    * Do a find and replace for cpp_boilerplate and replace it with your own name. 
    * Remove or comment out the line with set_target_propertie(my_maths ... 
3. In the includes folder, change the folder name of cpp_boilerplate to the name of your project. 
4. In sources/code/ change the folder name of cpp_boilerplate to the name fo your project.
5. Update sources/CMakeLists.txt 
    * Do a find and replace of cpp_boilerplate and replace it with your project name. 
    * Remove or change the resources depending on what you need.  
    * Remove the target_link_libraries of my_maths.
    * In case of developping an executable: 
        * Keep the main.cpp and  add_executable.
    * In case of developping a library:
        * Change the main.cpp file to a file befitting of your library. 
        * Change add_executable to add_library statement in sources/CMakeLists.txt. 
6. Manage the external libraries
    * Remove my_maths
        * From the libraries/CMakeLists.txt
        * From the folder libraries
    * Add your dependencies in libraries and update the libraries/CMakeLists.txt

Configuring
----------------
Unit tests are optional and can be disbaled with -DUSE_UNIT_TESTS=0 

With unit testing:
```
mkdir build && cmake -Bbuild
```

Without unit testing:
```
mkdir build && cmake -Bbuild -DUSE_UNIT_TESTS=0 
```


Building
----------------
```
cmake --build build
```
Folder Breakdown
----------------

### CMake/

Contains all the CMake configuration files necessary for the project. It does not contain the top-level CMakeLists.txt but instead any CMake modules or helper scripts used for building, packaging, or testing the project.

### Documentation/

This folder holds all uncompiled project documentation. It can include markdown files, design documents, specifications, or any other form of written content.

### includes/

Holds the public header files of the project in case it's a library. These headers are the interfaces that users of your library will include in their projects. The CMake configuration ensures this folder is exposed correctly to users by using the PUBLIC specifier.

*   **Special Note**: The top-level project folder (e.g., project\_name/) is  placed in this directory to allow for relative inclusion.
    

### libraries/

Contains all third-party or external libraries required by the project. Each external library should be placed in a subfolder, and its integration into the build system should be handled here.

*   **Example**: A math library is included as an example. Ideally the my_maths library has the same folder structure and only the sources and includes folder are required here. 

### sources/

This folder contains the source files for your project, including both C++ code and any resources (such as images, configuration files, etc.) that are part of the project.

* **Note**: Sources contains the CMakeLists.txt required for constructing the project, without any configuration. Disabling warnings, handling compiler and linker flags, ... are all done in the top level CMakeLists.txt in the root of this project. The intent here is that if this were a library, the impporter of this library also controls linker and compiler flags and will do this in it's own top level CMakeLists.txt. The CMakeLists.txt in sources must be kept free of configuration related elemenets as much as possible. It's sole purpose is to set up the structure of the project.
* **note**: The content in resources is added to a list in the sources/CMakeLists.txt called RESOURCES. They are added to the project as resources and a custom post_build command exists to copy the resources over to the binary directory. When working with Visual Studio, the VS_DEBUGGER_WORKING_DIRECTORY property is already set to the output directory, meaning that your resources will be found if you use relative paths like "./resources/some_data.txt". 
  
### tests/

This folder contains tests for the project, both static and dynamic tests. 

*   **Note**: Currently, this boilerplate only includes unit tests with GoogleTest. 
*   A configuration for static code analysis tools such as Cppcheck can be added here.

### tools/

A dedicated folder for any tools or scripts that support the project, such as code generation scripts, build utilities, deployment scripts, or setup tools. This is particularly useful for larger projects that have complex workflows or require automation.