#!/usr/bin/env zsh

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install git
#brew install git

# Clone this repository
#git clone --depth 1 git@github.com:m3m0r7/dotfiles.git $HOME/dotfiles

# Move to current directory
#cd $HOME/dotfiles

# Create symbolic links
ln -nsf $HOME/dotfiles/.procs.toml $HOME/.procs.toml
ln -nsf $HOME/dotfiles/.zshrc $HOME/.zshrc
ln -nsf $HOME/dotfiles/.vimrc $HOME/.config/nvim/init.vim
ln -nsf $HOME/dotfiles/.gitignore_global $HOME/.gitignore_global
ln -nsf $HOME/dotfiles/.fdignore $HOME/.fdignore
ln -nsf $HOME/dotfiles/webpack.config.js $HOME/webpack.config.js
ln -nsf $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf
ln -nsf $HOME/dotfiles/scripts $HOME/scripts
ln -nsf $HOME/dotfiles/original-scripts $HOME/original-scripts

# Copy SSH config
mkdir $HOME/.ssh && \
  ln -nsf $HOME/dotfiles/ssh-config/ssh-config $HOME/.ssh/config

git clone https://github.com/wfxr/forgit.git $HOME/.oh-my-zsh/plugins/forgit

git clone https://github.com/seebi/dircolors-solarized.git $HOME/.oh-my-zsh/plugins/dircolors-solarized
$(brew --prefix)/opt/fzf/install

git clone https://github.com/chitoku-k/fzf-zsh-completions $HOME/.oh-my-zsh/plugins/fzf-zsh-completions
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

git clone git@github.com:b4b4r07/enhancd.git $HOME/.oh-my-zsh/plugins/enhancd
git clone git@github.com:chitoku-k/fzf-zsh-completions.git $HOME/.oh-my-zsh/plugins/fzf-zsh-completions

# Source
source $HOME/.zshrc

defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 5
