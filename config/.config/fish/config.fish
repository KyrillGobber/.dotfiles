if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_add_path ~/.cargo/bin
    fish_add_path ~/.dotnet/tools
    fish_add_path ~/.local/bin
    fish_add_path ~/go/bin
    fish_add_path ~/.turso
	set -U fish_greeting

    set -gx EDITOR nvim
    set -gx VISUAL $EDITOR
    set -gx PACMAN_AUTH run0

    alias egg='exit'
    alias :q='exit'
    alias gw='./gradlew'
    alias dots='cd ~/.dotfiles && nvim'
    alias notes='cd ~/Cloud/Notes && nvim'
    alias eminotes='cd ~/Cloud/Notes/jobs/emineo && nvim'
    alias wgup='sudo wg-quick up peer_Fedaykin'
    alias wgdown='sudo wg-quick down peer_Fedaykin'
    # Alias for turning lid close sleep off, check "jobs" for the running job and kill with "kill %1" or just close terminal
    alias sleepoff='systemd-inhibit --what=handle-lid-switch --why="just blank the screen" sleep infinity &'

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

set -l fish_env (dirname (status current-filename))/.env
if test -f $fish_env
    while read -l line
        if test -n "$line"; and not string match -q '#*' -- $line
            set -l kv (string split -m1 '=' -- $line)
            set -gx $kv[1] $kv[2]
        end
    end < $fish_env
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Added by the Hunk installer (https://hunk.dev)
fish_add_path '/~/.hunk/bin'

# kilo
fish_add_path ~/.kilo/bin

fish_add_path ~/.opencode/bin
