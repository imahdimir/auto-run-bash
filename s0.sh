#!/bin/bash

<< doc
reqs: 
    - git
doc

echo Update Configs
cd "$HOME/auto_run_configs/"
git fetch --all -q
git reset --hard origin/main -q

echo Self Update
cd "$HOME/auto_run_bash"
git fetch --all -q
git reset --hard origin/main -q

echo Running s1.sh, passing all Args "(@)"
echo Conf Name: $@
bash s1.sh $@

if [ $? -eq 0 ]; then
    echo "DONE"
else
    echo $?
fi