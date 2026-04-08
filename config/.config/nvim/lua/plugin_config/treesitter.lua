return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        -- Install parsers
        require("nvim-treesitter").install({ "lua", "typescript", "markdown", "markdown_inline" })

        -- Enable highlighting manually (this is now required!)
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "*",
            callback = function()
                pcall(vim.treesitter.start)
            end,
        })
    end,
}
