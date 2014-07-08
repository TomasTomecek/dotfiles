# common stuff for both shells

[[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh

export PATH=${PATH}:~/.dotfiles/bin:~/.local/bin/

# VARS

# xterm breaks zsh
#export TERM="xterm"
export MC_SKIN=${HOME}/.dotfiles/ext/mc/solarized.ini
export PAGER="/usr/bin/less"
export LESS="-n -r"

# ALIAS

alias ls="ls --color=auto"
alias llt="ls -lht --color=auto"
alias ll="ls -lh --color=auto"
alias lla="ls -lha --color=auto"
alias vR="vim -R"
alias tree="tree -C"
alias less="less -r"
alias vs="vim ./*.spec"
alias gs="git status"
alias gd="git diff"
alias gp="git push"
alias gdw="git diff --color-words"
alias gdc="git diff --color-words --word-diff-regex='[^[:space:]]|([[:alnum:]]|UTF_8_GUARD)+'"
alias gc="git commit --verbose"
alias gpr="git pull --rebase"
alias rpmbc="rpmbuild -bs ./*.spec --define \"_sourcedir .\" --define \"_specdir .\" --define \"_srcrpmdir .\" --define \"_rpmdir .\""
alias t="env TERM=screen-256color tmux -2"
alias htop="TERM=screen htop"

# root aliases
alias monitor="xrandr --auto && xrandr --output LVDS1 --off"
alias laptop="xrandr --auto && xrandr --output HDMI1 --off"
alias pm-suspend="xscreensaver-command -lock ; pm-suspend"

# COLORS
eval `dircolors ~/.dotfiles/ext/dircolors-solarized/dircolors.ansi-universal`

# functions
rpmw () { rpm -qf "$(which ${1})" }
rpmg () { rpm -qa | grep "${1}" }
fn () { find . -iname "${1}" }

