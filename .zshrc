if uwsm check may-start && uwsm select; then
    exec uwsm start default
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/${USER}/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '

setopt PROMPT_SUBST
PS1='[%F{blue}%n%f %1~] %F{red}${vcs_info_msg_0_}%f~ '

function mkcd {
    mkdir -p $1 
    cd $1
}

function restart_app {
    pkill $1
    $@ & disown
}

function grub-update {
    grub-install --target=x86_64-efi --efi-directory=/boot 
    grub-mkconfig -o /boot/grub/grub.cfg
}

alias ls='ls --color=auto'
alias la='ls -a'
alias grep='grep --color=auto'
alias rm='rm -i'
alias matlab='matlab -nodesktop -nosplash'
alias pacown='pacman -Qo'

bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[3~' delete-char

export PATH="$HOME/.local/share/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/usr/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "/usr/etc/profile.d/conda.sh" ]; then
#        . "/usr/etc/profile.d/conda.sh"
#    else
#        export PATH="/usr/bin:$PATH"
#    fi
#fi
#unset __conda_setup
# <<< conda initialize <<<
export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=1
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /home/arathgeb/.config/.dart-cli-completion/zsh-config.zsh ]] && . /home/arathgeb/.config/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

