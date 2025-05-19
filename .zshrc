# Download Znap, if it's not there yet.
[[ -r ~/Library/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/Library/znap
source ~/Library/znap/znap.zsh

export ANDROID_HOME="/Users/$USER/Library/Android/sdk"

export PATH="$PATH:/opt/homebrew/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/go/bin"
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
export PATH="$PATH:/Users/$USER/.local/bin"

export EDITOR="nvim"

export ZSH_AUTOSUGGEST_USE_ASYNC=true

# Load zsh-completions for 
if [[ -d /opt/homebrew/share/zsh/site-functions ]]; then
  fpath=($fpath /opt/homebrew/share/zsh/site-functions/)
fi

znap prompt romkatv/powerlevel10k

znap source zsh-users/zsh-completions
znap source aloxaf/fzf-tab
znap source zdharma-continuum/fast-syntax-highlighting

znap eval iterm2 'curl -fsSL https://iterm2.com/shell_integration/zsh'

# Powerlevel10k config load; if it exists
[[ ! -f ~/.p10k.zsh ]] || source "$HOME/.p10k.zsh"

source <(fzf --zsh)
source "$HOME/.asdf/asdf.sh"
source "$HOME/.rye/env"

source "$HOME/.local/share/../bin/env"
source "/Users/$USER/.deno/env"

# Enable thefuck fuck alias
eval $(thefuck --alias)

## fzf-tab configuration
# fzf-tab support for tmux popup
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
## set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
## force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
## preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
## custom fzf flags
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
## To make fzf-tab follow FZF_DEFAULT_OPTS.
zstyle ':fzf-tab:*' use-fzf-default-opts yes
## switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'


# Custom Commands
function disable_remote_docker() {
    pgrep -f "ssh -nNT -L /tmp/docker.sock:/var/run/docker.sock x13-local" | while read -r PID; do
        if [[ ! -z "$PID" ]]; then
            kill "$PID"
        fi
    done
    [ -e /tmp/docker.sock ] && rm /tmp/docker.sock
    unset DOCKER_HOST
}

function enable_remote_docker() {
    disable_remote_docker

    ssh -nNT -L /tmp/docker.sock:/var/run/docker.sock x13-local &
    export DOCKER_HOST=unix:///tmp/docker.sock
}

function viewcsv() {
    local file=$1
    if [[ -f "$file" ]]; then
        column -s, -t < "$file" | less -#2 -N -S
    else
        echo "File not found: $file"
    fi
}

# Custom alias
alias vim="nvim"
alias la="ln -s -a"
alias pyenv="python -m venv .venv"
alias spyenv="source .venv/bin/activate" 
