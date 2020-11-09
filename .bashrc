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

#FORMATO \[\e[ (0 = no bold, 1=bold) ; (3=fuente, 4=background) (ID:color) m\]
declare -A MS_COLORS=(
[Color_Off]='\[\e[0m\]'
# Foreground
[Default]='\[\e[0;39m\]'
[Black]='\[\e[0;30m\]'
[DarkGrey]='\[\e[1;30m\]'
[Red]='\[\e[0;31m\]'
[LightRed]='\[\e[1;31m\]'
[Green]='\[\e[0;32m\]'
[LightGreen]='\[\e[0;32m\]'
[Brown]='\[\e[0;33m\]'
[Yellow]='\[\e[1;33m\]'
[Blue]='\[\e[0;34m\]'
[LightBlue]='\[\e[1;34m\]'
[Purple]='\[\e[0;35m\]'
[Pink]='\[\e[1;35m\]'
[Cyan]='\[\e[0;36m\]'
[LightCyan]='\[\e[1;36m\]'
[LightGrey]='\[\e[0;37m\]'
[White]='\[\e[1;37m\]'
# Background
[DefaultBG]='\[\e[49m\]'
[BlackBG]='\[\e[40m\]'
[DarkGreyBG]='\[\e[1;40m\]'
[RedBG]='\[\e[41m\]'
[LightRedBG]='\[\e[1;41m\]'
[GreenBG]='\[\e[42m\]'
[LightGreenBG]='\[\e[1;42m\]'
[BrownBG]='\[\e[43m\]'
[YellowBG]='\[\e[1;43m\]'
[BlueBG]='\[\e[44m\]'
[LightBlueBG]='\[\e[1;44m\]'
[PurpleBG]='\[\e[45m\]'
[PinkBG]='\[\e[1;45m\]'
[CyanBG]='\[\e[46m\]'
[LightCyanBG]='\[\e[1;46m\]'
[LightGreyBG]='\[\e[47m\]'
[WhiteBG]='\[\e[1;47m\]'
)

#[gitchanges]='✎'
declare -A MS_SYMBOL=(
[hard_separator]=""
[soft_separator]=""
[gitpush]='↑'
[gitpull]='↓'
[gitchanges]='*'
[gitbranch]=''
)


# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
	xterm-color)
		PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
	;;
	*)
		PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
	;;
esac

# If this is an xterm set the title to user@host:dir
case "$TERM" in
	xterm*|rxvt*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
	;;
	*)
   ;;
esac

# append to history, don't overwrite it
shopt -s histappend

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
	/usr/bin/svn diff $@ | source-highlight --out-format=esc --src-lang=diff
}

function limpiarficherosconfiguracion
{
	sudo apt remove `deborphan --guess-all`
	sudo apt autoclean
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

controlversion_branch_to_prompt() {
	if [ `pwd` == "$HOME" ]; then
		return;
	fi
	local gitenv="env LANG=C git"
	local branch=$($gitenv symbolic-ref --short HEAD 2>/dev/null)

	local marks='';

	# scan first two lines of output from `git status`
	while IFS= read -r line; do
		if [[ $line =~ ^## ]]; then # header line
			[[ $line =~ ahead\ ([0-9]+) ]] && marks+="${MS_SYMBOL[gitpush]}"
			[[ $line =~ behind\ ([0-9]+) ]] && marks+="${MS_SYMBOL[gitpull]}"
		else # branch is modified if output contains more lines after the header line
			marks="${MS_SYMBOL[gitchanges]}$marks"
			break
		fi
	done < <($gitenv status --porcelain --branch 2>/dev/null)  # note the space between the two <

	if [ "$branch" != "" ]; then
		remoteURL=$(git config --get remote.origin.url | grep -c "mateusan\/home\-dir" )
		if [ $remoteURL -lt 1 ]; then
			PS1+="\e[0;31;49m[${MS_SYMBOL[gitbranch]}"
			PS1+="\e[1;31;49m${branch}${marks}"
			PS1+="\e[0;31;49m] "
		fi
	fi
}

function ps_clear()
{
	PS1+="${MS_COLORS[Color_Off]}"
}
# $1 foregroun next
# $2 Background prev section
function ps_section_end()
{
	if [ "$__last_color" == "$2" ]; then
		local charend="${MS_SYMBOL[soft_separator]}"
		local fg="$1"
	else
		local charend="${MS_SYMBOL[hard_separator]}"
		local fg="$__last_color"
	fi
	if [ -n "$__last_color" ]; then
		PS1+="${MS_COLORS[$fg]}${MS_COLORS[${2}BG]}${charend}"
	fi
}
function ps_section_text()
{
	PS1+="${MS_COLORS[$1]}${MS_COLORS[${2}BG]}${3}"
	__last_color=$2
}

function ps_section_ini() {
	ps_clear
	PS1+="$1$2" 
}
function ps_command()
{
	# last return code
	__return_code=$? 

	local TITLEBAR='\[\e]2; \u@\h: \w \a';

	PS1=""
	# ps_section_text "White" "Black" "\u"

	# ps_section_end "White" "Black"
	# ps_section_text "Blue" "White" "${fqdn}"
	
	# ps_section_end "White" "White"
	# ps_clear
	#PS1+="\n"
	ps_section_ini "${MS_COLORS[White]}"
	PS1+="\u${MS_COLORS[Yellow]}@${MS_COLORS[White]}${fqdn}"
	ps_section_ini "${MS_COLORS[Brown]}"
	PS1+=":"
	ps_section_ini "${MS_COLORS[Yellow]}"
	PS1+="\w\n"
	ps_section_ini "${MS_COLORS[Yellow]}"
	PS1+="[\D{%F %T}] "
	controlversion_branch_to_prompt
	ps_section_ini "${MS_COLORS[Brown]}"
	PS1+="\$"
	ps_section_ini "${MS_COLORS[Brown]}"
	ps_clear
	PS1+=" "
	unset __last_color
	unset __return_code
}
PROMPT_COMMAND="ps_command; $PROMPT_COMMAND"



##########################################################################################
## BASH ALIAS
##########################################################################################

_completion_loader apt &>/dev/null

alias ifconfig="sudo ifconfig"
alias qm="sudo qm"
alias stop-all="sudo killall -9 apache2;  sudo systemctl  stop  apache2.service php7.0-fpm.service php7.1-fpm.service php7.2-fpm.service php7.3-fpm.service php7.4-fpm.service"
alias start-all="sudo systemctl  start  apache2.service php7.0-fpm.service php7.1-fpm.service php7.2-fpm.service php7.3-fpm.service php7.4-fpm.service"

# apt 
if which sudo &>/dev/null; then
	alias apt='sudo apt'

	alias update="sudo apt update"
	alias upgrade="sudo apt dist-upgrade"
	alias install="sudo apt install"
	alias show="sudo apt show"
	alias search="sudo apt search"
	alias remove="sudo apt remove"
	alias purge="sudo apt purge"

	alias salt-key='sudo salt-key'
	alias salt='sudo salt'
	alias salt-call='sudo salt-call --state-output=changes --state-verbose=true'
fi

alias b="grep -RniIH --color=ALWAYS --exclude-dir=data/"
