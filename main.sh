#! /bin/bash

# updates(clone) the code for removing empty Todoist sections in the daily
#   routine project then exexutes it.
# 
# requirements: 
#   1. pyenv
#   2. pyenv-virtualenv
#
# Assumptions:
#   1. main.sh would be downloaded in a dir by the dlmain.sh


echo "$frst changing dir to the parent dir\n"
cd ..

echo "$frst Make the new venv and ret its name\n"
venv=$(python -c 'from mirutil.auto_run import make_venv; make_venv();')
echo "venv: $venv"

echo "$frst Download latset release of the target GitHub repo and ret its local dirpath\n"
dirn=$(python -c 'from mirutil.auto_run import ret_dirn; ret_dirn();')
echo "dirname: $dirn"

echo "$frst return the module name to run from conf.json\n"
m2r=$(python -c 'from mirutil.auto_run import ret_module_2_run_name; ret_module_2_run_name();')
echo "module 2 run: $m2r"

echo "$frst Deactivate auto-run venv\n"
pyenv deactivate $autovenv

echo "$frst Changing dir to $dirn\n"
cd $dirn

echo "$frst Activating the new venv: $venv\n"
pyenv activate $venv

echo "$frst Installing dependencies from requirements.txt\n"
pyenv exec pip install --upgrade pip
pyenv exec pip install -r requirements.txt

echo "$frst Executing the target module $m2r\n"
pyenv exec python3 $m2r

echo "$frst cd back to the parent dir\n"
cd ..

echo "$frst Deactivating and removing the new venv: $venv\n"
pyenv deactivate $venv
pyenv virtualenv-delete -f $venv

echo "$frst rm the new dir which contains the code\n"
rm -r $dirn

echo "$frst cd to main.sh dir"
cd $mdir










