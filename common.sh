# common stuff for both shells

[[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh

# VARS

# xterm breaks zsh
#export TERM="xterm"
export MC_SKIN=${HOME}/.dotfiles/ext/mc/solarized.ini
export PAGER="/usr/bin/less"

# ALIAS

alias llt="ls -lht --color=auto"
alias ll="ls -lh --color=auto"
alias lla="ls -lha --color=auto"
alias vR="vim -R"
alias tree="tree -C"
alias less="less -r"
alias vs="vim ./*.spec"
alias gs="git status"
alias gd="git diff"
alias gc="git commit --verbose"
alias gpr="git pull --rebase"
alias rpmbc="rpmbuild -bs ./*.spec --define \"_sourcedir .\" --define \"_specdir .\" --define \"_srcrpmdir .\" --define \"_rpmdir .\""
alias t="env TERM=screen-256color tmux -2"
#alias t="exec tmux -2"
alias htop="TERM=screen htop"

# COLORS
eval `dircolors ~/.dotfiles/ext/dircolors-solarized/dircolors.ansi-universal`

