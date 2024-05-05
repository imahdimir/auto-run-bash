#!/bin/bash

# Install git
sudo apt-get install git-all

# Install pip3
apt install python3-pip

# Install pyenv, use Its installation guide on GitHub
    # pyenv reqs
    # Install pyenv virtualenv it is now included in pyenv installation, make sure it is installed
    # Add pyenv root to PATH and eval it on basrch, read the guide

# Restart shell
exec $SHELL

# clone auto run tool and configs
git clone https://github.com/imahdimir/auto_run_bash
git clone https://github.com/imahdimir/auto_run_configs

# set tz
timedatectl set-timezone America/Los_Angeles

# copy .gt.json to $HOME
# config cron