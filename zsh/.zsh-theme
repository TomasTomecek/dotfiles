
if [[ $(whoami) -eq root ]] ; then
    local user='%{$fg[red]%}%n %{$fg[white]%}at %{$fg[green]%}%m%{$reset_color%}'
else
    local user='%{$fg[yellow]%}%n %{$fg[white]%}at %{$fg[green]%}%m%{$reset_color%}'
fi
local pwd='%{$fg[blue]%}%~%{$reset_color%}'
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

# print bell when command ends
PROMPT="%{$(echo "\a")%}${user} ${pwd}$ "
RPROMPT="${jobs_d} ${return_code} ${git_info} ${rvm}"
