# Load oh-my-fish
# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Theme
set fish_theme cmorrell.com

# All built-in plugins can be found at ~/.oh-my-fish/plugins/
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
# Enable plugins by adding their name separated by a space to the line below.
set fish_plugins balias theme tmux xdg

# Path to your custom folder (default path is ~/.oh-my-fish/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish

# Load aliases
if [ -f $HOME/.config/fish/aliases.fish ]
	source $HOME/.config/fish/aliases.fish
end


set -U fish_greeting ""  # Hide fish greeting
set -U fish_user_paths ~/.dotfiles/bin ~/.local/bin  # Set PATH
set -gx EDITOR emacsclient -c -a emacs

# Autostart tmux
tmux
