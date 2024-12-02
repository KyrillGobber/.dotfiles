return {
    "stevearc/conform.nvim",
    keys = {
        {
            "<leader>P",
            function()
                require("conform").format({
                    lsp_fallback = true,
                    async = false,
                })
            end,
            desc = "Format file or range (in visual mode)"
        },
    },
    opts = {
        formatters_by_ft = {
            javascript = { "prettier" },
            typescript = { "prettier" },
            javascriptreact = { "prettier" },
            typescriptreact = { "prettier" },
            svelte = { "prettier" },
            css = { "prettier" },
            html = { "prettier" },
            json = { "prettier" },
            yaml = { "prettier" },
            markdown = { "prettier" },
            graphql = { "prettier" },
            lua = { "stylua" },
            go = { "gofumpt" },
        },
    },
}
