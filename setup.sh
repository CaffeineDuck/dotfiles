#!/bin/bash

DOTFILES_DIR="$HOME/projects/dotfiles"

function create_symlinks() {
  local items=("$@")
  for item in "${items[@]}"; do
    IFS=':' read -r source target <<<"$item"
    if [ -L "$target" ]; then
      echo "Removing existing symlink $target"
      unlink "$target"
    elif [ -d "$target" ]; then
      echo "Warning: $target is a directory. Skipping..."
      continue
    elif [ -e "$target" ]; then
      echo "Warning: $target already exists. Skipping..."
      continue
    fi
    ln -s "$DOTFILES_DIR/$source" "$target"
    echo "Created symlink for $source"
  done
}

common_items=(
  ".tmux.conf:$HOME/.tmux.conf"
  "nvim:$XDG_CONFIG_HOME/nvim"
  "alacritty:$XDG_CONFIG_HOME/alacritty"
)

# Create symlinks for dotfiles 
create_symlinks "${common_items[@]}"

# Download packages using brew if mac
if [[ "$OSTYPE" == darwin* ]]; then
  macos_packages=(
    "tmux"
    "neovim"
    "alacritty"
    "ripgrep"
    "gh"
  )

  for package in "${macos_packages[@]}"; do
    brew install "$package"
  done

  # Set icloud directory
  export ICLOUD=("/Users/caffeineduck/Library/Mobile Documents/com~apple~CloudDocs/")
  ln -sf "$ICLOUD" ~/icloud
fi



