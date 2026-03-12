#!/bin/sh

if [ $# -lt 2 ]; then
    exit 1 
fi

dir_path=~/.dotfiles/config/$1
module_path=$dir_path/$2
template=$3

if [ -d $dir_path ] && [ -e $module_path ]; then
    exit 1
fi

if [ -z $template ]; then
    template_dir=~/.dotfiles/config/templates
else
    template_dir=$3
fi
template_module=$template_dir/module.nix
template_default=$template_dir/default.nix

if [[ -e template_module ||  -e template_default ]]; then 
    exit 1
fi

if [ -d $dir_path ]; then
    cp $template_module $module_path 
else
    mkdir $dir_path/
    cp $template_default $dir_path/default.nix
    cp $template_module $module_path
fi
echo $dir_path
exit 0 
