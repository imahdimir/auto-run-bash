#!/bin/bash

# install git
sudo apt-get install git-all

git clone https://github.com/imahdimir/auto-run-bash
git clone https://github.com/imahdimir/auto-run-configs

## install pip3
apt install python3-pip

## requirements for pyenv
apt-get update
apt-get install make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

## install pyenv
curl https://pyenv.run | bash

## add pyenv to PATH, add to ~/.bashrc
echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init --path)"' >> ~/.bashrc

## restart shell
exec $SHELL

## install virtualenv plugin for pyenv
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv

echo "eval "$(pyenv init -)"" >> ~/.bashrc
echo "eval "$(pyenv virtualenv-init -)"" >> ~/.bashrc

## restart shell
exec $SHELL

## install the crontab by crontab -e command for now manually and the github token file.json

# echo "eval "$(export auto="$SHELL $HOME/auto-run-bash/main.sh")"" >> ~/.bashrc
