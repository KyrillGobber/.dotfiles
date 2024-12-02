return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip",
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

            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "ts_ls",
                    "tailwindcss",
                    "svelte"
                }
            })

            local lspconfig = require('lspconfig')
            local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

            require('mason-lspconfig').setup_handlers({
                function(server_name)
                    lspconfig[server_name].setup({
                        capabilities = lsp_capabilities,
                    })
                end,
            })

            require('cmp').setup({
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
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
                    { name = 'vsnip' },
                    { name = 'buffer' },
                    { name = 'codeium' },
                },
            })
        end
    }
}
