# common stuff for both shells

export EDITOR="vim"

# VARS

# xterm breaks zsh
#export TERM="xterm"
export MC_SKIN=${HOME}/.dotfiles/ext/mc/solarized.ini
export PAGER="/usr/bin/less"
export LESS="-n -r -X"
# <3 symlinks
export AUTOJUMP_KEEP_SYMLINKS=1
[[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh
[[ -s ~/.dotfiles/ext/dotfiles-secret/common.sh ]] && source ~/.dotfiles/ext/dotfiles-secret/common.sh
export GOPATH="${HOME}/dev/go:${HOME}/go:/usr/share/gocode/"
export GOBIN="${HOME}/dev/go/bin"

export PATH=~/.dotfiles/bin:~/.dotfiles/sbin:~/.local/bin/:${GOBIN}:${PATH}
export PYTHONPATH=~/.local/lib/python3.7/site-packages/

export PYTHONDONTWRITEBYTECODE="fuck-yes"

test -f /etc/pki/tls/certs/ca-bundle.crt && export REQUESTS_CA_BUNDLE=/etc/pki/tls/certs/ca-bundle.crt

# gpg wants this
export GPG_TTY=$(tty)

# ALIAS

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../../"
alias .....="cd ../../../.."

alias ls="ls --color=auto"
alias llt="ls -lht --color=auto"
alias ll="ls -lh --color=auto"
alias lla="ls -lha --color=auto"
alias vR="vim -R"
alias tree="tree -C"
alias rsync="rsync -Pra"  # progress, recursive, archive; no compress - it slows things down
alias dd="dd status=progress"
alias curl="curl -L"
alias diff="diff --color=always -u"
alias strace="strace -s512 -f -yy"

# vim aliases/functions
v() {
  if [ -f /usr/bin/nvim ] ; then
    /usr/bin/nvim ${@} ;
  elif [ -f /usr/bin/vimx ] ; then
    /usr/bin/vimx ${@} ;
  else
    /usr/bin/vim ${@} ;
  fi
}
alias vs="vim ./*.spec"
alias vm="vim Makefile"
alias vd="vim Dockerfile"
alias vr="vim README*"
alias vy="vim ./*.y*ml"
alias vv="vim ./Vagrantfile"
# halp!!1!
alias h="less ~/.dotfiles/mysterious-keybinds/README.md ~/.dotfiles/ext/dotfiles-secret/myst.md"

alias m="make"
alias sem="sudo -E make"

alias a=ansible-playbook
alias ab=ansible-bender

alias sd="sudo su -"

alias pa=packit
alias u=upsint
alias us="upsint status"
alias uc="upsint create-pr"
alias uco="upsint checkout-pr"
alias ul="upsint list-prs"
# git aliases
alias g="git"
alias gaf="git add -u && git commit -m f"
alias gs="git status --show-stash"
alias gst="git stash"
alias gsp="git stash pop"
alias gd="git diff"
alias gp="git push -u"
alias gpf="git push -f"
alias gf="git fetch"
alias gdw="git diff --color-words"
alias gdc="git diff --color-words --word-diff-regex='[^[:space:]]|([[:alnum:]]|UTF_8_GUARD)+'"
alias gc="git commit --verbose"
alias gcS="git commit --verbose -S"
alias gca="git commit --verbose --amend"
alias gpr="git pull --rebase --recurse-submodules"
# Check if main exists and use instead of master
# stolen from ohmyzsh: https://github.com/ohmyzsh/ohmyzsh/blob/4dce175e0e4a678b7f93be80c64247c8f5fbab3e/plugins/git/git.plugin.zsh#L31
function git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local ref
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk}; do
    if command git show-ref -q --verify $ref; then
      echo ${ref:t}
      return
    fi
  done
  echo master
}
grhu() { local main=$(git_main_branch); git reset --hard upstream/$main || git reset --hard origin/$main; }
gpum() { local main=$(git_main_branch); git pull --rebase upstream $main || git pull --rebase origin $main; }
gb() { local old_ref=$(git rev-parse HEAD) && git checkout -B $@ && grhu && git rebase $old_ref; gpum; }
gm() { git checkout $(git_main_branch); }
gpom(){ git pull --rebase origin $(git_main_branch); }
alias gau="git add --verbose --update -- ."
alias gaa="git add --verbose --all -- ."
alias gr="git rebase"
alias gri="git rebase -i"
alias grc="git rebase --continue"
alias grab="git rebase --abort"
alias grh="git reset --hard"
alias grho="git reset --hard origin/master"
alias gba="git branch --all"
alias grau="git remote add upstream"
alias grao="git remote add origin"
alias grs="git remote set-url"
alias gra="git remote add"
alias grv="git remote -v"
alias gcl="git clone"
alias gfa="git fetch --all"
alias gfu="git fetch upstream"
alias gsp="git submodule foreach git pull --rebase origin master"
gi() { git init . && git add . && git commit -m ${1:-init} >/dev/null; }
alias e="egrep"
gsr() { git rev-list --all | xargs git grep ${1}; }

gh-f() {
  gh-fork $1 && cd "$1"
  # cd $(echo $1 | awk '{split($0,a,"/"); print a[2]}')
}

alias t="env TERM=screen-256color tmux -2"
alias htop="TERM=screen htop"
alias mock6="mock -r rhel-6-x86_64"
alias mock7="mock -r rhel-7-x86_64"
alias mock20="mock -r fedora-20-x86_64"
alias mockr="mock -r fedora-rawhide-x86_64"
alias sc="systemctl"
alias scu="systemctl --user"
sr () { systemctl restart ${@} ; systemctl --no-pager --full status ${@} }
sta () { systemctl start ${@} ; systemctl --no-pager --full status ${@} }
alias s="systemctl --no-pager --full status"
alias stp="systemctl stop"
alias ju="journalctl --pager-end"
alias sysdig="docker run -it --rm --privileged -v /:/host:ro -e TERM=$TERM sysdig/sysdig csysdig"

