return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)

            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function()
                    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
                    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
                    vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
                    vim.keymap.set('n', '<space>p', function()
                        vim.lsp.buf.format { async = true }
                    end)
                end
            })

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            vim.lsp.config("*", {
                capabilities = capabilities,
            })

            vim.lsp.enable({
                "ts_ls",
                "angularls",
                "tailwindcss",
                "gopls",
                "lua_ls",
            })

            require('cmp').setup({
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },
                mapping = {
                    ['<C-p>'] = require('cmp').mapping.select_prev_item(),
                    ['<C-n>'] = require('cmp').mapping.select_next_item(),
                    ['<C-Space>'] = require('cmp').mapping.complete(),
                    ['<C-e>'] = require('cmp').mapping.close(),
                    ['<CR>'] = require('cmp').mapping.confirm({
                        behavior = require('cmp').ConfirmBehavior.Replace,
                        select = true,
                    }),
                },
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'buffer' },
                    { name = 'codeium' },
                    { name = 'codecompanion' },
                    { name = 'path' },
                },
            })
        end
    }
}
