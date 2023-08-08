#! /bin/bash

## Reads the conf.json file then download latest version of the 
##  target repo and executes it.

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
pyenv update &> /dev/null

## install the python version for the autorunpy venv if not installed
pyenv install --skip-existing $pyv &>n.out

## create the autorunpy venv if not created and activate it
pyenv virtualenv $pyv $av &>n.out
pyenv activate $av &>n.out

## upgrade pip and autorunpy package
pyenv exec pip install --upgrade pip autorunpy -q

## change dir to the auto-run-configs repo dir, assumed in the parent(GitHub dir)
cd ../auto-run-configs/

## update run configs
git fetch --all -q
git reset --hard origin/main -q

## cd to the GitHub dir
cd ..

## make a new environment and return its name
venv=$(pyenv exec python -m autorunpy.make_venv $1)

## remove n.out file it was used to suppress the output and not needed anymore
rm n.out

## return pip package name from conf.json
pkg=$(pyenv exec python -m autorunpy.ret_pkg_name $1)

## return the targeted module name to run in the targe repo
m2r=$(pyenv exec python -m autorunpy.ret_module_2_run $1)

## deactivate the autorunpy venv
pyenv deactivate $av

## Activate the new created venv
pyenv activate $venv

## Install the package from pip in the new venv and its dependencies
pyenv exec pip install --upgrade pip -q
pyenv exec pip install $pkg -q

## Execute the target module
pyenv exec python3 -m $m2r

## Deactivate the new venv
pyenv deactivate $venv

## activate the autorunpy venv
pyenv activate $av

## remove the new venv (if specified in the conf.json)
pyenv exec python3 -m autorunpy.rm_venv $1
