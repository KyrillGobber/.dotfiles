if status is-interactive
    # Commands to run in interactive sessions can go here
    # fish_add_path ~/.cargo/bin
    # fish_add_path ~/.dotnet/tools
    fish_add_path ~/.local/bin
    fish_add_path ~/go/bin
    fish_add_path ~/.turso
    fish_add_path /opt/homebrew/bin
    fish_add_path /opt/homebrew/opt/openjdk/bin

	set -U fish_greeting

    set -x GOOGLE_GEMINI_BASE_URL "https://litellm.gobber.ch"
    set -x GEMINI_API_KEY "sk-O-_o_74W91tvsM118nptvQ"
    set -x GEMINI_MODEL "venice/qwen3-235b"

    set -x ANTHROPIC_BASE_URL "https://litellm.gobber.ch"
    set -x ANTHROPIC_AUTH_TOKEN "sk-O-_o_74W91tvsM118nptvQ"

    set -gx XDG_CONFIG_HOME $HOME/.config

    alias egg='exit'
    alias fabric='fabric-ai'
    bind \cf 'source ~/.dotfiles/config/.local/bin/tmux-sessionizer'
    bind \ce 'source ~/.dotfiles/config/.local/bin/tmux-sessionizer-emineo'
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

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# opencode
fish_add_path /Users/ky/.opencode/bin
