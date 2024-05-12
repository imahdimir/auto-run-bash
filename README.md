How to Setup a New Server:

# Install git
```
sudo apt-get install git-all
```

# Install pip3
```
apt install python3-pip
```

# Install pyenv Reqs
```
apt-get update
apt-get install make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
```

# Install pyenv
- Use Its installation guide on GitHub https://github.com/pyenv/pyenv-installer

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

# Copy .g.json to $HOME
# Config Cron
# alias a="bash ~/auto_run_bash/s0.sh
