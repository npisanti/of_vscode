## of_vscode.sh

bash script for generating VSCode openFrameworks project with enabled intellisense, tested on:
- Debian 9
- openFrameworks 0.10.0 gcc6
- Microsoft Visual Studio Code IDE 1.27.2

# install visual studio code
You have to install the [.deb package](https://code.visualstudio.com/docs/?dv=linux64_deb) for VSCode, then by the editor's extesion marketplace you have to install the language support extension for C/C++ and the C++ Intellisense extension (by [austin](https://github.com/austin-----/code-gnu-global)). I also recommend disabling Telemetry options in VSCode preferences, to avoid sending data to Microsoft ( thanks for the software but still i would prefer not to ). 

# of_code.sh installation
(will ask for sudo password)
```console
    git clone https://github.com/npisanti/of_vscode.git
    cd of_vscode
    sh install.sh
```

# configuration (needed)
You have to edit the `of_vscode/of_vscode.sh` file and set some absolute paths:
```sh
# put the absolute path of the script here
scriptpath="/home/$USER/apps/of_vscode"

# put the absolute path of openFrameworks here
rootpath="/home/$USER/oF"
```

you can also choose your compiler, for example I use `clang`
```sh
#choose your compiler
#compiler="gcc-x64"
compiler="clang-x64"
```

# usage
```console
   of_vscode.sh ~/path/to/your/app
```
or
```console
   cd ~/path/to/your/app
   of_vscode.sh
```

# custom addon include paths
The script will try to automatically adds all the paths in the `src` and `libs` folders of the addon, if present.
If an addon include headers outside its folder probably is a better idea to write a `.paths` file with a list of paths to include for that specific addon. The included `.paths` files will give you some clear examples on how to do it.

# credits 
This project was ispired by [Roberto Fazio VS Code / oF example](https://github.com/robertofazio/openFrameworks_VisualStudioCode_Example), that motivated me to try to switch from Geany to VS Code.