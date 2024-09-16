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
	--    --Themes -----
	"navarasu/onedark.nvim",
	"rebelot/kanagawa.nvim",
	--    -- Core -----
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
	-- DB Explorer -----
	-- use {
	--     "kndndrj/nvim-dbee",
	--     requires = {
	--         "MunifTanjim/nui.nvim",
	--     },
	--     run = function()
	--         -- Install tries to automatically detect the install method.
	--         -- if it fails, try calling it with one of these parameters:
	--         --    "curl", "wget", "bitsadmin", "go"
	--         require("dbee").install()
	--     end,
	--     config = function()
	--         require("dbee").setup( --[[optional config]])
	--     end
	-- }
	-- stuff to make life easier -----
	"diepm/vim-rest-console",
	{
		"toppair/peek.nvim",
		build = "deno task --quiet build:fast",
		config = function()
			require("peek").setup()
			vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
			vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
		end,
	},
	"kelly-lin/ranger.nvim",
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
	{
		"Exafunction/codeium.vim",
		config = function()
			-- Change '<C-g>' here to any keycode you like.
			vim.keymap.set("i", "<c-j>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<c-k>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<c-x>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true, silent = true })
		end,
	},
}

local opts = {}

require("lazy").setup({
	plugins,
	opts,
})
