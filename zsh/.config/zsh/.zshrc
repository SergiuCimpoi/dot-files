
autoload -U colors && colors
setopt autocd
setopt interactive_comments

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

bindkey -s '^a' 'bc -lq\n'
bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'


autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

source ~/.local/share/zsh/plugins/fsh/fast-syntax-highlighting.plugin.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


alias ls='lsd --color=auto'
alias grep='grep --color=auto'
alias p="ping google.com"
alias ll="lsd --long --group-dirs=first"
alias lla="lsd --long --all --group-dirs=first"
alias llt="lsd --tree --all"
alias shell="vim $ZDOTDIR/.zshrc"
alias profile="vim $HOME/.zprofile"
# alias rm="trash"

pk() {
  pgrep -i "$1" | sudo xargs kill -9
}

cd ~
neofetch 

eval "$(starship init zsh)"
