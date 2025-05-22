autoload -U colors && colors
setopt autocd
setopt interactive_comments

export PATH="$HOME/.local/bin:$HOME/.ghcup/bin:$HOME/.cabal/bin:$PATH"
export HISTSIZE=268435456
export SAVEHIST="$HISTSIZE"
export HISTFILE="$ZDOTDIR/.zsh_history"
export EDITOR=/usr/bin/nvim
export TERM=xterm-256color


setopt INC_APPEND_HISTORY

bindkey '^R' history-incremental-search-backward
autoload -Uz compinit promptinit
compinit
promptinit

zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

bindkey -v
export KEYTIMEOUT=1

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
bindkey "\e[3~" delete-char
bindkey -M vicmd "\e[3~" vi-delete-char

function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;
        viins|main) echo -ne '\e[5 q';;
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q'
preexec() { echo -ne '\e[5 q' ;}

bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'


autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

source ~/.local/share/zsh/plugins/fsh/fast-syntax-highlighting.plugin.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source <(fzf --zsh)

alias grep='grep --color=auto'
alias p="ping google.com"
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias lla="eza --color=always --all --long --group-directories-first --icons=always"
alias llt="eza --color=always --tree --all"
alias shell="vim $ZDOTDIR/.zshrc"
alias profile="vim $HOME/.zprofile"

if grep -qi microsoft /proc/sys/kernel/osrelease 2>/dev/null; then
  # In WSL: use Windows pnpm.exe
alias pnpm="pnpm.exe"
fi

# alias rm="trash"

export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --bind 'ctrl-y:execute-silent(echo -n {} | wl-copy)'"
# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

fzf-copy() {
  local selected
  selected=$(fzf)
  if [[ -n "$selected" ]]; then
    echo -n "$selected" | wl-copy
    print -P "%F{green}Copied to clipboard:%f $selected"
  fi
}
bindkey -s '^Y' 'fzf-copy\n'

# cd ~
# neofetch 
if [[ -o interactive ]] && [[ -z "$TMUX" ]]; then
    cd ~
    neofetch
fi

eval "$(starship init zsh)"
