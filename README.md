## of_vscode.sh

bash script for generating VSCode openFrameworks project with enabled intellisense, tested on:
- Debian 9
- openFrameworks 0.10.0 gcc6
- Microsoft Visual Studio Code IDE 1.27.2

# installation
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

you can also choose your compiler, for examle i use `clang`
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

# addons paths
To add the necessary includes to the project settings the script parses some `.paths` files that you can find in the `paths` directory. If there is no `.paths` file it will try to add all the paths in the `src` and `libs` folders of the addon, if present. If an addon include headers outside its folder probably is a better idea to write a `.paths` file with a list of paths to include for that specific addon. You can use the OFDIRECTORY word as a wildcard for the main oF path, see the included `.paths` for examples.

# credits 
This project was ispired by [Roberto Fazio VSCode/oF example](https://github.com/robertofazio/openFrameworks_VisualStudioCode_Example), that motivated me to try to switch from Geany to VSCode.