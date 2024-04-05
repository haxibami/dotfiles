# opam
[[ ! -r ~/.local/share/opam/opam-init/init.zsh ]] || source ~/.local/share/opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# broot
source ~/.config/broot/launcher/bash/br

# pnpm
export PNPM_HOME="$XDG_DATA_HOME/pnpm"
export PATH="$PNPM_HOME:$PATH"

# rye
source "$XDG_CONFIG_HOME"/rye/env

# bun
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
