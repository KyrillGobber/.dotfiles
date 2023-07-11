local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    -- My plugins here
    use 'navarasu/onedark.nvim'
    use {"kelly-lin/ranger.nvim"}
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use {'Yggdroot/indentLine'}
    use {'tpope/vim-commentary'}
    use {'tpope/vim-fugitive'}
    use {'mbbill/undotree'}
    --use {'Raimondi/delimitMate'} -- Auto close brackets and stuff
    use {'mhinz/vim-signify'}
    use 'nvim-treesitter/nvim-treesitter'
    use {'nvim-lua/popup.nvim'}
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {'rmagatti/auto-session'}
    use {'github/copilot.vim'}
    use({
        "ggandor/leap.nvim",
        requires = "tpope/vim-repeat"
    })
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
