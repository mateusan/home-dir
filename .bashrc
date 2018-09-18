# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

#Utilizando tput te limita a 80 caracteres la línea
Black="$(tput setaf 0)"
BlackBG="$(tput setab 0)"
DarkGrey="$(tput bold ; tput setaf 0)"
LightGrey="$(tput setaf 7)"
LightGreyBG="$(tput setab 7)"
White="$(tput bold ; tput setaf 7)"
Red="$(tput setaf 1)"
RedBG="$(tput setab 1)"
LightRed="$(tput bold ; tput setaf 1)"
Green="$(tput setaf 2)"
GreenBG="$(tput setab 2)"
LightGreen="$(tput bold ; tput setaf 2)"
Brown="$(tput setaf 3)"
BrownBG="$(tput setab 3)"
Yellow="$(tput bold ; tput setaf 3)"
Blue="$(tput setaf 4)"
BlueBG="$(tput setab 4)"
LightBlue="$(tput bold ; tput setaf 4)"
Purple="$(tput setaf 5)"
PurpleBG="$(tput setab 5)"
Pink="$(tput bold ; tput setaf 5)"
Cyan="$(tput setaf 6)"
CyanBG="$(tput setab 6)"
LightCyan="$(tput bold ; tput setaf 6)"
Normal="$(tput sgr0)" # No Color

#FORMATO \[\e[ (0 = no bold, 1=bold) ; (3=fuente, 4=background) (ID:color) m\]
Black="\[\e[0;30m\]"
BlackBG="\[\e[0;40m\]"
DarkGrey="\[\e[1;30m\]"
LightGrey="\[\e[0;37m\]"
LightGreyBG="\[\e[0;47m\]"
White="\[\e[1;37m\]"
Red="\[\e[0;31m\]"
RedBG="\[\e[0;41m\]"
LightRed="\[\e[1;31m\]"
Green="\[\e[0;32m\]"
GreenBG="\[\e[0;42m\]"
LightGreen="\[\e[0;32m\]"
Brown="\[\e[0;33m\]"
BrownBG="\[\e[0;43m\]"
Yellow="\[\e[1;33m\]"
Blue="\[\e[0;34m\]"
BlueBG="\[\e[0;44m\]"
LightBlue="\[\e[1;34m\]"
Purple="\[\e[0;35m\]"
PurpleBG="\[\e[0;45m\]"
Pink="\[\e[1;35m\]"
Cyan="\[\e[0;36m\]"
CyanBG="\[\e[0;46m\]"
LightCyan="\[\e[1;36m\]"
Normal="\[\e[0m\]"



# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
	xterm-color)
		PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
	;;
	*)
		PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
	;;
esac

PS1="${White}\u${Yellow}@${White}\h${Brown}:${Yellow}\w ${Brown}\$${Normal} "
# If this is an xterm set the title to user@host:dir
case "$TERM" in
	xterm*|rxvt*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
	;;
	*)
   ;;
esac

## Historial por nombre de servidor

fqdn=$(hostname -f)
mkdir -p ${HOME}/.history/ && chmod 744 ${HOME}/.history/
export HISTFILE=${HOME}/.history/${fqdn}
touch $HISTFILE

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='ls --color=auto --format=vertical'
    alias vdir='ls --color=auto --format=long'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

## Locales 

LANG="es_ES.utf8"
LANGUAGE="es_ES.utf8"
LC_ALL="es_ES.utf8"

##########################################################################################
## BASH FUNCTIONS
##########################################################################################

function svndiff
{
	svn diff $@ | source-highlight --out-format=esc --src-lang=diff
}

function limpiarficherosconfiguracion
{
	sudo aptitude remove `deborphan --guess-all`
	sudo aptitude autoclean
	paquetes=$(COLUMNS=200 dpkg -l | grep ^rc | awk '{print $2}')
	if [ "$paquetes" != "" ]; then
		sudo dpkg -P $paquetes
	fi
}

function ms_extract()
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1  ;;
            *.tar.gz)    tar xvzf $1  ;;
            *.bz2)       bunzip2 $1  ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1     ;;
            *.tar)       tar xvf $1        ;;
            *.tbz2)      tar xvjf $1      ;;
            *.tgz)       tar xvzf $1       ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1    ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# funcion para escapar argumentos del bash
#args=$(escapeshellarguments "$@")

escapeshellarguments() {
   whitespace="[[:space:]]"
   for i in "$@"
   do  
       if [[ $i =~ $whitespace ]]
       then
           i=\"$i\"
       fi  
      echo -n "$i "
   done
}

parse_svn_branch() {
	issvn=$(svn info --show-item wc-root 2>/dev/null)
	if  [ "$issvn" != "" ]; then
		relativeURL=`svn info --show-item=relative-url 2>/dev/null`
		if [[ $relativeURL =~ trunk ]]; then
			echo 'trunk'
		elif [[ $relativeURL =~ /branches/ ]]; then
			echo $url | sed -e 's#^.*/\(branches/.*\)/.*$#\1#'
		elif [[ $relativeURL =~ /tag/s ]]; then
			echo $url | sed -e 's#^.*/\(tags/.*\)/.*$#\1#'
		fi
	fi
}
parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}
controlversion_branch_to_prompt() {
	if [ `pwd` == "$HOME" ]; then
		return;
	fi
	branch=$(parse_svn_branch)
	if [ "$branch" != "" ]; then
		echo -ne " \001\e[0;31;49m\002[svn:"
		if [ "$branch" == "trunk" ]; then
			echo -ne "\001\e[1;31;49m\002$branch"
		else
			echo -ne "\001\e[39;41m\002$branch"
		fi
		revision=$(svn info --show-item=revision)
		echo -ne "\001\e[0;31;49m\002 rev:$revision]"
	fi

	branch=$(parse_git_branch)
	if [ "$branch" != "" ]; then
		remoteURL=$(git config --get remote.origin.url | grep -c "mateusan\/home\-dir" )
		if [ $remoteURL -lt 1 ]; then
			echo -ne " \001\e[0;31;49m\002[git:"
			echo -ne "\001\e[1;31;49m\002$branch"
			echo -ne "\001\e[0;31;49m\002]"
		fi
	fi

}
# Poner el \001 002 para escapar los caracteres de escape del bash
# https://stackoverflow.com/questions/19092488/custom-bash-prompt-is-overwriting-itself
PS1="${White}\u${Yellow}@${White}${fqdn}${Brown}:${Yellow}\w \n${Yellow}[\D{%F %T}]\$(controlversion_branch_to_prompt) ${Brown}\$${Normal} "



##########################################################################################
## BASH ALIAS
##########################################################################################

_completion_loader apt-get &>/dev/null
_completion_loader aptitude &>/dev/null

alias ifconfig="sudo ifconfig"
alias qm="sudo qm"

# Aptitude
if which sudo &>/dev/null; then
	alias apt-get='sudo apt-get'
	alias aptitude='sudo aptitude'

	alias update="sudo aptitude update"
	alias upgrade="sudo aptitude dist-upgrade"
	alias safe-upgrade="sudo aptitude safe-upgrade"
	alias install="sudo aptitude install"
	alias show="sudo aptitude show"
	alias search="sudo aptitude search"
	alias remove="sudo aptitude remove"
	alias purge="sudo aptitude purge"

	# AutoComplete commands
	complete -F _aptitude install purge show search remove

	alias salt-key='sudo salt-key'
	alias salt='sudo salt'
	alias salt-call='sudo salt-call'
fi

if [ -d ~/bin/svn-wrapper ]; then
	alias svn="~/bin/svn-wrapper/svn-wrapper.sh $@"
fi