alias b=buildah
alias c="docker-compose"
alias d="docker"
alias p="podman"
alias sp="sudo podman"
alias di="docker images"
alias pi="podman images"
alias spi="sudo podman images"
alias dp="docker ps"
alias dpa="docker ps -a"
alias pp="podman ps -a"
alias spp="sudo podman ps -a"
alias drt="docker run --rm -ti"
alias prt="podman run --rm -ti"
alias sprt="sudo podman run --rm -ti"
alias drtb="docker run --rm -ti -v $(pwd):/src:Z -v /run/docker.sock:/run/docker.sock registry.fedoraproject.org/fedora:33 bash"
alias prtb="podman run --rm -ti -v $(pwd):/src registry.fedoraproject.org/fedora:33 bash"
alias sprtb="sudo podman run --rm -ti -v $(pwd):/src:Z registry.fedoraproject.org/fedora:31 bash"
alias det="docker exec -ti"
alias pet="podman exec -ti"
drm() { docker rm -f $(docker ps -a -q) }
drmi() { docker rmi $(docker images -a | grep "^<none>" | awk '{print $3}') }
prmi() { podman rmi $(podman images -a | grep "^<none>" | awk '{print $3}') }
prmi-filter() { podman rmi $(podman images | grep ${1} | awk '{print $3}') }
prm-filter() { podman rm $(podman ps -a | grep ${1} | awk '{print $1}') }
docker-get-ip() { docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $1; }
alias sen="sen --yolo"
alias find-todo="egrep -R '(TODO|FIXME)' ."

dig() { /usr/bin/dig $@ +nostats +nocomments +nocmd; }

alias o="oc"
alias os="oc status"
alias oga="oc get all"
alias wo="watch oc get all"
alias od="oc describe"
alias og="oc get"

alias pt="pytest-3 -vv --showlocals"
alias prcal="pre-commit run --all-files"

# root aliases
alias monitor="xrandr --auto && xrandr --output LVDS1 --off"
alias pm-suspend="xscreensaver-command -lock ; pm-suspend"

# https://blog.cryptomilk.org/2010/12/23/gdb-backtrace-to-file/
alias bt='echo 0 | gdb -batch-silent -ex "run" -ex "set logging overwrite on" -ex "set logging file gdb.bt" -ex "set logging on" -ex "set pagination off" -ex "handle SIG33 pass nostop noprint" -ex "echo backtrace:\n" -ex "backtrace full" -ex "echo \n\nregisters:\n" -ex "info registers" -ex "echo \n\ncurrent instructions:\n" -ex "x/16i \$pc" -ex "echo \n\nthreads backtrace:\n" -ex "thread apply all backtrace" -ex "set logging off" -ex "quit" --args'

# COLORS
eval `dircolors ~/.dotfiles/ext/dircolors-solarized/dircolors.ansi-universal`

# functions
rpmw () { rpm -qf "$(which ${1})" ; }
rpmg () {
  # will you hate me for doing this?
  if which rpm >/dev/null; then
    rpm -qa | grep -i "${1}"
  elif which equery >/dev/null; then
    equery '*' | grep -i "${1}"
  else
    echo "Unknown distribution."
  fi
}
rpmqlg () { rpm -ql $1 | grep $2; }
llg () { ls -lhat | grep -i "${1}" ; }
psg () { ps aux | grep -i "${1}" ; }
gg () { grep -inR --exclude-dir=".git" --exclude-dir=".tox" --exclude-dir=".mypy_cache" --color=always "${1}" . ; }

ff () { find . -iname "*${1}*" ; }
laptop () {
    xrandr --auto
    for i in {1..3}
    do
        # we dont care if the output doesn't exist
        xrandr --output VGA${i} --off --output HDMI${i} --off &>/dev/null
    done
}
rpmb () {
    rpmbuild ./*.spec --define "_sourcedir ${PWD}" \
                      --define "_specdir ${PWD}" \
                      --define "_builddir ${PWD}" \
                      --define "_srcrpmdir ${PWD}" \
                      --define "_rpmdir ${PWD}" \
                      ${@}
}
which-rpm-contains () {
    echo "Searching for '${2}' in rpms matching '${1}'"
    for rpm in `yum search all | egrep "${1}" | awk '{ print $1 }'`
    do
        file_list=$(rpm -ql ${rpm} | egrep "${2}")
        [[ ${?} == 0 ]] && echo -n "'${rpm}' contains '${2}':\n${file_list}"
    done
}
# Create a directory and cd into it
mcd() {
    mkdir "${1}" && cd "${1}"
}
nicemount() { (echo "DEVICE PATH TYPE FLAGS" && mount | awk '$2=$4="";1') | column -t; }

# show random aliases, as a reminder
# alias | shuf -n 5

# "disable" ctrl-{s,q}
stty start '^-' stop '^-'

new-oc-cluster() {
  local data_path="$HOME/openshift.local.clusterup"
  oc cluster down || :
  sudo umount $(sudo find $data_path) >/dev/null
  sudo rm -rf $data_path
  oc cluster --base-dir=$data_path up --enable="-centos-imagestreams,-sample-templates,persistent-volumes,registry,router,web-console"
  oc login -u developer -p developer https://localhost:8443
}
