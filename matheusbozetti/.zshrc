# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

eval "$(starship init zsh)"

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export GPG_TTY=$(tty)

alias kubectl="minikube kubectl --"
alias lg="lazygit"
alias ls="lsd"
alias du="dust"
alias ld="lazydocker"
alias matheus="cd ~/Projects/matheus/"
alias tbdc="cd ~/Projects/tbdc/"
alias pn=pnpm
alias zr='source ~/.zshrc'
alias devf='pnpm dev:frontend'
alias devb='pnpm dev:backend'
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"

alias vim='nvim'
alias n='nvim .'

alias nodeVersion="echo $(grep 'version' 'package.json' | cut -d ":" -f2-)"
alias clearNodeModules="find ~/Projects -name 'node_modules' -type d -prune -print -exec rm -rf '{}' +"
alias clearLocalNodeModules="find . -name 'node_modules' -type d -prune -print -exec rm -rf '{}' +"

alias clk='~/clk.sh'

# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
#
# Activate syntax highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Disable underline
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none
# Change colors
# export ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=blue
# export ZSH_HIGHLIGHT_STYLES[precommand]=fg=blue
# export ZSH_HIGHLIGHT_STYLES[arg0]=fg=blue

# Activate autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration


# Compilation flags
# export ARCHFLAGS="-arch x86_64"

#
# Example aliases
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin"

export NVM_DIR="${XDG_CONFIG_HOME}/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# bun completions
[ -s "/Users/matheusbozetti/.bun/_bun" ] && source "/Users/matheusbozetti/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/matheusbozetti/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

PATH=~/.console-ninja/.bin:$PATH

# MacOS change XDG_CONFIG_HOME to ~/.config
export XDG_CONFIG_HOME="$HOME/.config"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source $HOME/.cargo/env
export PATH="/opt/homebrew/opt/php@7.4/bin:$PATH"
export PATH="/opt/homebrew/opt/php@7.4/sbin:$PATH"


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"


# -- ALWAYS OPEN TMUX
# if [ -z "$TMUX" ]; then
#   exec tmux new-session -c "$PWD"
# fi

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/matheusbozetti/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
