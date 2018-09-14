# ~/.bash_profile: executed by bash(1) for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/login.defs
#umask 022

# include .bashrc if it exists
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Local Binaries
if [ -d ~/bin ]; then
	PATH=${PATH}:~/bin
	for f in $(find $HOME/bin -mindepth 1 -maxdepth 1 -type d);
	do
		PATH="$PATH:$f"
	done
fi

# Local AutoCommands
if [ -f ~/.bash_autocmds ]; then
	. ~/.bash_autocmds
fi
