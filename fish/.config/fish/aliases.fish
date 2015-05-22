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
alias pacin "pacaur -S"
alias pacup "pacaur -Syu"
alias pacrem "sudo pacaur -Rns"
alias pacsearch "pacaur -Ss"
alias .. "cd .."
alias mpv "mpv --really-quiet"
alias extract "dtrx"
