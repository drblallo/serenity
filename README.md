# Skirmish


### Requirements

**Mandatory:**
- A Linux distribution (the project will work on any Godot-supported platform if you modify the `CMake` file accordingly).
- Python 3.9+
- [RLC](https://github.com/rl-language/rlc/).
- CMake 3.10 or later.
- Godot 4.3.
- rlc

**Optional (to run the project in a browser):**
- Emscripten 3.39 or later.
  *(Note: Using older versions of Emscripten will fail silently and the project will not load in the browser.)*

**Build**
```
mkdir build
cd build
cmake .. -DGODOT_EDITOR=PATH/TO/Godot_v4.3
make editor
```


