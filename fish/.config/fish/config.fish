# Load aliases
if [ -f $HOME/.config/fish/aliases.fish ]
	source $HOME/.config/fish/aliases.fish
end

function fish_title; end

set -U fish_greeting ""  # Hide fish greeting
set -Ux fish_user_paths ~/.dotfiles/bin ~/.local/bin  # Set PATH
set -gx EDITOR nvim
set -gx BROWSER google-chrome-stable
set -gx FZF_DEFAULT_COMMAND \
	"ag --follow --nocolor --nogroup --hidden -g '' --path-to-agignore ~/.agignore"

rvm default
