vim.keymap.set('n', '<leader>z', ':ZenMode<CR>>')

function Toggle_zen_mode()
	require("zen-mode").toggle({})
	vim.cmd("colorscheme rose-pine")
end

--map("n", "<leader>Z", [[ <Cmd> lua toggle_zen_mode()<CR>]])
vim.keymap.set('n', '<leader>Z', Toggle_zen_mode)

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
