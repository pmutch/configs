# Set CLICOLOR if you want Ansi Colors in iTerm2
# export CLICOLOR=1

# Set colors to match iTerm2 Terminal Colors
# export TERM=xterm-256color

####### VIRTUALENVWRAPPER #######

if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
  export WORKON_HOME=$HOME/.virtualenvs
  export PROJECT_HOME=$HOME/Code
  VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
  source /usr/local/bin/virtualenvwrapper.sh
fi


####### PIP BINARIES #######

if [ -d $HOME/Library/Python/3.7/bin ]; then
  path=($path $HOME/Library/Python/3.7/bin)
fi


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


####### PYENV CONFIG #######

# Pyenv config must be last to avoid being overwritten by PATH modifications
# Pyenv appears to cause its shims to be added to PATH multiple times,
# even when path is set to be unique. This is both in accordance with what
# happened when I tried to use it in my zsh environment and implied by their
# documentation. It's probably best to avoid loading it at every interactive
# prompt, or even at every zsh instance, until I'm willing to figure out how
# to prevent this from happening--potentially by modifying pyenv init or
# referring to the Advanced Configuration section of their README.
#
#if (( $+commands[pyenv] )) ; then
#  eval "$(pyenv init -)"
#  eval "$(pyenv virtualenv-init -)"
#fi
# Pyenv variables
#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PATH:$PYENV_ROOT/bin"

####### VIRTUALENVWRAPPER #######

if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
  export WORKON_HOME=$HOME/.virtualenvs
  export PROJECT_HOME=$HOME/Code
  VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
  source /usr/local/bin/virtualenvwrapper.sh
fi


####### PIP BINARIES #######

if [ -d $HOME/Library/Python/3.7/bin ]; then
  path=($HOME/Library/Python/3.7/bin $path)
fi


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


####### PYENV CONFIG #######

# Pyenv config must be last to avoid being overwritten by PATH modifications
# Pyenv appears to cause its shims to be added to PATH multiple times,
# even when path is set to be unique. This is both in accordance with what
# happened when I tried to use it in my zsh environment and implied by their
# documentation. It's probably best to avoid loading it at every interactive
# prompt, or even at every zsh instance, until I'm willing to figure out how
# to prevent this from happening--potentially by modifying pyenv init or
# referring to the Advanced Configuration section of their README.
#
#if (( $+commands[pyenv] )) ; then
#  eval "$(pyenv init -)"
#  eval "$(pyenv virtualenv-init -)"
#fi


###### NVM ######
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

###### GO ######
path=($path /Users/peter.mutch/go/bin)

###### SBIN ######
path=($path /usr/local/sbin)

###### FORTIFY ######
export PATH="$PATH:/Applications/Fortify/Fortify_SCA_and_Apps_20.1.0/bin"
