if status is-interactive
    fish_add_path ~/.local/bin

	set -U fish_greeting

    set -gx EDITOR vim
    set -gx VISUAL $EDITOR

    alias egg='exit'
    bind \cf 'source ~/.dotfiles/config/.local/bin/tmux-sessionizer'
    fzf --fish | source
	starship init fish | source
end

function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

# opencode
fish_add_path /Users/ky/.opencode/bin
