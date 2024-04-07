#!/bin/bash

# Install git
sudo apt-get install git-all

git clone https://github.com/imahdimir/auto-run-bash
git clone https://github.com/imahdimir/auto-run-configs

# Install pip3
apt install python3-pip

# pyenv reqs
apt-get update
apt-get install make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

# Install pyenv
curl https://pyenv.run | bash

# Add pyenv to PATH
echo 'export PATH="$(pyenv root)/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init --path)"' >> ~/.bashrc

# Restart shell
exec $SHELL

# Install pyenv virtualenv plugin
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv

# add to .bashrc
echo "eval "$(pyenv init -)"" >> ~/.bashrc
echo "eval "$(pyenv virtualenv-init -)"" >> ~/.bashrc

exec $SHELL

# set tz
timedatectl set-timezone America/Los_Angeles

# touch .gt in $HOME
# config cron
