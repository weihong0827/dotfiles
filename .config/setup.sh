#!/bin/bash

# Check if Homebrew is already installed
if command -v brew &>/dev/null; then
	echo "Homebrew is already installed. Updating..."
	brew update
else
	echo "Installing Homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Add Homebrew to your shell's PATH
#echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
#eval "$(/opt/homebrew/bin/brew shellenv)"

# Install some common packages (optional)
echo "Installing some common packages..."
brew install wget curl git tmux neovim koekeishiya/formulae/yabai koekeishiya/formulae/skhd docker zsh-syntax-highlighting zsh-autosuggestions

brew tap homebrew/cask-fonts
brew install --cask visual-studio-code jetbrains-toolbox 1password adobe-creative-cloud iterm2 kitty alfred microsoft-outlook microsoft-teams obsidian notion telegram adobe-acrobat-pro sublime-text wechat whatsabrew install --cask font-jetbrains-mono-nerd-fontpp google-chrome intellij-idea zoom font-jetbrains-mono-nerd-font
echo "Homebrew setup complete."

echo "Installing Oh my zsh"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting

git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete

# Back up existing .zshrc if it exists
if [ -e ~/.zshrc ]; then
	mv ~/.zshrc ~/.zshrc_backup
fi

git clone --bare https://github.com/weihong0827/dotfiles.git $HOME/.cfg

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

config checkout
config config --local status.showUntrackedFiles no
git config --global credential.helper store
git config --global user.email 1176101021qiu@gmail.com
git config --global user.name "Qiu Weihong"


