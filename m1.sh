#! /bin/bash

## """ Reads the conf.json file then download latest version of the 
##       target repo and executes it. """.

## requirements: 
##   1. pyenv
##   2. pyenv-update
##   3. pyenv-virtualenv

# arguements:
#   1. conf.json path

export pyv=3.11.4
export av=autorunpy


export PYENV_VIRTUALENV_DISABLE_PROMPT=1
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# echo -e "$fst update pyenv\n"
# pyenv update

# echo -e "$fst Install Python Version: $pyv\n"
# pyenv install --skip-existing $pyv

# echo -e "$fst Create and activate $av venv\n"
# pyenv virtualenv $pyv $av
# pyenv activate $av

# echo -e "$fst Upgrade pip, autorunpy pkgs in the $av venv\n"
# pyenv exec pip install --upgrade pip
# pyenv exec pip install --upgrade autorunpy

# export cpd=$(dirname $1)
# echo -e "$fst cd to conf parent dir: $cpd"
# cd $cpd
# echo -e "$fst PWD is now: $PWD"

# echo -e "$fst Update all autorun configs\n"
# git fetch --all
# git reset --hard origin/main

# echo -e "$fst Make a new venv and return its name\n"
# venv=$(pyenv exec python -m autorunpy.make_venv $1)
# echo -e "$fst venv name: $venv\n"

# echo -e "$fst Download latset release of the conf target GitHub repo and ret its local dirpath\n"
# dirp=$(pyenv exec python -m autorunpy.dl_and_ret_dirpath $1)
# echo -e "The dirpath: $dirp"

# echo -e "$fst Return the module name to run from conf.json\n"
# m2r=$(pyenv exec python -m autorunpy.ret_module_2_run_name $1)
# echo -e "$fst Python module to running: $m2r\n"

# echo -e "$fst Deactivate $av venv\n"
# pyenv deactivate $av

# echo -e "$fst Activating the new venv: $venv\n"
# pyenv activate $venv

# echo -e "$fst cd to $dirp \n"
# cd $dirp

# echo -e "$fst Install reqs from requirements.txt in the new venv: $venv \n"
# pyenv exec pip install --upgrade pip
# pyenv exec pip install -r requirements.txt

# echo -e "$fst Execute the target module $m2r using the $venv venv\n"
# pyenv exec python3 $m2r

# echo -e "$fst Deactivate the new venv: $venv\n"
# pyenv deactivate $venv

# echo -e "$fst cd back to conf dir: $cpd\n"
# cd $cpd
# echo -e "$fst PWD is now: $PWD"

# echo -e "$fst Re-activate $av venv\n"
# pyenv activate $av

# echo -e "$fst Delete [If said so in conf] new created venv : $venv\n"
# pyenv exec python -m autorunpy.rm_venv $1

# echo -e "$fst rm the dir which contains the code: $dirp\n"
# rm -r $dirp
