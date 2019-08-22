# Load aliases
if [ -f $HOME/.config/fish/aliases.fish ]
	source $HOME/.config/fish/aliases.fish
end

function fish_title; end

set -U fish_greeting ""  # Hide fish greeting
# Set PATH
set -gx fish_user_paths ~/.dotfiles/bin ~/.local/bin ~/Projects/flutter/bin/
set -gx EDITOR nvim
set -gx BROWSER google-chrome-stable
set -gx FZF_DEFAULT_COMMAND  'rg --files --hidden'

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

