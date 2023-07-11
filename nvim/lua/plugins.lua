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
        "kelly-lin/ranger.nvim",
        config = function()
            require("ranger-nvim").setup({ replace_netrw = true })
            vim.api.nvim_set_keymap("n", "<leader>ef", "", {
            noremap = true,
            callback = function()
                require("ranger-nvim").open(true)
            end,
            })
        end,
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use {'neoclide/coc.nvim', branch = 'release'}
    use {'coc-extensions/coc-svelte'}
    use {'Yggdroot/indentLine'}
    use {'tpope/vim-commentary'}
    use {'tpope/vim-fugitive'}
    --use {'Raimondi/delimitMate'} -- Auto close brackets and stuff
    use {'mhinz/vim-signify'}
    use 'nvim-treesitter/nvim-treesitter'
    use {'nvim-lua/popup.nvim'}
    use {'nvim-lua/plenary.nvim'}
    use {
      'nvim-telescope/telescope.nvim', tag = '0.1.1',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {'fannheyward/telescope-coc.nvim'}
    use {
        'rmagatti/auto-session',
        config = function()
            require("auto-session").setup {
                log_level = vim.log.levels.ERROR,
                auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
                auto_session_use_git_branch = false,

                auto_session_enable_last_session = false,

                -- ⚠️ This will only work if Telescope.nvim is installed
                -- The following are already the default values, no need to provide them if these are already the settings you want.
                session_lens = {
                    -- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
                    load_on_setup = true,
                    theme_conf = { border = true },
                    previewer = false,
                },
            }
        end
        }
    use {'github/copilot.vim'}
    use({
        "ggandor/leap.nvim",
        requires = "tpope/vim-repeat",
        config = function()
            require("leap").add_default_mappings()
        end,
    })
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
