# opam
[[ ! -r ~/.local/share/opam/opam-init/init.zsh ]] || source ~/.local/share/opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# broot
source ~/.config/broot/launcher/bash/br

# pnpm
export PNPM_HOME="$XDG_DATA_HOME/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

export PYENV_ROOT="$XDG_DATA_HOME"/pyenv
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
