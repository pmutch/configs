####### ZSHRC #######

# This zsh configuration file relies mainly on built in zsh features, 
# antibody (a very fast plugin manager written in Go), and Powerlevel9k
# (a simple and powerful prompt customization plugin). 


####### ZSH BUILTINS #######

# Make path variable unique to prevent duplicate entries

typeset -U path

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

# Start antibody plugin manager, load plugins

source <(antibody init)
antibody bundle < ~/.zsh_plugins.txt


####### ALIASES #######

# For a full list of active aliases, run `alias`.

alias zshconfig="vim ~/.zshrc"  
alias ls="ls -G" 		# Adds colored output

# chpwd() is called every time the working directory is changed. This function 
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

if [[ $(whoami)="peter.mutch" || $(whoami)="peter" ]]; then
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


####### VIRTUALENVWRAPPER #######

export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Code
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
  export WORKON_HOME=$HOME/.virtualenvs
  export PROJECT_HOME=$HOME/Code
  VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
  source /usr/local/bin/virtualenvwrapper.sh
fi


####### PIP BINARIES #######

export PATH=~/Library/Python/3.7/bin:$PATH


####### POSTGRES #######

# Load PostgreSQL versions into PATH 

if [ -d "/usr/local/Cellar/libpq" ]; then
  for dir in /usr/local/Cellar/libpq/* ; do
    path=($path ${dir}/bin)
  done
fi

# PostgreSQL user and host settings for work

export PGUSER="pillpack_development"
export PGHOST=localhost


####### PYENV CONFIG #######

# Pyenv config must be last to avoid being overwritten by PATH modifications

if (( $+commands[pyenv] )) ; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi


####### OTHER PROFILES #######

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

[[ -s "$HOME/.bash_profile" ]] && source "$HOME/.bash_profile" # Load bash_profile

if [ -r ~/.bashrc ]; then
  source ~/.bashrc
fi


