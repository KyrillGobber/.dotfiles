-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
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
		"ggandor/leap.nvim",
		dependencies = { { "tpope/vim-repeat" } },
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
	"ThePrimeagen/refactoring.nvim",
	"nvim-telescope/telescope-ui-select.nvim",
	-- {
	--     "TabbyML/vim-tabby",
	--     config = function()
	--         vim.g.tabby_keybinding_accept = "<Tab>"
	--     end,
	-- },
	-- Remove the `use` here if you're using folke/lazy.nvim.
	-- Codeium
	{
		"dimfeld/codeium.nvim",
        branch = "virtual-text"
	},
	-- {
	--     'Exafunction/codeium.vim',
	--     config = function()
	--         vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](1) end,
	--             { expr = true, silent = true })
	--         vim.keymap.set('i', '<c-.>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
	--             { expr = true, silent = true })
	--         vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
	--         vim.keymap.set('n', '<leader>c', function() return vim.fn['codeium#Chat']() end, { expr = true, silent = true })
	--     end
	-- },
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

	-- markdown preview
	-- {
	-- 	"toppair/peek.nvim",
	-- 	build = "deno task --quiet build:fast",
	-- 	config = function()
	-- 		require("peek").setup({
	-- 			auto_load = true, -- whether to automatically load preview when
	-- 			-- entering another markdown buffer
	-- 			close_on_bdelete = true, -- close preview window on buffer delete

	-- 			syntax = true, -- enable syntax highlighting, affects performance

	-- 			theme = "light", -- 'dark' or 'light'

	-- 			update_on_change = true,

	-- 			app = "browser", -- 'webview', 'browser', string or a table of strings
	-- 			-- explained below

	-- 			filetype = { "markdown" }, -- list of filetypes to recognize as markdown

	-- 			-- relevant if update_on_change is true
	-- 			throttle_at = 200000, -- start throttling when file exceeds this
	-- 			-- amount of bytes in size
	-- 			throttle_time = "auto", -- minimum amount of time in milliseconds
	-- 		})
	-- 		vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
	-- 		vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
	-- 	end,
	-- },
}

local opts = {}

require("lazy").setup({
	plugins,
	opts,
})
