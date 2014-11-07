# Global Aliases

function sudo
    if test "$argv" = !!
        eval command sudo $history[1]
    else
        command sudo $argv
    end
end

alias ls "ls -CF --group-directories-first --color"
alias df "df -h"
alias free "free -mt"
alias wget "wget -c"
alias top "htop"
alias pacin "packer -S"
alias pacup "packer -Syu"
alias pacrem "sudo pacman -Rns"
alias pacsearch "packer -Ss"
alias .. "cd .."
