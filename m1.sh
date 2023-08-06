#! /bin/bash

## """ Reads the conf.json file then download latest version of the 
##       target repo and executes it. """.

## requirements: 
##   1. pyenv
##   2. pyenv-update plugin for pyenv
##   3. pyenv-virtualenv

# arguements:
#   1. conf.json path


## keep some constants as variables
export pyv=3.11.4
export av=autorunpy


## following lines are needed for pyenv to work properly, for deactivate the venv properly
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"


## update pyenv by the pyenv-update plugin and suppress the output
# echo -e "$fst update pyenv\n"
pyenv update &>n.out


## install the python version for the autorunpy venv if not installed
# echo -e "$fst Install Python Version: $pyv\n"
pyenv install --skip-existing $pyv &>n.out


## create the autorunpy venv if not created and activate it
# echo -e "$fst Create and activate $av venv\n"
pyenv virtualenv $pyv $av &>n.out
pyenv activate $av &>n.out


## upgrade pip and autorunpy package
# echo -e "$fst Upgrade pip, autorunpy pkgs in the $av venv\n"
pyenv exec pip install --upgrade pip autorunpy -q


## change dir to the auto-run-configs repo dir, assumed in the parent(GitHub dir)
# echo -e "cd to GitHub dir (=parent dir)"
cd ../auto-run-configs
# echo -e "$fst PWD is now: $PWD"

## update run configs
# echo -e "$fst Update all autorun configs\n"
git fetch --all -q
git reset --hard origin/main -q


## cd to the GitHub dir
cd ..


## make a new environment and return its name

# echo -e "$fst Make a new venv and return its name\n"
venv=$(pyenv exec python -m autorunpy.make_venv $1)
# echo -e "$fst venv name: $venv\n"


## Download latest release of the target repo

# echo -e "$fst Download latset release of the conf target GitHub repo and ret its local dirpath\n"
dirp=$(pyenv exec python -m autorunpy.dl_and_ret_dirpath $1)
# echo -e "The dirpath: $dirp"


## return the targeted module name to run in the targe repo

# echo -e "$fst Return the module name to run from conf.json\n"
m2r=$(pyenv exec python -m autorunpy.ret_module_2_run_name $1)
# echo -e "$fst Python module to run: $m2r\n"


## deactivate the autorunpy venv

# echo -e "$fst Deactivate $av venv\n"
pyenv deactivate $av


## Activate the new created venv

# echo -e "$fst Activating the new venv: $venv\n"
pyenv activate $venv


## cd to the new folder containing latest version of the target repo 

# echo -e "$fst cd to $dirp \n"
cd $dirp


## Install requirements

# echo -e "$fst Install reqs from requirements.txt in the new venv: $venv \n"
pyenv exec pip install --upgrade pip -q
pyenv exec pip install -r requirements.txt -q


## Execute the target module

# echo -e "$fst Execute the target module $m2r using the $venv venv\n"
pyenv exec python3 $m2r


## Remove the new venv
pyenv virtualenv-delete -f $venv


## remove the folder of latest release
# echo -e "$fst rm the dir which contains the code: $dirp\n"
rm -r $dirp
