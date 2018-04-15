#
# Environment variables
#

# Language
if [[ -z "$LANG" ]]; then
  export LANG='en_NZ.UTF-8'
fi

# Temporary Files
if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="/tmp/$LOGNAME"
  mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR%/}/zsh"

# Zplug
export ZPLUG_HOME="$XDG_DATA_HOME/zplug"

# Editors
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

# Less (disable history)
export PAGER='less'
export LESSHISTFILE=-

# FZF (use ripgrep)
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-ignore --glob "!.git/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Composer
export COMPOSER_HOME="$XDG_CONFIG_HOME"/composer
export COMPOSER_CACHE_DIR="$XDG_CACHE_HOME"/composer

# Development
export NODE_ENV=dev

#
# Paths
#
path=(
$HOME/.local/bin
$HOME/.cargo/bin
/usr/local/bin
$path
)

# Ensure unique paths in array
typeset -gU cdpath fpath mailpath path

