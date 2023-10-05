#/bin/bash
set -e # If any command fails, the entire script fails

function update_system {
  echo "Updating system..."
  sudo apt-get update
  sudo apt-get upgrade -y
}

function install_essentials {
  echo "Installing essential packages..."
  sudo apt install wget git python3 unzip ca-certificates curl gnupg -y
}

function install_docker {
  echo "Installing Docker..."
  sudo install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  sudo chmod a+r /etc/apt/keyrings/docker.gpg
  echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
}

function install_neovim {
  echo "Installing Neovim..."
  wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
  tar xzvf nvim-linux64.tar.gz
  sudo mv nvim-linux64/bin/nvim /usr/bin/
  rm -rf nvim-linux64
  rm nvim-linux64.tar.gz
}

function install_zsh {
  echo "Installing ZSH..."
  sudo apt install zsh -y
  chsh -s $(which zsh)
}

function install_oh_my_zsh {
  echo "Installing Oh My ZSH..."
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
}

function install_starship {
  echo "Installing Starship..."
  bash -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes
  echo 'eval "$(starship init zsh)"' >> ~/.zshrc
  starship preset plain-text-symbols -o ~/.config/starship.toml
}

function install_nerd_font {
  echo "Installing Nerd Font..."
  curl -fLo ~/.local/share/fonts/JetBrainsMono.zip --create-dirs \
  https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
  unzip ~/.local/share/fonts/JetBrainsMono.zip -d ~/.local/share/fonts/
  fc-cache -fv
}

function install_tmux {
  echo "Installing tmux..."
  sudo apt install tmux -y
}

function install_go {
  echo "Installing go..."
  sudo snap install go --classic
}

function setup_ssh_server {
  echo "Setting up SSH server..."

  # Install the OpenSSH server package
  sudo apt-get install -y openssh-server

  # Start the SSH server
  sudo systemctl start ssh

  # Enable the SSH server to start on boot
  sudo systemctl enable ssh

  echo "SSH server setup complete."
}
  

update_system
install_essentials
install_docker
install_neovim
install_zsh
install_oh_my_zsh
install_starship
install_nerd_font
install_tmux
install_go
setup_ssh_server

echo "All installations are complete. Please reboot your system for all changes to take effect."

