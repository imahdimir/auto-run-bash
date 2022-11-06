#! /bin/bash

# updates(clone) the code for removing empty Todoist sections in the daily
#   routine project then exexutes it.
# 
# requirements: 
#   1. pyenv
#   2. pyenv-virtualenv


export pyv=3.6:latset

export PYENV_VIRTUALENV_DISABLE_PROMPT=1
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

echo "Install Python $pyv"
pyenv install --skip-existing $pyv

echo "createing and activating auto-run venv"
pyenv virtualenv $pyv auto-run
pyenv activate auto-run


echo "Installing last version of mirutil"
pip install --upgrade pip
pip install --upgrade mirutil

echo "Make the new venv and ret its name"
venv=$(python -c 'from mirutil.auto_run import make_venv; make_venv();')
echo "venv: $venv"

echo "Download latset release of the target GitHub repo and ret its local dirpath"
dirn=$(python -c 'from mirutil.auto_run import ret_dirn; ret_dirn();')
echo "dirname: $dirn"

echo "return the module name to run from conf.json"
m2r=$(python -c 'from mirutil.auto_run import ret_module_2_run_name; ret_module_2_run_name();')
echo "module 2 run: $m2r"

echo "Deactivate and delete auto-run venv"
pyenv deactivate auto
pyenv virtualenv-delete -f auto

echo "Changing dir to $dirn"
cd $dirn

echo "Activating the new venv: $venv"
pyenv activate $venv

echo "Installing dependencies from requirements.txt"
pyenv exec pip install --upgrade pip
pyenv exec pip install -r requirements.txt

echo "Executing the target module $m2r"
pyenv exec python3 $m2r

echo "cd back to the parent dir"
cd ..

echo "Deactivating and removing the new venv: $venv"
pyenv deactivate $venv
pyenv virtualenv-delete -f $venv

echo "rm the new dir which contains the code"
rm -r $dirn











