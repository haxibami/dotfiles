# If not running interactively, don't do anything

[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias spotify='/usr/bin/spotify --force-device-scale-factor=1.5'
alias jp='setxkbmap -layout jp'

#zplug
source /usr/share/zsh/scripts/zplug/init.zsh
zplug 'zplug/zplug', hook-build: 'zplug --self-manage'
zplug 'mafredri/zsh-async'
zplug 'dracula/zsh', as:theme
zplug 'zsh-users/zsh-syntax-highlighting'
zplug 'zsh-users/zsh-history-substring-search'
zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-completions'

if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

zplug load

bindkey -v

#enable autocompletion
autoload -U compinit
compinit

#utf
export LANG=ja_JP.UTF-8

autoload -Uz promptinit
promptinit

#select completion
zstyle ':completion:*' menu select

