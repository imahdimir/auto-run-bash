#!/bin/bash

<< doc
Reads the conf.json file then downloads latest version of the target repo and executes it.

Reqs: 
    - pyenv
    - pyenv-virtualenv

args:
    - conf.json stem
doc

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Consts
pyv=3.12.3
av=autorunpy

# echo Install the python version for the autorunpy venv if not installed
pyenv install --skip-existing $pyv &> /dev/null

# echo Creating the autorunpy venv if not created yet
pyenv virtualenv $pyv $av > /dev/null

# echo Activating $av
pyenv activate $av > /dev/null

# echo Upgrade pip and autorunpy Pkg
pyenv exec pip install --upgrade pip autorunpy -q

if [ $# -eq 0 ]; then
    >&2 echo No Arg Provided, Just Doing Updates
    exit 0
fi

# echo Make a new venv and ret its name
venv=$(pyenv exec python -m autorunpy.make_venv $1)
# echo venv: $venv

# echo return pip package name from conf.json
pkg=$(pyenv exec python -m autorunpy.ret_pkg_name $1)
# echo pkg: $pkg

# echo return target module name to run in the targe repo
m2r=$(pyenv exec python -m autorunpy.ret_module_2_run $1)
# echo module to run: $m2r

# echo Deactivating $av venv
pyenv deactivate $av

# echo Activating new venv
pyenv activate $venv

# echo Install target package from pip in the new venv and its reqs
pyenv exec pip install --upgrade pip -q
pyenv exec pip install $pkg -q

# echo Execute the target module $m2r
pyenv exec python -m $m2r

# echo Deactivating new venv: $venv
pyenv deactivate $venv

# echo Re-activate $av venv
pyenv activate $av

# echo Removing new venv if specified in the config
pyenv exec python3 -m autorunpy.rm_venv $1