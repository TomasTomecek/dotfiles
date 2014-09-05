# If not running interactively, don't do anything
[[ $- == *i* ]] || return

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

source ~/.dotfiles/common.sh

BOLD="\[\033[1m\]"
RED="\[\033[1;31m\]"
GREEN="\[\e[32;1m\]"
BLUE="\[\e[34;1m\]"
PURPLE="\[\e[35;1m\]"
OFF="\[\033[m\]"
CYAN="\[\e[1;36m\]"

#SOURCE git-prompt.sh
source /usr/share/git-core/contrib/completion/git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUPSTREAM="verbose"
GIT_PS1_SHOWCOLORHINTS=true

export HISTSIZE=200000
export HISTFILESIZE=200000

# functions

function susp {
  if [ -n "$1" ] ; then
    echo 'pm-suspend' | at now + $1 minutes;
  else
    echo -e "Usage\n$0 <delay in minutes>";
  fi
}

function enabled {
    for SERVICE in `systemctl -t service --full --all list-units | awk '{
    print $1 }'`; do
        echo -n "$SERVICE:  "
        if systemctl is-enabled $SERVICE >/dev/null; then
            echo ENABLED
        else
            echo disabled
        fi
    done 2>/dev/null
}

function exitstatus {
    EXITSTATUS="$?"
    JOBS_COUNT=$(jobs | wc -l)

    PS1=""

    if [ "$UID" -eq 0 ] ; then
        PS1=${PS1}"${RED}\u${OFF}@"
    fi
    PS1=${PS1}"${PURPLE}\h${OFF}"

    PS1=${PS1}" ${BOLD}\w${OFF}$(__git_ps1 " (%s)")"

    if [ "${EXITSTATUS}" -ne 0 ] ; then
        PS1=${PS1}"${RED} ${EXITSTATUS}${OFF}"
    fi
    if [ "${JOBS_COUNT}" -ne 0 ] ; then
        PS1=${PS1}"${CYAN} ${JOBS_COUNT}${OFF}"
    fi
    PS1=${PS1}" \$ "
}
export PROMPT_COMMAND=exitstatus

complete -F _systemctl sc
