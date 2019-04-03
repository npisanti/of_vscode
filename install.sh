
#!/bin/bash
scriptpath=$(pwd)
scriptfile=$(pwd)/of_vscode.sh

echo "installing of_vscode.sh"

cp of_vscode.sh toedit.sh
sed -i -e "s|CONFIGSCRIPTPATH|$scriptpath|g" toedit.sh

ofpath=${1%/}
if [ -z "$ofpath" ]; then
        echo "no oF directory given, defaulting to a path relative to the app folder"
        ofpath='${workspaceRoot}/../../..'
else
    echo "oF directory set to $ofpath"
fi

sed -i -e "s|CONFIGOFDIRECTORY|$ofpath|g" toedit.sh

chmod +x toedit.sh

echo "sudo password required for moving generated script to /usr/local/bin"
sudo mv toedit.sh /usr/local/bin/of_vscode.sh


exit
