require("ranger-nvim").setup({
    replace_netrw = true,
    ui = {
        border = "none",
        height = 0.95,
        width = 1,
        x = 0.5,
        y = 0.5,
    }
})
vim.api.nvim_set_keymap("n", "<leader>ef", "", {
    noremap = true,
    callback = function()
        require("ranger-nvim").open(true)
    end,
})
