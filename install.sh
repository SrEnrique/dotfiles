#!/usr/bin/env bash

if ! command -v ruby &> /dev/null
then
    echo "ruby could not be found"
    echo "Install rbevn ruby -v 2.7.2 "
    sudo apt install curl
    curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

    sudo apt-get update -y
    sudo apt-get install git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev nodejs yarn -y



    cd

    DIR="~/.rbenv"
    if ! [ -d "$DIR" ]; then
       # Take action if $DIR exists. #
       echo "Installing config files in ${DIR}..."
       git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    fi

    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc
    #exec $SHELL
    source ~/.bashrc
    DIR="~/.rbenv/plugins/ruby-build"
    if ! [ -d "$DIR" ]; then
       # Take action if $DIR exists. #
       echo "Installing config files in ${DIR}..."
       git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
    fi

    echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
    #exec $SHELL

    source ~/.bashrc
    rbenv install 2.7.2 --verbose
    rbenv global 2.7.2
fi

if ! command -v vim &> /dev/null
then
    echo "vim could not be found"
    sudo apt install vim -y
fi

if ! command -v tmux &> /dev/null
then
    echo "tmux could not be found"
    sudo apt install tmux -y
fi

if ! command -v htop &> /dev/null
then
    echo "htop could not be found"
    sudo apt install htop -y
fi

if ! command -v zsh &> /dev/null
then
    echo "zsh could not be found"
    sudo apt install zsh -y
fi



if [ ! -d "$HOME/.yadr" ]; then
    echo "Installing YADR for the first time"
    git clone --depth=1 https://github.com/SrEnrique/dotfiles.git "$HOME/.yadr"
    cd "$HOME/.yadr"
    [ "$1" = "ask" ] && export ASK="true"
    rake install
else
    cd ~/.yadr
    echo "YADR is already installed"
    echo "Always be sure to run  rake install  after pulling to ensure plugins are updated"
fi
