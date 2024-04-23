local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    --Themes
    use 'navarasu/onedark.nvim'
    use "rebelot/kanagawa.nvim"
    -- Core
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use 'nvim-treesitter/nvim-treesitter'
    -- LSP
    use {
        -- LSP
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-vsnip',
        'hrsh7th/vim-vsnip',
    }
    use { 'stevearc/conform.nvim' }
    -- stuff to make life easier
    use { "kelly-lin/ranger.nvim" }
    use({
        "ggandor/leap.nvim",
        requires = "tpope/vim-repeat"
    })
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use { 'tpope/vim-commentary' }
    use { 'tpope/vim-fugitive' }
    use { 'mhinz/vim-signify' }
    use { 'nvim-lua/popup.nvim' }
    use { 'rmagatti/auto-session' }
    use { 'Exafunction/codeium.vim' }
    use { "ThePrimeagen/refactoring.nvim" }
    use { 'nvim-telescope/telescope-ui-select.nvim' }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
