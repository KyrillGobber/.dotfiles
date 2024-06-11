if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_add_path ~/.cargo/bin
    fish_add_path ~/.dotnet/tools
    fish_add_path ~/.local/bin
	set -U fish_greeting
    alias egg='exit'
    bind \cf 'source ~/.dotfiles/.local/bin/tmux-sessionizer'
	starship init fish | source
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
