# If not running interactively, do not do anything
[[ $- != *i* ]] && return
[[ -z "$TMUX" ]] && exec tmux
# TMUX
#if which tmux >/dev/null 2>&1; then
#    #if not inside a tmux session, and if no session is started, start a new session
#    test -z "$TMUX" && (tmux attach || tmux new-session)
#fi


# aliases
alias spotify='/usr/bin/spotify --force-device-scale-factor=1.5'
alias jp='setxkbmap -layout jp'
alias onivim='Oni2'
alias ls='exa'

# set environment variables
export EDITOR=nvim
export LANG=ja_JP.UTF-8
#export TERM=xterm-256color
export COLORTERM=truecolor

# auto-compile ~/.zshrc
if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
   zcompile ~/.zshrc
fi

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
zinit lucid light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node \

### End of Zinit's installer chunk

# zinit: load plugins
zinit wait lucid light-mode for \
  wait'0a' atload'bindkey "^[[A" history-substring-search-up; bindkey "^[[B" history-substring-search-down' \
    zsh-users/zsh-history-substring-search \
  blockf \
    zsh-users/zsh-completions \
    wait'0b' atinit'ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay' \
      zdharma/fast-syntax-highlighting \
    wait'0c' atload'_zsh_autosuggest_start' \
      zsh-users/zsh-autosuggestions \
  mafredri/zsh-async

# history
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# enable autocompletion
autoload -Uz promptinit
promptinit
autoload -U compinit
compinit

# keybind
bindkey -v
bindkey -v '^[[H' beginning-of-line
bindkey -v '^[[F' end-of-line
#bindkey "${terminfo[khome]}" beginning-of-line
#bindkey "${terminfo[kend]}" end-of-line
if [[ -n "$TMUX" ]]; then
  bindkey -v '^[[1~' beginning-of-line
  bindkey -v '^[[4~' end-of-line
fi

# select completion
zstyle ':completion:*' menu select

# prompt
eval "$(starship init zsh)"

# opam configuration
test -r /home/haxibami/.opam/opam-init/init.zsh && . /home/haxibami/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
