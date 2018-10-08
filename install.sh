
#!/bin/bash
scriptpath=$(pwd)
scriptfile=$(pwd)/of_vscode.sh

echo "installing of_vscode.sh"

cp of_vscode.sh toedit.sh 
sed -i -e "s|CONFIGSCRIPTPATH|$scriptpath|g" toedit.sh

ofpath=${1%/}
if [ -z "$ofpath" ]; then 
        echo "no oF directory given, defaulting to ~/openFrameworks for master release"
        ofpath="/home/$USER/openFrameworks"
else
    echo "oF directory set to $ofpath"
fi 

sed -i -e "s|CONFIGOFDIRECTORY|$ofpath|g" toedit.sh

compiler=$2
if [ -z "$compiler" ]; then 
    echo "compiler defaults to gcc-x64"
    sed -i -e "s|CONFIGCOMPILER|gcc-x64|g" toedit.sh
else
    echo "compiler set to $compiler"
    sed -i -e "s|CONFIGCOMPILER|$compiler|g" toedit.sh
fi

chmod +x toedit.sh

echo "sudo password required for moving generated script to /usr/local/bin"
sudo mv toedit.sh /usr/local/bin/of_vscode.sh


exit