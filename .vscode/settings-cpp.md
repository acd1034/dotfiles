# Library path & compiler flag
## c_cpp_properties.json
- includePath
- cppStandard

## tasks.json
- DCMAKE_TOOLCHAIN_FILE
- compiler flag `-std=c++`
- compiler flag `-I`
- compiler flag `-L`

# CMakeLists.txt
- Replace `Iris` with your project name.
- Replace `IRIS` with your capitalized project name.
- DIRECTORY include/iris
- target_compile_features

# Doxyfile
- The following items should be overwritten:
```sh
PROJECT_NAME           = iris
PROJECT_NUMBER
PROJECT_BRIEF
PROJECT_LOGO
INPUT                  = README.md \
                         include/iris
EXAMPLE_PATH           = examples
EXAMPLE_RECURSIVE      = YES
MACRO_EXPANSION        = YES

# doxygen-awesome-css
GENERATE_TREEVIEW      = YES
HTML_EXTRA_STYLESHEET  = "submodules/doxygen-awesome-css/doxygen-awesome.css" \
                         "submodules/doxygen-awesome-css/doxygen-awesome-sidebar-only.css"
HTML_COLORSTYLE_HUE    = 209
HTML_COLORSTYLE_SAT    = 255
HTML_COLORSTYLE_GAMMA  = 113
```

# Submodule
```sh
git submodule add https://github.com/jothepro/doxygen-awesome-css.git submodules/doxygen-awesome-css
cd submodules/doxygen-awesome-css
git checkout v2.0.3
git submodule update --init
```
