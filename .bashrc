# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#    . /etc/bash_completion
#fi

# remove duplicate colons
export PATH=`ls -d /usr/local/*/bin/ | tr '[[:space:]]' ':' | sed -r -e 's/\/\:/\:/g' -e 's/\:$//'``echo :$PATH | sed 's/\:$//'`
export LD_LIBRARY_PATH=`ls -d /usr/local/*/lib/ | tr '[[:space:]]' ':' | sed -r -e 's/\/\:/\:/g' -e 's/\:$//'``echo :$LD_LIBRARY_PATH | sed 's/\:$//'`
export MANPATH=:`ls -d /usr/local/*/share/man/ | tr '[[:space:]]' ':' | sed -r -e 's/\/\:/\:/g' -e 's/\:$//'``echo :$MANPATH | sed 's/\:$//'`

# remove duplicate items
export PATH="$(perl -e 'print join(":", grep { not $seen{$_}++ } split(/:/, $ENV{PATH}))')"
export LD_LIBRARY_PATH="$(perl -e 'print join(":", grep { not $seen{$_}++ } split(/:/, $ENV{LD_LIBRARY_PATH}))')"
export MANPATH="$(perl -e 'print join(":", grep { not $seen{$_}++ } split(/:/, $ENV{MANPATH}))')"

export CUDA_CACHE_DISABLE=1 # needed by CUDA
export CUDA_VISIBLE_DEVICES=0 # needed by CUDA
# export CUDA_LAUNCH_BLOCKING=1 # needed by CUDA
export ACML_FMA=0 # needed by ACML for bug-fixing
export PERLLIB=. # needed by new Perl for backward compatibility (warning: this will pre-pend "." into @INC, different with old Perl version where "." was appended into @INC)
export CONFIG_SHELL=/bin/bash # needed by autoconf & configure, etc., in addition with (and set to be the same as) chsh-defined $SHELL
export MAKE_SHELL=/bin/bash # might be needed by make, etc., in addition with (and set to be the same as) chsh-defined $SHELL
export SHELL=/bin/bash # double secure the chsh-defined $SHELL

alias nohup='loginctl enable-linger; systemd-run --scope --user nohup'
alias python='python -i'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# eval "$('/c/ProgramData/Miniconda3/Scripts/conda.exe' 'shell.bash' 'hook' 2> /dev/null)"
# '/c/ProgramData/Miniconda3/Scripts/conda.exe' 'shell.bash' 'hook' > ~/.conda.sh 2> /dev/null
# source ~/.conda.sh # modified from and should manually keep update with the results of the above line
# export PATH="/c/ProgramData/Miniconda3/bin:/c/ProgramData/Miniconda3/Scripts:/c/ProgramData/Miniconda3:$PATH"
export CONDA_EXE='/c/ProgramData/Miniconda3/Scripts/conda.exe'
SYSP=$(\dirname "${CONDA_EXE}")
SYSP=$(\dirname "${SYSP}")
PATH="${SYSP}/bin:${PATH}"
PATH="${SYSP}/Scripts:${PATH}"
PATH="${PATH}:${SYSP}/Library/mingw-w64/bin"
PATH="${PATH}:${SYSP}/Library/usr/bin"
PATH="${PATH}:${SYSP}/Library/bin"
PATH="${SYSP}:${PATH}"
export PATH
# <<< conda initialize <<<
