#!/bin/bash
current_dir=$(pwd)
projects=$(ls -1 $current_dir/projects)
for project in $projects
do
    if [ -f $current_dir/projects/$project/nginx.conf ]; then
    cp $current_dir/projects/$project/nginx.conf /etc/nginx/sites-enabled/$project.conf
    fi
done
