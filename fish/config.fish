if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_add_path ~/.tmuxifier/bin
    fish_add_path ~/.nix-profile/bin
    fish_add_path ~/.cargo/bin
    fish_add_path ~/.dotnet/tools
    eval (tmuxifier init - fish)
	set -U fish_greeting
    alias egg='exit'
	starship init fish | source
end
