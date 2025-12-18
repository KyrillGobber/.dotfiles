return {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
        win_options = {
            -- Window options to use that change between rendered and raw view.

            -- @see :h 'conceallevel'
            conceallevel = {
                -- Used when not being rendered, get user setting.
                default = 0,
                -- Used when being rendered, concealed text is completely hidden.
                rendered = 3,
            },
        },
    },
    ft = { "markdown", "codecompanion" }
}
