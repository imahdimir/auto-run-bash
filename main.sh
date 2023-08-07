#!/bin/bash

## """ Updates itself (especially the next bash script) 
##       then passes entered arguments to the next bash script """.

## requirements: 
##   1. git


## keep log as a variable
fst="log : "


## cd to current dir 

# echo -e "$fst cd to self dir: $0\n"
cd $(dirname $0)
# echo -e "$fst PWD : $PWD"


## update current dir from GitHub

# echo -e "$fst Self update (runner bash script)\n"

# git fetch --all -q
# git reset --hard origin/main -q


## get the config file name from the second argument
cfn=$(echo "$1" | sed -E "s/.+\/([^\/]+)$/\1/")
# echo $cfn


## run the next bash script with the same arguments (all arguments @)
bash m1.sh $@


if [ $? -eq 0 ]; then

    echo "DONE."
    # echo "DONE." | mail -s "Done | $hostname | $cfn" $MAILTO

else
    echo "FAILED."
    echo $?
    echo "FAILED." | mail -s "FAILED | $hostname | $cfn" $MAILTO

fi

