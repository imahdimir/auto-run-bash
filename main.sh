#!/bin/bash

# Reads conf.json in PWD, gets the latest release of the target GitHub repo then
#   executes the target python script.

export PYENV_VIRTUALENV_DISABLE_PROMPT=1
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

echo -e "$fst Make a new venv and return its name\n"
venv=$(python -c 'from autorunpy import auto; auto.make_venv();')
echo -e "$fst The new venv name: $venv\n"

echo -e "$fst Download latset release of the conf target GitHub repo and ret its local dirpath\n"
dirp=$(python -c 'from autorunpy import auto; auto.ret_dirp();')
echo -e "The dirpath: $dirp"

echo -e "$fst Return the module name to run from conf.json\n"
m2r=$(python -c 'from autorunpy import auto; auto.ret_module_2_run_name();')
echo -e "$fst Python module to running: $m2r\n"

echo -e "$fst Deactivate $av venv\n"
pyenv deactivate $av

echo -e "$fst Activating the new venv: $venv\n"
pyenv activate $venv

echo -e "$fst cd to $dirp\n"
cd $dirp

echo -e "$fst Install reqs from requirements.txt in the new $venv venv\n"
pyenv exec pip install --upgrade pip
pyenv exec pip install -r requirements.txt

echo -e "$fst Execute the target module $m2r using the $venv venv\n"
pyenv exec python3 $m2r

echo -e "$fst Deactivate the new venv: $venv\n"
pyenv deactivate $venv

echo -e "$fst Re-activate $av venv\n"
pyenv activate $av

echo -e "$fst Delete [If said so in conf] new created venv : $venv\n"
pyenv exec python3 -c 'from autorunpy import auto; auto.rm_venv();'



