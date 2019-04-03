#!/bin/bash

# ---------------- SETTINGS ------------------------------------

# put the absolute path of the script here
scriptpath="CONFIGSCRIPTPATH"

# put the absolute path of openFrameworks here
rootpath='CONFIGOFDIRECTORY'

# choose the name of your distro includes for oF
distrofile="of_debian.paths"

# must default to this for intellisense
compiler="clang-x64"


# ---------------- SCRIPT -------------------------------------

destpath=${1%/}

if [ -z "$destpath" ]; then
        echo "creating project in current path"
        destpath=$(pwd)
fi

appname=$(basename $destpath)
echo "generating visual studio oF project named $appname"

echo "generating .vscode/c_cpp_properties.json"


rm -rf $destpath/.vscode
mkdir $destpath/.vscode
rm -rf $destpath/*.code-workspace

cat $scriptpath/base/c_cpp_properties_pt1.json >> $destpath/.vscode/c_cpp_properties.json

echo -e "    adding oF includes"
while read -r path
do
        echo -e "\t\t\t\t\"$path\"," >> $destpath/.vscode/c_cpp_properties.json
done < $scriptpath/paths/$distrofile

inputlist="$destpath/addons.make"
wsroot='${workspaceRoot}/'

if [ -f $inputlist ]; then
        while read -r addon
        do
            if [ -n "$addon" ]; then
                filename=$scriptpath/paths/$addon.paths
                if [ -f $filename ]; then
                        echo -e "    adding includes for $addon"
                        while read -r path
                        do

                                echo -e "\t\t\t\t\"$path\"," >> $destpath/.vscode/c_cpp_properties.json

                        done < $filename
                else
                        echo -e "    file $addon.paths not present, starting automatic paths finding"
                        presumedpath="$rootpath/addons/$addon"
                        searchpath=${presumedpath#"$wsroot"}

                        prefix="$wsroot"
                        if [[ "$presumedpath" == "$searchpath" ]]; then
                            prefix=""
                        fi


                        echo -e "        presuming path $searchpath"
                        if [ -d $searchpath/src ]; then
                                echo -e "        adding all the paths in $searchpath/src"
                                for i in $(find $searchpath/src -type d); do
                                        echo -e "\t\t\t\t\"$prefix$i\"," >> $destpath/.vscode/c_cpp_properties.json
                                done
                        fi
                        if [ -d $searchpath/libs ]; then
                                echo -e "        adding all the paths in $searchpath/libs"
                                for i in $(find $searchpath/libs -type d); do
                                        echo -e "\t\t\t\t\"$prefix$i\"," >> $destpath/.vscode/c_cpp_properties.json
                                done
                        fi

                fi
            fi
        done < $inputlist
fi

cat $scriptpath/base/c_cpp_properties_pt2.json >> $destpath/.vscode/c_cpp_properties.json


echo "parsing workspace folders..."

cat $scriptpath/base/code-workspace.pt1 >> $destpath/$appname.code-workspace

if [ -f $inputlist ]; then
        while read -r addon
        do
            if [ -n "$addon" ]; then
                addonworkspace="$wsroot../../../../addons/$addon"

                echo -e "    adding $addon to workspace"

                echo -e "\t\t{" >> $destpath/$appname.code-workspace
                echo -e "\t\t\t\"path\" : \"$addonworkspace\"" >> $destpath/$appname.code-workspace
                echo -e "\t\t}," >> $destpath/$appname.code-workspace
            fi
        done < $inputlist
fi


cat $scriptpath/base/code-workspace.pt2 >> $destpath/$appname.code-workspace


sed -i -e "s|OFDIRECTORY|$rootpath|g" $destpath/.vscode/c_cpp_properties.json

echo "editing other json files"

cp  $scriptpath/base/launch.json $destpath/.vscode/launch.json
sed -i -e "s|APPNAME|$appname|g" $destpath/.vscode/launch.json

cp  $scriptpath/base/settings.json $destpath/.vscode/settings.json

cp  $scriptpath/base/tasks.json $destpath/.vscode/tasks.json

echo "copying oF makefile files"

if [ ! -f $destpath/Makefile ]; then
        cp $scriptpath/base/Makefile $destpath/Makefile
fi

echo "running gnu global to generate tags"
cd $destpath
gtags

exit
