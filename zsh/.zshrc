# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
git
macos
lpass
poetry
)

source $ZSH/oh-my-zsh.sh

up () {
  local d=""
  local limit="$1"

  # Default to limit of 1
  if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
    limit=1
  fi

  for ((i=1;i<=limit;i++)); do
    d="../$d"
  done

  # perform cd. Show error if cd fails
  if ! cd "$d"; then
    echo "Couldn't go up $limit dirs.";
  fi
}

autoload -U +X bashcompinit && bashcompinit

# mapbox
export MAPBOX_ACCESS_TOKEN='pk.eyJ1IjoicGF3ZWxrdyIsImEiOiJjbGg2YmxiNnUwNGpqM2tzNjNjcm9mdXBvIn0.hZl4qhOX9rpc12EPTbXEBA'
alias glintlp='/Users/pawelkwasniewski/git/glint-layer-processor/glint_layer_processor.sh'

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# pdfbox 
alias pdfdebug="java -jar $HOME/Tools/pdfbox-app-3.0.0.jar debug"

complete -o nospace -C /opt/homebrew/bin/terraform terraform

eval $(thefuck --alias)

