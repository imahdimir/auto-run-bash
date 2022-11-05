#! /bin/bash

# updates(clone) the code for removing empty Todoist sections in the daily
#   routine project then exexutes it.
pyenv virtualenv auto

pyenv activate auto

tar_url=$(curl \
  -H "Accept: application/vnd.github+json" \
  https://api.github.com/repos/imahdimir/auto-run/releases/latest | python -c 'import  json,sys;result=json.load(sys.stdin); print(result["tarball_url"])';)


