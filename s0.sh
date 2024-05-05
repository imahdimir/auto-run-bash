#!/bin/bash

<< doc
reqs: 
    - git
doc

# Update Configs
cd "$HOME/auto_run_configs/"
git fetch --all -q
git reset --hard origin/main -q

# Self Update
cd "$HOME/auto_run_bash"
git fetch --all -q
git reset --hard origin/main -q

if [ $# -eq 0 ]; then
    >&2 echo "No args provided, Just doing Self Update"
    exit 0
fi

# Run Next Script, Same Args (All Args @)
echo "Conf Name: $@"
bash s1.sh $@

if [ $? -eq 0 ]; then
    echo "DONE"
else
    echo $?
fi