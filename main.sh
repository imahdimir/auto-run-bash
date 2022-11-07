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

export PYENV_VIRTUALENV_DISABLE_PROMPT=1
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

ipwd=$PWD

echo -e "$fst changing dir to the parent dir\n"
cd ..
echo -e "$fst PWD is now $PWD"

echo -e "$fst Make the new venv and return its name\n"
venv=$(python -c 'from autorunpy import auto; auto.make_venv();')
echo -e "$fst venv: $venv"

echo -e "$fst Download latset release of the conf target GitHub repo and ret its local dirpath\n"
dirn=$(python -c 'from autorunpy import auto; auto.ret_dirn();')
echo -e "The dirpath: $dirn"

echo -e "$fst Return the module name to run from conf.json\n"
m2r=$(python -c 'from autorunpy import auto; auto.ret_module_2_run_name();')
echo -e "$fst Python module to running: $m2r"

echo -e "$fst Deactivate $av venv\n"
pyenv deactivate $av

echo -e "$fst cd to $dirn\n"
cd $dirn
echo -e "$fst PWD is now $PWD"

echo -e "$fst Activating the new venv: $venv\n"
pyenv activate $venv

echo -e "$fst Installing dependencies from requirements.txt\n"
pyenv exec pip install --upgrade pip
pyenv exec pip install -r requirements.txt

echo -e "$fst Execute the target module $m2r using the $venv venv\n "
pyenv exec python3 $m2r

echo -e "$fst cd back to the parent dir\n"
cd ..
echo -e "$fst PWD is now $PWD"

echo -e "$fst Deactivate the new venv: $venv\n"
pyenv deactivate $venv

echo -e "$fst Re-activate $av venv"
pyenv activate $av

python -c 'from autorunpy import auto; auto.rm_venv();'

echo -e "$fst rm the new dir which contains the code: $dirn\n"
rm -r $dirn

echo -e "$fst cd to initial dir $ipwd"
cd $ipwd










