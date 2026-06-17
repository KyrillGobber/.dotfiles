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

-- Plugins without config or disabled or todo
local plugins = {
    { "tpope/vim-commentary", enabled = false },
    "mhinz/vim-signify",
    "tpope/vim-fugitive",

    {
        'nvim-java/nvim-java',
        config = function()
            require('java').setup()
            vim.lsp.enable('jdtls')
        end,
    },
    {
        'tigion/nvim-asciidoc-preview',
        enabled = false,
        ft = { 'asciidoc' },
        build = 'cd server && npm install --omit=dev --no-save',
        ---@module 'asciidoc-preview'
        ---@type asciidoc-preview.Config
        opts = {
        -- Add user configuration here
        },
    },
    { "ThePrimeagen/refactoring.nvim", enabled = false },
    {
        "kndndrj/nvim-dbee",
        enabled = false,
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        build = function()
            -- Install tries to automatically detect the install method.
            -- if it fails, try calling it with one of these parameters:
            --    "curl", "wget", "bitsadmin", "go"
            require("dbee").install()
        end,
        config = function()
            require("dbee").setup( --[[optional config]])
        end,
    },
}

require("lazy").setup({
    spec = {
        plugins,
        { import = "plugin_config" },
        { import = "plugin_config.themes" },
    },
})
