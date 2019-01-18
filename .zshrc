# Start zsh completion
autoload -U compinit
compinit

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
VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
source /usr/local/bin/virtualenvwrapper.sh

####### POWERLEVEL9K #######

# Set default user so context (user and host) is only printed if it's 
# not the default (i.e. a remote session)
DEFAULT_USER="peter"

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
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
