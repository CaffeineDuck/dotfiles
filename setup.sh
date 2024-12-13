#!/bin/bash

DOTFILES_DIR="$HOME/projects/dotfiles"
GITHUB_URL="git@github.com:CaffeineDuck/dotfiles.git"
UPDATE_BREW=false

function display_help() {
  echo "Usage: $0 [OPTIONS]"
  echo "Manage dotfiles"
  echo
  echo "Options:"
  echo "  -h, --help          Display this help message and exit"
  echo "  -u, --update-brew   Update/install Homebrew packages (macOS only)"
  echo "  -d, --download      Download dotfiles from github and install"
  echo
  echo "Without any options, the script will only create symlinks for dotfiles."
}

function download_and_run() {
  if [ -d "$DOTFILES_DIR" ]; then
    echo "Dotfiles directory already exists. Exiting..."
    exit 1
  fi

  mkdir -p "$DOTFILES_DIR"
  git clone "$GITHUB_URL" "$DOTFILES_DIR"
  echo "Dotfiles downloaded to $DOTFILES_DIR"
}

# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
  case $1 in
  -d | --download)
    download_and_run
    ;;
  -h | --help)
    display_help
    exit 0
    ;;
  -u | --update-brew)
    if [[ "$OSTYPE" != darwin* ]]; then
      echo "Homebrew is only available on macOS. Exiting..."
      exit 1
    fi
    UPDATE_BREW=true
    ;;
  *)
    echo "Unknown parameter passed: $1"
    display_help
    exit 1
    ;;
  esac
  shift
done

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
  ".zshrc:$HOME/.zshrc"
  "nvim:$XDG_CONFIG_HOME/nvim"
  "alacritty:$XDG_CONFIG_HOME/alacritty"
)

# Create symlinks for dotfiles
create_symlinks "${common_items[@]}"

if [[ "$OSTYPE" == darwin* ]]; then
  # Set icloud directory
  export ICLOUD=("/Users/caffeineduck/Library/Mobile Documents/com~apple~CloudDocs/")
  ln -sf "$ICLOUD" ~/icloud
fi

# Download packages using brew if mac and flag is set
if [[ "$OSTYPE" == darwin* ]] && [ "$UPDATE_BREW" = true ]; then
  macos_packages=(
    "tmux"
    "neovim"
    "alacritty"
    "ripgrep"
    "gh"
    "fzf"
    "thefuck"
    "zsh"
    "eza"
  )
  for package in "${macos_packages[@]}"; do
    brew install "$package"
  done
fi
