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
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use {'neoclide/coc.nvim', branch = 'release'}
    use {'Yggdroot/indentLine'}
    use {'tpope/vim-commentary'}
    use {'tpope/vim-fugitive'}
    use {'Raimondi/delimitMate'}
    use {'mhinz/vim-signify'}
    use {'sindrets/diffview.nvim'}
    use 'nvim-treesitter/nvim-treesitter'
    use {'nvim-lua/popup.nvim'}
    use {'nvim-lua/plenary.nvim'}
    use {
      'nvim-telescope/telescope.nvim', tag = '0.1.1',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {'fannheyward/telescope-coc.nvim'}
    use {
        'rmagatti/session-lens',
        requires = {'rmagatti/auto-session'},
        config = function()
            require('session-lens').setup({path_display={'shorten'},})
        end
    }
    use('kmonad/kmonad-vim')
    use {
        "rest-nvim/rest.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("rest-nvim").setup({
            -- Open request results in a horizontal split
            result_split_horizontal = false,
            -- Keep the http file buffer above|left when split horizontal|vertical
            result_split_in_place = false,
            -- Skip SSL verification, useful for unknown certificates
            skip_ssl_verification = false,
            -- Encode URL before making request
            encode_url = true,
            -- Highlight request on run
            highlight = {
                enabled = true,
                timeout = 150,
            },
            result = {
                -- toggle showing URL, HTTP info, headers at top the of result window
                show_url = true,
                show_http_info = true,
                show_headers = true,
                -- executables or functions for formatting response body [optional]
                -- set them to false if you want to disable them
                formatters = {
                json = "jq",
                html = function(body)
                    return vim.fn.system({"tidy", "-i", "-q", "-"}, body)
                end
                },
            },
            -- Jump to request line on run
            jump_to_request = false,
            env_file = '.env',
            custom_dynamic_variables = {},
            yank_dry_run = true,
            })
        end
    }
    use {'github/copilot.vim'}
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
