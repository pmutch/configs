[[ -s "$HOME/.profile" ]] && source $HOME/.profile
export PG_USER="pillpack_development"
export PG_HOST=localhost
for dir in /usr/local/Cellar/libpq/* ; do
  PATH="${dir}/bin:${PATH}"
done
# macOS considers each new command prompt to be a login session,
# which means it looks at this profile but NOT the bashrc, which means
# we have to source it manually here.
[[ -s "$HOME/.bashrc" ]] && source $HOME/.bashrc

export PATH="$HOME/.poetry/bin:$PATH"
