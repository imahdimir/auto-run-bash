#! /bin/bash

<< doc
Reads the conf.json file then download latest version of the target repo and executes it.

Requirements: 
    - pyenv
    - pyenv-update plugin for pyenv
    - pyenv-virtualenv

arguements:
    - conf.json path
doc

# add pyenv to PATH (crontab doesn't have it)
export PATH="$HOME/.pyenv/bin:$PATH"
# echo $PATH

# keep some constants as variables
export pyv=3.12.0
export av=autorunpy

# following lines are needed for pyenv to work properly, for deactivate the venv properly
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# update pyenv by the pyenv-update plugin and suppress the output
pyenv update &> /dev/null

# install the python version for the autorunpy venv if not installed
pyenv install --skip-existing $pyv &> /dev/null

# create the autorunpy venv if not created and activate it
pyenv virtualenv $pyv $av &> /dev/null
pyenv activate $av &> /dev/null

# upgrade pip and autorunpy package
pyenv exec pip install --upgrade pip autorunpy -q

# change dir to the auto-run-configs repo dir, assumed in the parent(GitHub dir)
cd ../auto-run-configs/

# update run configs
git fetch --all -q
git reset --hard origin/main -q

# cd to the GitHub dir
cd ..

# make a new environment and return its name
venv=$(pyenv exec python -m autorunpy.make_venv $1)
echo "venv: $venv"

# return pip package name from conf.json
pkg=$(pyenv exec python -m autorunpy.ret_pkg_name $1)
# echo "pkg: $pkg"

# return the targeted module name to run in the targe repo
m2r=$(pyenv exec python -m autorunpy.ret_module_2_run $1)
echo "module to run: $m2r"

# deactivate the autorunpy venv
pyenv deactivate $av

# Activate the new created venv
pyenv activate $venv

# Install the package from pip in the new venv and its dependencies
pyenv exec pip install --upgrade pip -q
pyenv exec pip install $pkg -q

# Execute the target module
# echo "module to run: $m2r"
pyenv exec python3 -m $m2r

# Deactivate the new venv
pyenv deactivate $venv

# activate the autorunpy venv
pyenv activate $av

# remove the new venv (if specified in the conf.json)
pyenv exec python3 -m autorunpy.rm_venv $1
