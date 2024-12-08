# oh-my-zsh
export ZSH="$XDG_CONFIG_HOME/oh-my-zsh"

ZSH_THEME="robbyrussell"
plugins=(
    git
    zsh-autosuggestions
    vi-mode
)
. "$ZSH/oh-my-zsh.sh"
# oh-my-end

# asdf
. "$XDG_CONFIG_HOME/asdf/asdf.sh"
# asdf end

# pnpm
export PNPM_HOME="~/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
