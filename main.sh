#! /bin/bash

# """ Updates itself (especially the next bash script) 
#       then passes entered arguments to the next bash script """.
# 
# requirements: 
#   1. git

export fst="\n  LOG:"

echo -e "$fst Self Update\n"
git pull

bash m1.sh $@