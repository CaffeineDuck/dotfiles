dotfiles.

* Download & install the dotfiles
```sh
curl -sSL https://raw.githubusercontent.com/CaffeineDuck/dotfiles/refs/heads/master/setup.sh | bash -s -- -d
```

* CLI Reference
```sh
Usage: ./setup.sh [OPTIONS]
Manage dotfiles

Options:
  -h, --help          Display this help message and exit
  -u, --update-brew   Update/install Homebrew packages (macOS only)
  -d, --download      Download dotfiles from github and install

Without any options, the script will only create symlinks for dotfiles.
```
