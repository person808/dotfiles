# Remove welcome message
set -U fish_greeting ""

# Load aliases
if [ -f $HOME/.config/fish/aliases.fish ]
	source $HOME/.config/fish/aliases.fish
end

# Add ~/.dotfiles/bin/ to path
set -U fish_user_paths $fish_user_paths ~/.dotfiles/bin

# Use 256 colors
set TERM "gnome-256color"
