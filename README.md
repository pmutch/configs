On zsh, bash, and config files

The Bash manual loads startup files in this order, depending on the type of
shell:

The bash manual explains startup files sourced depending on the following
shell invocation options:

When Bash is invoked as an interactive login shell, or as a non-interactive
shell with the `--login' option, it first reads and executes commands from the
file `/etc/profile', if that file exists. After reading that file, it looks
for `~/.bash_profile', `~/.bash_login', and `~/.profile', in that order, and
reads and executes commands from the first one that exists and is readable.
The `--noprofile' option may be used when the shell is started to inhibit this
behavior.

When a login shell exits, Bash reads and executes commands from the file
`~/.bash_logout', if it exists.


When an interactive shell that is not a login shell is started, Bash reads and
executes commands from `~/.bashrc', if that file exists. This may be inhibited
by using the `--norc' option. The `--rcfile file' option will force Bash to
read and execute commands from file instead of `~/.bashrc'.

So, typically, your `~/.bash_profile' contains the line

if [ -f ~/.bashrc ]; then . ~/.bashrc; fi
after (or before) any login-specific initializations.


When Bash is started non-interactively, to run a shell script, for example,
it looks for the variable BASH_ENV in the environment, expands its value if
it appears there, and uses the expanded value as the name of a file to read
and execute. Bash behaves as if the following command were executed:

if [ -n "$BASH_ENV" ]; then . "$BASH_ENV"; fi
but the value of the PATH variable is not used to search for the file name.

As noted above, if a non-interactive shell is invoked with the `--login'
option, Bash attempts to read and execute commands from the login shell startup files.



So that's bash. When you open a login shell (i.e. signing in to a linux gui or
opening a new ssh session) it loads the /etc/profile and the first it can find
of ~/.bash_profile, ~/.bash_login, and ~/.profile--notably, NOT the .bashrc.
Interactive shells (i.e. the actual command prompt) load your .bashrc (or other
specified file), and when you run a bash script, it will look in the file named
by BASH_ENV for settings and apply those.



What about zsh? Zsh's manual has a much shorter startup file section:

There are five startup files that zsh will read commands from:

$ZDOTDIR/.zshenv
$ZDOTDIR/.zprofile
$ZDOTDIR/.zshrc
$ZDOTDIR/.zlogin
$ZDOTDIR/.zlogout
If ZDOTDIR is not set, then the value of HOME is used; this is the usual case.

`.zshenv' is sourced on all invocations of the shell, unless the -f option is set.
It should contain commands to set the command search path, plus other important
environment variables. `.zshenv' should not contain commands that produce output
or assume the shell is attached to a tty.

`.zshrc' is sourced in interactive shells. It should contain commands to set up
aliases, functions, options, key bindings, etc.

`.zlogin' is sourced in login shells. It should contain commands that should be
executed only in login shells. `.zlogout' is sourced when login shells exit.
`.zprofile' is similar to `.zlogin', except that it is sourced before `.zshrc'.
`.zprofile' is meant as an alternative to `.zlogin' for ksh fans; the two are
not intended to be used together, although this could certainly be done if desired.
`.zlogin' is not the place for alias definitions, options, environment variable
settings, etc.; as a general rule, it should not change the shell environment at
all. Rather, it should be used to set the terminal type and run a series of external
commands (fortune, msgs, etc).



So zsh will ALWAYS (always) source the .zshenv, then the .zprofile if you have it,
your .zshrc, your .zlogin if you have it, and the .zlogout when you log out. I
haven't yet come across a use for login/logout commands as described in the zsh
manual, so I don't use those. The zsh manual even goes so far as to recommend
what each of these files should be used for (magnifique): .zshenv is for path
modifications and other variables and doesn't modify output, and .zshrc sets up
zsh-specific aliases and so on. These recommendations make it clear what belongs
in what file, but the bash manual has no such recommendation. As such, it's easy
to get confused about what should go where. Furthermore, even if you use zsh,
some programs assume that your machine has and uses bash and therefore write
important config info to your .bashrc, .bash_profile, or .profile (this may be
a bad assumption, but that's software). So the question becomes, what goes where?

Here's what we do.

.profile has all our path modifications and known environment variables that we
want to load no matter which shell we're using. Then .bash_profile and .zshenv
load that file and add in new special-case settings for each shell (i.e. loading
.bashrc at the end of the bash_profile), and .bashrc and .zshrc have shell-specific
aliases, prompt modifications, etc. This ensures that the changes we make to the
.profile are always available, *even when we run Bourne shell scripts
with `sh`.*


Why no .bash_login, .zsh_login, or .zprofile?

As mentioned in the zsh manual, .zlogin "should be used to set the terminal type
and run a series of external commands (fortune, msgs, etc)." I may in the future
use this file, but currently I don't think I want or need to. .zprofile is
apparently used for the same purpose except before you start your zshrc--this may
come in handy as there are some commands which currently live at the top of my
zshrc because I couldn't come up with a better place to put them, but for now
I'm leaving it alone. .bash_login is almost never used--it was apparently
originally intended to be a path towards backwards compatibility for csh, but
since we don't have a `.login` file (which csh used) and do have .bash_profile,
we don't need it. I guess there's a possibility it could come in handy just like
the .zprofile, but...it hasn't for years, and I don't see why it would.
