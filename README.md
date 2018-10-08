## of_vscode.sh

bash script for generating VSCode openFrameworks project with enabled intellisense, tested on:
- Debian 9
- openFrameworks 0.10.0 gcc6
- Microsoft Visual Studio Code IDE 1.27.2

# install visual studio code
You have to install the [.deb package](https://code.visualstudio.com/docs/?dv=linux64_deb) for VSCode, then by the editor's extesion marketplace you have to install the language support extension for C/C++ and the C++ Intellisense extension (by [austin](https://github.com/austin-----/code-gnu-global)). I also recommend disabling Telemetry options in VSCode preferences, to avoid sending data to Microsoft ( thanks for the software but still i would prefer not to ). 

You can use VSCode with the `code` command.

# of_code.sh installation
(will ask for sudo password)
```console
    git clone https://github.com/npisanti/of_vscode.git
    cd of_vscode
    sh install.sh /absolute/path/to/oF/directory compilername
```
If you don't give the absolute path to your oF directory, it defaults to `/home/$USER/openFrameworks`. You cannot specify `compilername` without giving the oF path first, if you don't give anything it default to `gcc-x64`. Another choice could be `clang-x64` if you use it. If you move the folder of of_vscode.sh after installing it you have to run the installation again.


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
If an addon include headers outside its folder probably is a better idea to write a `.paths` file with a list of paths to include for that specific addon. This file has to be put in the `paths` folder in the repostitory. The included `.paths` files will give you some clear examples on how to do it. Also pull request for `.paths` files are really appreciated! 

# credits 
This project was ispired by [Roberto Fazio VS Code / oF example](https://github.com/robertofazio/openFrameworks_VisualStudioCode_Example), that motivated me to try to switch from Geany to VS Code.