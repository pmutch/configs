[[ -s "$HOME/.profile" ]] && source $HOME/.profile

# macOS considers each new command prompt to be a login session,
# which means it looks at this profile but NOT the bashrc, which means
# we have to source it manually here.
[[ -s "$HOME/.bashrc" ]] && source $HOME/.bashrc
