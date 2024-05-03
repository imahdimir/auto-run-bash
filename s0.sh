#!/bin/bash

<< doc
Updates itself (especially the next bash script),
then passes entered arguments to the next bash script.

requirements: 
    - git
doc

cd "$HOME/auto_run_bash"

# self update
git fetch --all -q
git reset --hard origin/main -q

return
# run the next bash script with the same arguments (all arguments @)
bash s1.sh $@

# evaluate the exit code of the previous command to see if it's successful or not
## get the config file name from the second argument
# cfn=$(echo "$1" | sed -E "s/.+\/([^\/]+)$/\1/")
if [ $? -eq 0 ]; then
    echo "DONE"
    # echo "DONE." | mail -s "Done | $hostname | $cfn" $MAILTO

else
    echo "FAILED"
    echo $?
    # echo "FAILED." | mail -s "FAILED | $hostname | $cfn" $MAILTO
fi