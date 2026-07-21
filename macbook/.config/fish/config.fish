if status is-interactive
    fish_add_path ~/.local/bin
    fish_add_path ~/.turso

	set -U fish_greeting

    set -gx EDITOR nvim
    set -gx VISUAL $EDITOR

    alias egg='exit'
    alias :q='exit'
    alias gw='./gradlew'
    alias dots='cd ~/.dotfiles && nvim'
    alias notes='cd ~/Cloud/Notes && nvim'
    alias eminotes='cd ~/Cloud/Notes/jobs/emineo && nvim'

    bind \cf 'source ~/.dotfiles/config/.local/bin/tmux-sessionizer'
    bind \ce 'source ~/.dotfiles/config/.local/bin/tmux-sessionizer_e'
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
