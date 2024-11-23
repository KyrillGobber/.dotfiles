-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    --Themes -----
    "navarasu/onedark.nvim",
    "rebelot/kanagawa.nvim",
    { "rose-pine/neovim", name = "rose-pine" },
    "folke/zen-mode.nvim",
    -- Core -----
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.4",
        dependencies = { { "nvim-lua/plenary.nvim" } },
    },
    "nvim-treesitter/nvim-treesitter",
    -- LSP -----
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    -- Autocompletion
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-vsnip",
    "hrsh7th/vim-vsnip",

    "stevearc/conform.nvim",
    "diepm/vim-rest-console",
    {
        "mikavilpas/yazi.nvim",
        event = "VeryLazy",
        keys = {
            -- 👇 in this section, choose your own keymappings!
            {
                "<leader>-",
                "<cmd>Yazi<cr>",
                desc = "Open yazi at the current file",
            },
            {
                -- Open in the current working directory
                "<leader>cw",
                "<cmd>Yazi cwd<cr>",
                desc = "Open the file manager in nvim's working directory",
            },
            {
                -- NOTE: this requires a version of yazi that includes
                -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
                "<c-up>",
                "<cmd>Yazi toggle<cr>",
                desc = "Resume the last yazi session",
            },
        },
        opts = {
            -- if you want to open yazi instead of netrw, see below for more info
            open_for_directories = false,
            keymaps = {
                show_help = "<f1>",
            },
        },
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {},
        -- stylua: ignore
        keys = {
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons", opt = true },
    },
    "tpope/vim-commentary",
    "tpope/vim-fugitive",
    "mhinz/vim-signify",
    "nvim-lua/popup.nvim",
    "rmagatti/auto-session",
    -- Check this out soon: "ThePrimeagen/refactoring.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    {
        "dimfeld/codeium.nvim",
        branch = "virtual-text"
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    },
    -- Sometimes need, sometimes no
    -- DB Explorer -----
    -- {
    -- 	"kndndrj/nvim-dbee",
    -- 	dependencies = {
    -- 		"MunifTanjim/nui.nvim",
    -- 	},
    -- 	build = function()
    -- 		-- Install tries to automatically detect the install method.
    -- 		-- if it fails, try calling it with one of these parameters:
    -- 		--    "curl", "wget", "bitsadmin", "go"
    -- 		require("dbee").install()
    -- 	end,
    -- 	config = function()
    -- 		require("dbee").setup(--[[optional config]])
    -- 	end,
    -- },
}

local opts = {}

require("lazy").setup({
    plugins,
    opts,
})
