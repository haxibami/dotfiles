# If not running interactively, don't do anything

[[ $- != *i* ]] && return

#alias ls='ls --color=auto'
alias spotify='/usr/bin/spotify --force-device-scale-factor=1.5'
alias jp='setxkbmap -layout jp'
alias onivim='Oni2'
alias ls='exa'

export EDITOR=nvim

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node \

zinit wait lucid light-mode for \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-history-substring-search \
    zsh-users/zsh-completions \
    zdharma/fast-syntax-highlighting \
    mafredri/zsh-async

### End of Zinit's installer chunk

HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

bindkey -v
bindkey -v '^[[H' beginning-of-line
bindkey -v '^[[F' end-of-line

# enable autocompletion
autoload -Uz compinit promptinit
compinit
promptinit

# utf
export LANG=ja_JP.UTF-8

# select completion
zstyle ':completion:*' menu select

export TERM=xterm-256color
export COLORTERM=truecolor

eval "$(starship init zsh)"

# opam configuration
test -r /home/haxibami/.opam/opam-init/init.zsh && . /home/haxibami/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
