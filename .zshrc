####### ZSHRC #######

# This zsh configuration file relies mainly on built in zsh features,
# antibody (a very fast plugin manager written in Go), and Powerlevel9k
# (a simple and powerful prompt customization plugin).


####### ZSH BUILTINS #######

# Make path variable unique to prevent duplicate entries

typeset -aU path

# Start zsh completion

autoload -U compinit
compinit 


# Hyphen-insensitive autocompletion

HYPHEN_INSENSITIVE="true"

# Display red dots while waiting for command completion

COMPLETION_WAITING_DOTS="true"

# Only relevant if using vim keybindings for command line editing:
# Lowering key timeout makes it faster to switch between insert and normal modes.
# This may cause problems with other terminal commands which depended on this delay.

#export KEYTIMEOUT=.1




####### ANTIBODY #######

# Antibody loads the powerlevel9k plugin, and this variable must be set before doing so.

POWERLEVEL9K_MODE='nerdfont-complete'

# Start antibody plugin manager, dynamically load plugins
# Static loading: 
# run `antibody bundle < $HOME/.zsh_plugins.txt > $HOME/.zsh_plugins.sh`
# the next line sources the file you just generated, so sourcing this file
# sources that file. This loads all zsh plugins--statically. Hopefully this
# results in faster startup times. 
source $HOME/.zsh_plugins.sh

####### ALIASES #######

# For a full list of active aliases, run `alias`.

alias zshconfig="vim $HOME/.zshrc"
alias ls="ls -G" 		# Adds colored output

# Access pillpack production console 
if [ -f $HOME/Code/infrastructure/venv/bin/activate ]; then
    alias prod="source $HOME/Code/infrastructure/venv/bin/activate && $HOME/Code/infrastructure/scripts/wrap_mfa.py --aws-account-name EngineYard --aws-role-name pillpack_iam_dev $HOME/Code/infrastructure/scripts/ssmyo.py --stack Broadwing-prod4 --instance-type=utility-ppcore"
fi
# causes chpwd() to function as it normally would in zsh and ls in the new dir. 

function chpwd() {
  emulate -L zsh
  ls -a
}


####### POWERLEVEL9K #######

# On the left, show user and host if its not peter@mercury, git repo info,
# and error code of last command if it resulted in an error.
# On the right, show virtualenv or rvm information if we're using them
# and the current time.

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context ssh dir vcs status)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(virtualenv rvm time)

# Two-line prompt so command line entry is always in the same place

POWERLEVEL9K_PROMPT_ON_NEWLINE=true

# Set default user so context (user and host) is only printed if it's
# in some way unusual

if [[ $(whoami)="peter.mutch" || $(whoami)="peter" || $(whoami)="mutchp" ]]; then
  DEFAULT_USER=$(whoami)
fi

# Show status only if it was an error

POWERLEVEL9K_STATUS_OK='false'

# Various color and icon settings, including custom prompt icon
# (implemented as a prompt prefix)

POWERLEVEL9K_VIRTUALENV_BACKGROUND='green'
POWERLEVEL9K_VIRTUALENV_FOREGROUND='yellow'
POWERLEVEL9K_RVM_BACKGROUND='162'
POWERLEVEL9K_RVM_FOREGROUND='white'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='005'
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='white'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='009'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='white'
POWERLEVEL9K_VCS_DIRTY_BACKGROUND='red'
POWERLEVEL9K_VCS_DIRTY_FOREGROUND='white'
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='white'
POWERLEVEL9K_DIR_HOME_FOREGROUND='white'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='white'

POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=''
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=$'\u2771 '
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX_BACKGROUND='005'
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX_FOREGROUND='white'


###### ITERM2 SHELL INTEGRATION ######

source 	$HOME/.iterm2_shell_integration.zsh


###### NVM ######

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

###### PYTHON ###### 
export PATH="$PATH:$HOME/Library/Python/3.8/bin"

###### GO ######
export PATH="$PATH:$HOME/go/bin"
export GOPATH=$(go env GOPATH)
###### RVM ######
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Has to be loaded last or RubyMine complains
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 

###### AWS ###### 
export USER="peter.mutch"
