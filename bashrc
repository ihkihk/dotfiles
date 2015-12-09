# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide. This software is distributed without any warranty.
# You should have received a copy of the CC0 Public Domain Dedication along
# with this software.
# If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

# base-files version 4.1-1

# ~/.bashrc: executed by bash(1) for interactive shells.

# The latest version as installed by the Cygwin Setup program can
# always be found at /etc/defaults/etc/skel/.bashrc
# Modifying /etc/skel/.bashrc directly will prevent
# setup from updating it.

# On Ubuntu see /usr/share/doc/bash/examples/startup-files
# (in the package bash-doc) for examples


# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


############
# Location #
############
if [ -f ~/.id ]; then
  LOCLABEL=`python3 -c "import os; fd = open(os.path.expanduser('~/.id'));  a=eval(fd.read()); print(a['label'])"`
fi
export LOCLABEL

echo Location: $LOCLABEL


#################
# Shell Options #
#################
#
# See man bash for more options...
#
# Don't wait for job termination notification
# set -o notify
#
# Don't use ^D to exit
# set -o ignoreeof
#
# Use case-insensitive filename globbing
# shopt -s nocaseglob
#
# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
# shopt -s globstar
#
# Make bash append rather than overwrite the history on disk
shopt -s histappend
#
# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
# shopt -s cdspell
#
# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


######################
# Completion options #
######################
#
# These completion tuning parameters change the default behavior of bash_completion:
#
# Define to access remotely checked-out files over passwordless ssh for CVS
# COMP_CVS_REMOTE=1
#
# Define to avoid stripping description in --option=description of './configure --help'
# COMP_CONFIGURE_HINTS=1
#
# Define to avoid flattening internal contents of tar files
# COMP_TAR_INTERNAL_PATHS=1
#
# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# Git Completion
if [ -f ~/bin/git-completion.sh ]; then
    source ~/bin/git-completion.sh
fi


###################
# History Options #
###################
#
# For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
#
# Don't put duplicate lines in the history.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
#
# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit'
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls' # Ignore the ls command as well
#
# Whenever displaying the prompt, write the previous line to disk
# export PROMPT_COMMAND="history -a"


###########
# Aliases #
###########
#
# Some people use a different file for aliases
if [ -f ~/.bash_local_aliases ]; then
  source ~/.bash_local_aliases
fi
if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi
#
# Some example alias instructions
# If these are enabled they will be used instead of any instructions
# they may mask.  For example, alias rm='rm -i' will mask the rm
# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.
#
# Interactive operation...
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
#
# Default to human readable figures
alias df='df -h'
alias du='du -h'
#
# Misc :)
# alias less='less -r'                          # raw control characters
# alias whence='type -a'                        # where, of a sort
#
# Some shortcuts for different directory listings
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -hF --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
alias ll='ls -l'                              # long list
alias la='ls -A'                              # all but . and ..
alias l='ls -CF'                              #
alias envs='env | sort'
alias tarz='tar -zxvf'
alias tarb='tar -jxvf'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'


###################
# Git integration #
###################
#
# Git prompt
if [ -f "${HOME}/bin/git-prompt.sh" ]; then
    source "${HOME}/bin/git-prompt.sh"
fi

# Set here Git author email, instead of in .gitconfig
if [ "$LOCLABEL" = home ]; then
  GIT_AUTHOR_EMAIL="ivokassamakov@gmail.com"
elif [ "$LOCLABEL" = work ]; then
  GIT_AUTHOR_EMAIL="ikassamakov@etel.ch"
fi
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
export SHOWDIRTYSTATE=1 GIT_AUTHOR_EMAIL GIT_COMMITTER_EMAIL



#############################
# Prompt and terminal title #
#############################

# Color the user differently if it is root
if [ `id -u` -eq 0 ]; then
	USER_COLOR="\[\e[1;31m\]"
else
	USER_COLOR="\[\e[0;33m\]"
fi

# Set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# Uncomment for a colored prompt, if the terminal has the capability; turned
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

if [ "$color_prompt" = yes ]; then
  if [ "$LOCLABEL" = home ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  else
    PS1="\n${USER_COLOR}\u@\h \[\e[0;34m\]\l \[\e[0;35m\]\w\n\[\e[0;32m\]\t [cmd#:\#] (git: \$(__git_ps1 "%s")) >\[\e[m\]"
  fi
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt USER_COLOR

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
  if [ "$LOCLABEL" = home ]; then
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  else
    PS1="\[\e]0;${OSTYPE}-${SESSIONNAME}-\u-\w\a\]$PS1"
  fi
    ;;
*)
    ;;
esac


########################
# Specific adjustments #
########################
#
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
#
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
#
# Proxy
if [ "$LOCLABEL" = work ]; then
  export all_proxy=localhost:3128
fi


# Umask
#
# /etc/profile sets 022, removing write perms to group + others.
# Set a more restrictive umask: i.e. no exec perms for others:
# umask 027
# Paranoid: neither group nor others have any perms:
# umask 077

# Functions
#
# Some people use a different file for functions
# if [ -f "${HOME}/.bash_functions" ]; then
#   source "${HOME}/.bash_functions"
# fi
#
# Some example functions:
#
# a) function settitle
# settitle ()
# {
#   echo -ne "\e]2;$@\a\e]1;$@\a";
# }
#
# b) function cd_func
# This function defines a 'cd' replacement function capable of keeping,
# displaying and accessing history of visited directories, up to 10 entries.
# To use it, uncomment it, source this file and try 'cd --'.
# acd_func 1.0.5, 10-nov-2004
# Petar Marinov, http:/geocities.com/h2428, this is public domain
# cd_func ()
# {
#   local x2 the_new_dir adir index
#   local -i cnt
#
#   if [[ $1 ==  "--" ]]; then
#     dirs -v
#     return 0
#   fi
#
#   the_new_dir=$1
#   [[ -z $1 ]] && the_new_dir=$HOME
#
#   if [[ ${the_new_dir:0:1} == '-' ]]; then
#     #
#     # Extract dir N from dirs
#     index=${the_new_dir:1}
#     [[ -z $index ]] && index=1
#     adir=$(dirs +$index)
#     [[ -z $adir ]] && return 1
#     the_new_dir=$adir
#   fi
#
#   #
#   # '~' has to be substituted by ${HOME}
#   [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"
#
#   #
#   # Now change to the new dir and add to the top of the stack
#   pushd "${the_new_dir}" > /dev/null
#   [[ $? -ne 0 ]] && return 1
#   the_new_dir=$(pwd)
#
#   #
#   # Trim down everything beyond 11th entry
#   popd -n +11 2>/dev/null 1>/dev/null
#
#   #
#   # Remove any other occurence of this dir, skipping the top of the stack
#   for ((cnt=1; cnt <= 10; cnt++)); do
#     x2=$(dirs +${cnt} 2>/dev/null)
#     [[ $? -ne 0 ]] && return 0
#     [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
#     if [[ "${x2}" == "${the_new_dir}" ]]; then
#       popd -n +$cnt 2>/dev/null 1>/dev/null
#       cnt=cnt-1
#     fi
#   done
#
#   return 0
# }
#
# alias cd=cd_func
