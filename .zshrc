# Start zsh completion
autoload -U compinit
compinit

# Load PostgreSQL versions into PATH 
for dir in /usr/local/Cellar/libpq/* ; do
  PATH="${dir}/bin/:${PATH}"
done

# PostgreSQL user and host settings for work
export PGUSER="pillpack_development"
export PGHOST=localhost

# Start antibody plugin manager, load plugins
source <(antibody init)
antibody bundle < ~/.zsh_plugins.txt

# Hyphen-insensitive autocompletion
HYPHEN_INSENSITIVE="true"

# Display red dots while waiting for command completion
COMPLETION_WAITING_DOTS="true"

# Set personal aliases, overriding those provided by plugins 
# and themes. For a full list of active aliases, run `alias`.
#
# Example alias
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias zshconfig="vim ~/.zshrc"

#Virtualenvwrapper things
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Code
if [ -f /usr/local/bin/python ]; then
  VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
fi

if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
  source /usr/local/bin/virtualenvwrapper.sh
fi

####### POWERLEVEL9K #######

# Set default user so context (user and host) is only printed if it's 
# not the default (i.e. a remote session)
if [[ $(whoami)="peter.mutch" || $(whoami)="peter" ]]; then
  DEFAULT_USER=$(whoami)
fi

# Two-line prompt so commands always start in the same place
POWERLEVEL9K_PROMPT_ON_NEWLINE=true

# Show user and host if its not peter@mercury, pyenv if it's in use, 
# current directory, and git information if we're in a repo. 
# Show nothing on the right. 

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context virtualenv dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

# Various color and icon settings, including custom prompt icon
POWERLEVEL9K_VIRTUALENV_BACKGROUND='green'
POWERLEVEL9K_VIRTUALENV_FOREGROUND='yellow'
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


####### PYENV CONFIG #######
# Must be last to avoid being overwritten by PATH modifications
if (( $+commands[pyenv] )) ; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

####### OTHER PROFILES #######
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

if [ -r ~/.bashrc ]; then
  source ~/.bashrc
fi
