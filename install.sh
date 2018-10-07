
#!/bin/bash
scriptpath=$(pwd)/of_vscode.sh
chmod +x $scriptpath
if [ -f /usr/local/bin/of_vscode.sh ]; then
    sudo rm /usr/local/bin/of_vscode.sh
fi
sudo ln -s $scriptpath /usr/local/bin/of_vscode.sh
exit