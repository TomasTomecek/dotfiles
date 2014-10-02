if [[ $(whoami) == root ]] ; then
    local user='%{$fg[red]%}%n %{$fg[white]%}at %{$fg[green]%}%m%{$reset_color%}'
else
    local user='%{$fg[cyan]%}%n %{$fg[white]%}at %{$fg[green]%}%m%{$reset_color%}'
fi

show_path(){
  local pwd="${PWD/#$HOME/~}"
  if [[ "$pwd" == (#m)[/~] ]]; then
    _prompt_pwd="$MATCH"
    unset MATCH
  else
    #_prompt_pwd="${${${(@j:/:M)${(@s:/:)pwd}##.#?}:h}%/}/${pwd:t}"
    #_prompt_pwd="${${(@j:/:M)${(@s:/:)pwd}##.#?}:h}/${pwd:t}"
    _prompt_pwd=$(print $PWD | sed -e "s|^$HOME|~|" -e 's|\(\.\{0,1\}[^/]\)[^/]*/|\1/|g')
  fi
  local c_prompt_pwd="%{$fg[blue]%}${_prompt_pwd}%{$reset_color%}"
  echo "${c_prompt_pwd}"
}
# lame path
# local p='%{$fg[blue]%}%~%{$reset_color%}'

local rvm=''
if which rvm-prompt &> /dev/null; then
  rvm='%{$fg[green]%}‹$(rvm-prompt i v g)›%{$reset_color%}'
else
  if which rbenv &> /dev/null; then
    rvm='%{$fg[green]%}‹$(rbenv version | sed -e "s/ (set.*$//")›%{$reset_color%}'
  fi
fi
local jobs_d='%(1j.%{$fg[white]%}J %j %{$reset_color%}.)'
local return_code='%(?..%{$fg[red]%}%? ↵%{$reset_color%})'
local git_info='$(git_super_status)'
local path_info='$(show_path)'

# print bell when command ends
PROMPT="%{$(echo "\a")%}${user} ${path_info} "
RPROMPT="${jobs_d} ${return_code} ${git_info}"
