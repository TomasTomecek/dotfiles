autoload -U colors
colors
# Allow for functions in the prompt.
setopt PROMPT_SUBST

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

local jobs_d='%(1j.%{$fg[white]%}J %j %{$reset_color%}.)'
local return_code='%(?..%{$fg[red]%}%? ↵%{$reset_color%})'
local path_info='$(show_path)'
local show_git_stats='$(git-stats)'

print_loaded_project(){
    local prj=""
    if [[ -n "${SOURCED_PROJECT}" ]] ; then
        prj="[${SOURCED_PROJECT}] "
    fi
    echo "${prj}"
}
local loaded_project='$(print_loaded_project)'

# print bell when command ends
PROMPT="%{$(echo "\a")%}${loaded_project}${user} ${path_info} "
RPROMPT="${jobs_d} ${return_code} ${show_git_stats}"
