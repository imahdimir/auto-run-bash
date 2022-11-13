#!/bin/bash

# """ Updates itself (especially the next bash script) 
#       then passes entered arguments to the next bash script """.
# 
# requirements: 
#   1. git

export fst="\n  LOG:"

echo -e "$fst cd to self dir: $0\n"
cd $(dirname $0)

echo -e "$fst Self Update (runner bash script)\n"
git fetch --all
git reset --hard origin/main

bash m1.sh $@

cfn=$(echo "$1" | sed -E "s/.+\/([^\/]+)$/\1/")

if [ $? -eq 0 ]; then
   echo OK
   echo " " | mail -s "OK - $hostname - $cfn" $MAILTO
else
   echo FAIL
   echo " " | mail -s "FAIL - $hostname - $cfn" $MAILTO
fi

echo -e "\n\n\t\t\t***   FINISHED   ***\n\n"