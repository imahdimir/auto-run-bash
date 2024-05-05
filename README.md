How to Setup a New Server:

# Install git
```
sudo apt-get install git-all
```

# Install pip3
```
apt install python3-pip
```

# Install pyenv
- Use Its installation guide on GitHub

- don't forget pyenv reqs

- Install pyenv virtualenv it is now included in pyenv installation, make sure it is installed

- Add pyenv root to PATH and eval it on basrch, read the guide

# Restart Shell
```
exec $SHELL
```

# Clone Auto Run Tool and Run Configs
```
git clone https://github.com/imahdimir/auto_run_bash
git clone https://github.com/imahdimir/auto_run_configs
```

# Set tz
```
timedatectl set-timezone America/Los_Angeles
```

# copy .gt.json to $HOME
# config cron