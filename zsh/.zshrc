#source /etc/profile
source ~/.zsh-theme

source ~/.dotfiles/common.sh

# separate words
autoload -U select-word-style
select-word-style bash

# completion initialization
autoload -U compinit
compinit -u

# COMPLETION
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
# case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
# Errors format
zstyle ':completion:*:corrections' format '%B%d (errors %e)%b'

# generate descriptions with magic.
zstyle ':completion:*' auto-description 'specify: %d'

# Don't prompt for a huge list, page it!
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# Don't prompt for a huge list, menu it!
zstyle ':completion:*:default' menu 'select=0'

# Have the newer files last so I see them first
zstyle ':completion:*' file-sort modification reverse

# color code completion!!!!  Wohoo!
zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"

unsetopt nomatch  # zsh: no match found
setopt complete_in_word
setopt always_to_end
setopt always_last_prompt
# setopt correctall

# include dotfiles in globbing
setopt GLOB_DOTS

# Separate man page sections.  Neat.
zstyle ':completion:*:manuals' separate-sections true

# we want '#' during interactive session!
setopt interactivecomments

export READNULLCMD=less

set -o emacs
bindkey -e

export HISTSIZE=200000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt no_share_history
# don't use ctrl+q ctrl+s
unsetopt flowcontrol

# source .env if there is one
autoload -U add-zsh-hook
source_env() {
    nested() {
        local CURRENT_DIR="$(realpath ${1})"
        if [[ "${CURRENT_DIR}" = "/" ]] ; then
            kill -INT $$
        fi
        local ENV_PATH="${CURRENT_DIR}/.env"
        if [[ -f ${ENV_PATH} && -r ${ENV_PATH} ]]; then
            source ${ENV_PATH}
            # TODO: create hook when entering git repo
            ( git fetch --all & disown; ) 2>/dev/null >/dev/null
        else
            nested "${CURRENT_DIR}/../"
        fi
    }
    nested "."
}
add-zsh-hook chpwd source_env

## Key bindings
#create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# ^left ^right
bindkey ';5D' emacs-backward-word
bindkey ';5C' emacs-forward-word
bindkey '5D' emacs-backward-word
bindkey '5C' emacs-forward-word

bindkey ^U backward-kill-line

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# setup key accordingly
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-beginning-search
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-beginning-search
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
function zle-line-init () {
    echoti smkx
}
function zle-line-finish () {
    echoti rmkx
}
zle -N zle-line-init
zle -N zle-line-finish

# Colored man pages: http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
# Less Colors for Man Pages
# export LESS_TERMCAP_mb=$'\E[01;31m'     # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[7;33;40m'     # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

# RUNTH...=ls / zsh -i
if [[ -n ${RUNTHISCOMMAND} ]] then
   eval ${RUNTHISCOMMAND}
fi
