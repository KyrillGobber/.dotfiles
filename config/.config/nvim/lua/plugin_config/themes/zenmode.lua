return {
    "folke/zen-mode.nvim",
    enabled = false,
    keys = {
        { "<leader>z", function() require("zen-mode").toggle() end, desc = "zen mode" },
    },
    config = function()
        require("zen-mode").setup({
            window = {
                backdrop = 1, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
            },
            options = {
                enabled = true,
                -- you may turn on/off statusline in zen mode by setting the 'laststatus'
                -- statusline will be shown only if 'laststatus' == 3
                laststatus = 3, -- turn off statusline in zen mode
            },
        })
    end
}
