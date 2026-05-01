return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        -- Install parsers
        --require("nvim-treesitter").install({ "lua", "typescript", "javascript", "markdown", "markdown_inline", "json",
         --   "jsx", "tsx" })

        -- Enable highlighting manually (this is now required!)
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "*",
            callback = function()
                pcall(vim.treesitter.start)
            end,
        })
    end,
}
