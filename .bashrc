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

# FORMATO \[\e[ (0 = no bold, 1=bold) ; (3=fuente, 4=background) (ID:color) m\]
# https://misc.flogisoft.com/bash/tip_colors_and_formatting
# ( for i in "${!MS_COLORS[@]}"; do echo -e "${i}::: ${MS_COLORS[$i]}${i}\e[0m"; done ) | sort
declare -A MS_COLORS=(
# 
[Color_Off]='\e[0m'

# Foreground
[Default]='\e[0;39m'
[DefaultBold]='\e[1;39m'

[Black]='\e[0;30m'
[Red]='\e[0;31m'
[Green]='\e[0;32m'
[Yellow]='\e[0;33m'
[Blue]='\e[0;34m'
[Magenta]='\e[0;35m'
[Cyan]='\e[0;36m'
[LightGray]='\e[0;37m'

[BlackBold]='\e[1;30m'
[RedBold]='\e[1;31m'
[GreenBold]='\e[1;32m'
[YellowBold]='\e[1;33m'
[BlueBold]='\e[1;34m'
[MagentaBold]='\e[1;35m'
[CyanBold]='\e[1;36m'
[LightGrayBold]='\e[1;37m'

[DarkGray]='\e[0;90m'
[LightGray]='\e[0;91m'
[LightGreen]='\e[0;92m'
[LightYellow]='\e[0;93m'
[LightBlue]='\e[0;94m'
[LightMagenta]='\e[0;95m'
[LightCyan]='\e[0;96m'
[White]='\e[0;97m'

[DarkGrayBold]='\e[1;90m'
[LightGrayBold]='\e[1;91m'
[LightGreenBold]='\e[1;92m'
[LightYellowBold]='\e[1;93m'
[LightBlueBold]='\e[1;94m'
[LightMagentaBold]='\e[1;95m'
[LightCyanBold]='\e[1;96m'
[WhiteBold]='\e[1;97m'

# Background
[DefaultBG]='\e[49m'

[BlackBG]='\e[40m'
[RedBG]='\e[41m'
[GreenBG]='\e[42m'
[YellowBG]='\e[43m'
[BlueBG]='\e[44m'
[MagentaBG]='\e[45m'
[CyanBG]='\e[46m'
[LightGrayBG]='\e[47m'

[DarkGrayBG]='\e[100m'
[LightRedBG]='\e[101m'
[LightGreenBG]='\e[102m'
[LightYellowBG]='\e[103m'
[LightBlueBG]='\e[104m'
[LightMagentaBG]='\e[105m'
[LightCyanBG]='\e[106m'
[WhiteBG]='\e[107m'

)

#[gitchanges]='✎'
declare -A MS_SYMBOL=(
[hard_separator]=""
[soft_separator]=""
[gitpush]='↑'
[gitpull]='↓'
[gitchanges]='*'
[gitbranch]=''
[return_code]='⚑'
[background_jobs]="⏎"
[ssh]="‡"
[local]='§'
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
			ps_section_end 'Red'
			ps_section_text "RedBold" " ${MS_SYMBOL[gitbranch]} ${branch}"
			ps_section_text "LightMagentaBold" "${marks} "
		fi
	fi
}

function ps_clear()
{
	PS1+="${MS_COLORS[Color_Off]}"
}
function ps_section_text()
{
	PS1+="${MS_COLORS[$1]}${MS_COLORS[${__last_color}BG]}${2}"
}
function ps_section_flag()
{
	__FLAGS+="${MS_COLORS[$1]}${2} "
}
function ps_section_ini()
{
	PS1+="${MS_COLORS[$__last_color]}${MS_COLORS[${1}BG]}${MS_SYMBOL[soft_separator]}"
	__last_color=$1
}
function ps_section_end()
{
	PS1+="${MS_COLORS[$__last_color]}${MS_COLORS[${1}BG]}${MS_SYMBOL[hard_separator]}"
	__last_color=$1
}

function ps_command()
{
	# last return code
	__return_code=$? 
	__last_color='Blue';
	__last_color='White';

	PS1=''
	local __FLAGS=''
    
	if [[ "${SSH_CLIENT}" || "${SSH_TTY}" ]]; then
		ps_section_text "BlackBold" "${MS_SYMBOL[ssh]}SSH"
	else
		ps_section_text "BlackBold" "${MS_SYMBOL[local]}"
	fi
	
	ps_section_end "Blue"


#	ps_section_end  "Black"
	#ps_section_text "WhiteBold" " \D{%F %T} "
	#ps_section_end "Blue"

	name="\u"
	name+="${MS_COLORS[LightYellowBold]}@"
	name+="${MS_COLORS[WhiteBold]}${fqdn}"
	ps_section_text "WhiteBold" " $name "
	

	ps_section_end  "DarkGray"
	ps_section_text "GreenBold" " \w "
	controlversion_branch_to_prompt
    local number_jobs=$(jobs -p | wc -l | tr -d [:space:])
    if [ ! "$number_jobs" -eq 0 ]; then
		ps_section_flag "BlueBold" "${MS_SYMBOL[background_jobs]}$number_jobs"
    fi
	if [ ! "$__return_code" -eq 0 ]; then
		ps_section_flag "RedBold" "${MS_SYMBOL[return_code]}$__return_code"
	fi
	if [ ! -z "$__FLAGS" ]; then
		ps_section_end "White"
		ps_section_text "Black" " ${__FLAGS}"
	fi
	ps_section_end "Default"
	PS1+="\n"

	ps_clear
	
	ps_section_text "LightYellowBold" "[\D{%F %T}] "
	ps_section_text "Yellow" "\$"
	ps_clear
	# Erase EOL
	PS1+="\[\e[K\] "
	unset __last_color
	unset __return_code
	unset __FLAGS
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
