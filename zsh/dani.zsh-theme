# Yay! High voltage and arrows!

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}?%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

#source ~/kube-prompt.sh

PROMPT='$(_user_host)%{$fg[cyan]%}%1~%{$reset_color%}%{$fg[red]%}|%{$reset_color%}$(git_prompt_info)%{$fg[cyan]%}=>%{$reset_color%} '
#PROMPT='$(_user_host)$(_kube_ps1)%{$fg[cyan]%}%2~%{$reset_color%}%{$fg[red]%}|%{$reset_color%}$(git_prompt_info)%{$fg[cyan]%}=>%{$reset_color%} '
RPROMPT='[%*]' #añadido por mi


function _user_host() {
  echo "%{$fg[red]%}%n%{$reset_color%}:"
}

function _kube_ps1()
{
    # Get current context
    CONTEXT=$(cat ~/.kube/config | grep "current-context:" | sed "s/current-context: //")

    if [ -n "$CONTEXT" ]; then
        echo "(k8s: ${CONTEXT})"
    fi
}
