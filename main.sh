#!/bin/bash

"""
Updates itself (especially the next bash script),
then passes entered arguments to the next bash script.

requirements: 
    - git
"""

# cd to current dir 
cd $(dirname $0)
# echo -e "PWD : $PWD"

# self update
git fetch --all -q
git reset --hard origin/main -q

# get the config file name from the second argument
cfn=$(echo "$1" | sed -E "s/.+\/([^\/]+)$/\1/")
# echo $cfn

# run the next bash script with the same arguments (all arguments @)
bash m1.sh $@

# evaluate the exit code of the previous command to see if it's successful or not
if [ $? -eq 0 ]; then
    echo "DONE"
    # echo "DONE." | mail -s "Done | $hostname | $cfn" $MAILTO

else
    echo "FAILED"
    echo $?
    # echo "FAILED." | mail -s "FAILED | $hostname | $cfn" $MAILTO
fi

