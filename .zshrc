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


####### ANTIBODY #######

# Antibody loads the powerlevel9k plugin, and this variable must be set before doing so.

POWERLEVEL9K_MODE='nerdfont-complete'

# Start antibody plugin manager, dynamically load plugins
# Static loading: 
# run `antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh`
# the next line sources the file you just generated, so sourcing this file
# sources that file. This loads all zsh plugins--statically. Hopefully this
# results in faster startup times. 
source ~/.zsh_plugins.sh

####### ALIASES #######

# For a full list of active aliases, run `alias`.

alias zshconfig="vim ~/.zshrc"  
alias ls="ls -G" 		# Adds colored output

# Access pillpack production console 
if [ -f ~/Code/infrastructure/venv/bin/activate ]; then
    alias prod="source ~/Code/infrastructure/venv/bin/activate && ~/Code/infrastructure/scripts/wrap_mfa.py --aws-account-name EngineYard --aws-role-name pillpack_iam_dev ~/Code/infrastructure/scripts/ssmyo.py --stack Broadwing-prod4 --utility-ppcore"
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


###### VIRTUALENVWRAPPER #######

if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
  export WORKON_HOME=$HOME/.virtualenvs
  export PROJECT_HOME=$HOME/Code
  VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
  source /usr/local/bin/virtualenvwrapper.sh
fi


####### PIP BINARIES #######

path=($HOME/Library/Python/3.7/bin $path)


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

###### JAVA HOME ENV VARIABLE ######

export JAVA_HOME="$(/usr/libexec/java_home)"


####### OTHER PROFILES #######

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


