#!/bin/bash

# ---------------- SETTINGS ------------------------------------

# put the absolute path of the script here
scriptpath="/home/$USER/apps/of_vscode"

# put the absolute path of openFrameworks here
rootpath="/home/$USER/oF"

# choose the name of your distro includes for oF
distrofile="of_debian.paths"

#choose your compiler
#compiler="gcc-x64"
compiler="clang-x64"


# ---------------- SCRIPT -------------------------------------

destpath=${1%/}

if [ -z "$destpath" ]; then 
        echo "creating project in current path"
        destpath=$(pwd)
fi

appname=$(basename $destpath)
echo "generating visual studio oF project named $appname for path $destpath"

echo "generating .vscode/c_cpp_properties.json"


rm -rf $destpath/.vscode
mkdir $destpath/.vscode
rm -rf $destpath/*.code-workspace

cat $scriptpath/base/c_cpp_properties_pt1.json >> $destpath/.vscode/c_cpp_properties.json

echo "---adding oF includes"
while read -r path
do 
        echo "\t\t\t\t\"$path\"," >> $destpath/.vscode/c_cpp_properties.json
done < $scriptpath/paths/$distrofile

inputlist="$destpath/addons.make"
if [ -f $inputlist ]; then
        while read -r addon
        do
                filename=$scriptpath/paths/$addon.paths
                if [ -f $filename ]; then
                        echo "---adding includes for $addon"
                        while read -r path 
                        do

                                echo "\t\t\t\t\"$path\"," >> $destpath/.vscode/c_cpp_properties.json

                        done < $filename
                else
                        echo "file $addon.paths not present, it's time to write it"
                fi
        done < $inputlist
fi

cat $scriptpath/base/c_cpp_properties_pt2.json >> $destpath/.vscode/c_cpp_properties.json

sed -i -e "s|OFDIRECTORY|$rootpath|g" $destpath/.vscode/c_cpp_properties.json
sed -i -e "s|COMPILERMODE|$compiler|g" $destpath/.vscode/c_cpp_properties.json

echo "editing other json files"

cp  $scriptpath/base/launch.json $destpath/.vscode/launch.json
sed -i -e "s|APPNAME|$appname|g" $destpath/.vscode/launch.json

cp  $scriptpath/base/settings.json $destpath/.vscode/settings.json
sed -i -e "s|COMPILERMODE|$compiler|g" $destpath/.vscode/settings.json

cp  $scriptpath/base/tasks.json $destpath/.vscode/tasks.json

echo "copying other files"
cp $scriptpath/base/appname.code-workspace $destpath/$appname.code-workspace
cp $scriptpath/base/Makefile $destpath/Makefile


exit
