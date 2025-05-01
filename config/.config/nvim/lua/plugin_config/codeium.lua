return {
    "Exafunction/codeium.nvim",
    enabled = false,
    opts = {
        -- Optionally disable cmp source if using virtual text only
        enable_cmp_source = true,
        virtual_text = {
            enabled = true,

            -- These are the defaults

            -- Set to true if you never want completions to be shown automatically.
            manual = false,
            -- How long to wait (in ms) before requesting completions after typing stops.
            idle_delay = 75,
            -- Priority of the virtual text. This usually ensures that the completions appear on top of
            -- other plugins that also add virtual text, such as LSP inlay hints, but can be modified if
            -- desired.
            virtual_text_priority = 65535,
            -- Set to false to disable all key bindings for managing completions.
            map_keys = true,
            -- Key bindings for managing completions in virtual text mode.
            key_bindings = {
                -- Accept the current completion.
                accept = "<Tab>",
                -- Accept the next word.
                accept_word = "<C-L>",
                -- Accept the next line.
                accept_line = "",
                -- Clear the virtual text.
                clear = "<C-H>",
                -- Cycle to the next completion.
                next = "<C-J>",
                -- Cycle to the previous completion.
                prev = "<C-K>",
            },
        },
    }
}
