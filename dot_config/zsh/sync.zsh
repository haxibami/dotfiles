# prompt
if [[ ! -z "$SSH_CLIENT" ]]; then
  export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship_light.toml
fi
eval "$(starship init zsh)"

# opts
setopt auto_cd
setopt interactivecomments
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt extended_history

# history
export HISTFILE=$XDG_STATE_HOME/zsh/history
export HISTSIZE=1000000
export SAVEHIST=1000000

# fzf
export FZF_DEFAULT_OPTS='--color=fg:#d2ced9,hl:#86bfb6 --color=fg+:#edebef,bg+:#292433,hl+:#86bfb6 --color=info:#d9c77e,prompt:#abbf86,pointer:#d9989c --color=marker:#d9989c,spinner:#d9c77e,header:#4e4266'
export ZSH_FZF_HISTORY_SEARCH_BIND="^[[A"
export ZSH_FZF_HISTORY_SEARCH_EVENT_NUMBERS=0
