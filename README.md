## of_vscode.sh

bash script for generating VSCode openFrameworks project with enabled intellisense, tested on:
- Debian 9
- openFrameworks 0.10.0 gcc6
- Microsoft Visual Studio Code IDE 1.27.2

additional requirements are GNU Global and clang, the first for generating the tags, and the second for some static analysis on debugging:
```
    sudo apt-get install global clang
```

# install visual studio code
For working with oF and VSCode:
- you have to install the [.deb package](https://code.visualstudio.com/docs/?dv=linux64_deb) for VSCode, download it and then run `sudo dpkg -i code_*`.
- in the editor you have to install some extensions. You can do it in the extension section of the sidebar, press `Ctrl+Shift+X` to open it, then search `C/C++` by Microsoft and `C++ Intellisense` by [austin](https://github.com/austin-----/code-gnu-global), and install them.

In the preference I recommend enabling `Files: Insert Final Newline' (as all the text/code files in linux should be terminated by a newline) and disabling Telemetry options to avoid sending data to Microsoft ( thanks for the software but still i would prefer not to ).

You can use VSCode with the `code` command. For correctly opening an oF project you have to open the workspace file, so you can do
```console
   code ~/path/to/your/app.code-workspace
```
to compile and run a project from VSCode, press `Ctrl+Shift+B`.

# of_code.sh installation
(will ask for sudo password)
```console
    git clone https://github.com/npisanti/of_vscode.git
    cd of_vscode
    sh install.sh
```
If you move the folder of `of_vscode.sh` after installing it you have to run the installation again.

# usage
```console
   of_vscode.sh ~/path/to/your/app
```
or
```console
   cd ~/path/to/your/app
   of_vscode.sh
```
will generate a project for your app.

# custom addon include paths
The script will try to automatically adds all the paths in the `src` and `libs` folders of the addon, if present.
If an addon include headers outside its folder probably is a better idea to write a `.paths` file with a list of paths to include for that specific addon. This file has to be put in the `paths` folder in the repostitory. The included `.paths` files will give you some clear examples on how to do it. Also pull request for `.paths` files are really appreciated!

# custom install
Optionally you can install it with:
```
sh install.sh /absolute/path/to/oF/directory
```
If you don't give the absolute path to your oF directory, it defaults to a relative path three folder above the app folder.

# credits
This project was ispired by [Roberto Fazio VS Code / oF example](https://github.com/robertofazio/openFrameworks_VisualStudioCode_Example), that motivated me to try to switch from Geany to VS Code.
