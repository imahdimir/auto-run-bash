#!/bin/bash

<< doc
Reads the conf.json file then downloads latest version of the target repo and executes it.

Reqs: 
    - pyenv
    - pyenv-virtualenv

arguements:
    - conf.json stem
doc

# + pyenv to PATH (crontab doesn't have it)
export PATH="$(pyenv root)/bin:$PATH"

# Consts
pyv=3.12.3
av=autorunpy

# following lines are needed for pyenv to work properly
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# install the python version for the autorunpy venv if not installed
pyenv install --skip-existing $pyv &> /dev/null

echo "Create the autorunpy venv if not created yet"
pyenv virtualenv $pyv $av &> /dev/null

echo "Activating $av"
pyenv activate $av &> /dev/null

echo "Upgrade pip and autorunpy Pkg"
pyenv exec pip install --upgrade pip autorunpy -q

echo "Make a new venv and ret its name"
venv=$(pyenv exec python -m autorunpy.make_venv $1)
echo "venv: $venv"

# return pip package name from conf.json
pkg=$(pyenv exec python -m autorunpy.ret_pkg_name $1)
echo "pkg: $pkg"

# return target module name to run in the targe repo
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
echo "module to run: $m2r"
pyenv exec python3 -m $m2r

# Deactivate the new venv
pyenv deactivate $venv

# activate the autorunpy venv
pyenv activate $av

# remove the new venv (if specified in the conf.json)
pyenv exec python3 -m autorunpy.rm_venv $1