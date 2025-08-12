return {
    "zbirenbaum/copilot.lua",
    enabled = true,
    config = function()
        require('copilot').setup({
            panel = {
                enabled = true,
                auto_refresh = false,
                keymap = {
                    jump_prev = "[[",
                    jump_next = "]]",
                    accept = "<CR>",
                    refresh = "gr",
                    open = "<M-CR>"
                },
                layout = {
                    position = "bottom", -- | top | left | right | horizontal | vertical
                    ratio = 0.4
                },
            },
            suggestion = {
                enabled = true,
                auto_trigger = true,
                hide_during_completion = true,
                debounce = 75,
                trigger_on_accept = true,
                keymap = {
                    accept = "<Tab>",
                    accept_word = "<C-l>",
                    accept_line = false,
                    next = "<C-j>",
                    prev = "<C-k>",
                    dismiss = "<C-]>",
                },
            },
            filetypes = {
                ["."] = true,
            },
            auth_provider_url = nil, -- URL to authentication provider, if not "https://github.com/"
            copilot_node_command = 'node', -- Node.js version must be > 20
            workspace_folders = {},
            copilot_model = "",
            root_dir = function()
                return vim.fs.dirname(vim.fs.find(".git", { upward = true })[1])
            end,
            server = {
                type = "nodejs", -- "nodejs" | "binary"
                custom_server_filepath = nil,
            },
            server_opts_overrides = {},
        })
    end
}
