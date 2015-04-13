function sudo
    if test "$argv" = !!
        eval command sudo $history[1]
    else
        command sudo $argv
    end
end

balias ls "ls -CF --group-directories-first --color"
balias df "df -h"
balias free "free -mt"
balias wget "wget -c"
balias top "htop"
balias pacin "pacaur -S"
balias pacup "pacaur -Syu"
balias pacrem "sudo pacaur -Rns"
balias pacsearch "pacaur -Ss"
balias .. "cd .."
balias mpv "mpv --really-quiet"
