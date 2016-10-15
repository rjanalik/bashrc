# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

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

# determine git branch to show it in prompt
__git_ps1 ()
{
   branch=`git branch 2>/dev/null | grep ^* | colrm 1 2`
   if [ -n "$branch" ]; then
      echo " ($branch)"
   fi  
}

if [ "$color_prompt" = yes ]; then
   PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '
else
   PS1='\u@\h:\w\$(__git_ps1)\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
   xterm*|rxvt*)
      PS1="\[\e]0;\u@\h: \w\a\]$PS1"
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
#alias du='du  -sk * | sort -nr | cut -f2 | xargs -d \'\n\' du -sh'

if [ -f ~/.bash_aliases ]; then
   . ~/.bash_aliases
fi

# Set completion
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
   . /etc/bash_completion
fi

# Set homebrew completion
if hash brew 2>/dev/null; then
   if [ -f $(brew --prefix)/etc/bash_completion ]; then
      . $(brew --prefix)/etc/bash_completion
   fi
fi


export OMP_NUM_THREADS=1

#export LANG="en_US.utf8"
#export LC_ALL="en_US.utf8"
#export PATH=$PATH=/usr/local/cuda/bin
#export LD_LIBRARY_PATH=/opt/intel/mkl/lib/intel64

#. /opt/intel/mkl/bin/mklvars.sh intel64
#. /opt/intel/bin/compilervars.sh intel64
## replace // -> / done by intel scripts
#export PATH=`echo $PATH | sed 's/\/\//\//g' | sed 's/\/:/:/g'`
#export PKG_CONFIG_PATH=/Users/radim/Apps_src/StarPU/
#export PATH=$PATH:/Users/radim/Apps_src/openmpi-2.0.1/bin

# use MacVim instead of default vim
#alias vim="/usr/local/bin/vim"
