# Set CLICOLOR if you want Ansi Colors in iTerm2
export CLICOLOR=1

# Set colors to match iTerm2 Terminal Colors
export TERM=xterm-256color

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH

# Set iTerm2 window and tab bar to match Solarized Dark Higher Contrast
# courtesy of https://www.iterm2.com/documentation-escape-codes.html
# For some reason, this has to run twice. 
# Once here, and once in the iterm2_shell_integration.bash file.
# If it isn't, it will apply a color to the top bar, but it won't be the right color.
# TODO: This also affects the color of the tab in my Hotkey Terminal window when I have multiple tabs open, and I do not want it to do that. 
echo -ne "\033]6;1;bg;red;brightness;0\a"
echo -ne "\033]6;1;bg;green;brightness;21\a" 
echo -ne "\033]6;1;bg;blue;brightness;37\a"

# Hush "Last login" message on shell start

if ! test -e ~/.hushlogin
then
  touch ~/.hushlogin
fi

# TODO: Include host name if it is different from my own

# TODO: If I am in a directory which is part of a git repository, 
# I would like to display octocat at the front of the command prompt, 
# followed by the directory which is the root of the prompt, followed by 
# a slash, followed by either three asterisks and the working directory 
# or just the working directory if there are no subdirectories between the 
# repository root directory and the working directory. 

# basename `git rev-parse --show-toplevel` gives the name of 
# the current repository. 

# TODO: If I am not in a git repository, I would like to display the 
# working directory in a similar way, with either ~/X/.../Y or 
# /X/.../Y

# TODO: If working directory is ~ (home), replace working directory with 
# 🏠 

function parse_git_branch(){
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ 🐙 😸 (\1)/'
}

export -f parse_git_branch

# TODO: Include any git status information that might predict conflicts etc 
# TODO: Include username if it is root 

# Set Prompt to working directory + [ 🐙😸  (git branch)] + $, in cyan 
#export PS1="\[\033[0;36m\]\w\[\033[0;32m\]\$(parse_git_branch)\[\033[1;36m\]$ \[\033[0m\] "

#export PS1="\[\033[0;36m\]\w\[\033[0;32m\]\$(parse_git_branch)\[\033[1;36m\]\[\033[m\]$ "

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"


# Set GOPATH to $HOME/Code/Go
export GOPATH=$HOME/Code/Go

# Include Go binaries in PATH
export PATH=$PATH:$GOPATH/bin

# Include Python scripts in PATH
export PATH=$PATH:/usr/local/python

# Add /usr/local/bin
export PATH=/usr/local/bin:$PATH

# Adds swiprolog
export PATH=/$PATH:/Applications/SWI-Prolog.app/Contents/MacOS

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Updates PATH for the Google Cloud SDK.
if [ -f '/Users/peter/Downloads/google-cloud-sdk/path.bash.inc' ]; then source '/Users/peter/Downloads/google-cloud-sdk/path.bash.inc'; fi

# Enables shell command completion for gcloud.
if [ -f '/Users/peter/Downloads/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/peter/Downloads/google-cloud-sdk/completion.bash.inc'; fi

# Added by Anaconda3 5.1.0 installer
export PATH="/anaconda3/bin:$PATH"

# Adds CMake to the PATH
export PATH="/Applications/CMake.app/Contents/bin":"$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Starts pyenv and pyenv virtualenv to automatically start virtualenvs when entering the working directory of 
# respective Python projects

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
