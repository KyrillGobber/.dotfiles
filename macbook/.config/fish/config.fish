if status is-interactive
    fish_add_path ~/.local/bin

	set -U fish_greeting

    set -gx EDITOR nvim
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

set -l fish_env (dirname (status current-filename))/.env
if test -f $fish_env
    while read -l line
        if test -n "$line"; and not string match -q '#*' -- $line
            set -l kv (string split -m1 '=' -- $line)
            set -gx $kv[1] $kv[2]
        end
    end < $fish_env
end
