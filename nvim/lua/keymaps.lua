-- Maintain visual mode after shifting with > and <
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('n', '<C-Tab>', ':bnext<cr>')
vim.keymap.set('n', '<S-C-Tab>', ':bNext<cr>')
vim.keymap.set('n', '<F4>', ':bd<cr>')
vim.keymap.set('n', '<F1>', ':NvimTreeToggle<cr>')
vim.keymap.set('n', '<F2>', ':NvimTreeFindFile<cr>')

-- Prettier
vim.keymap.set("n", "<leader>p", ":CocCommand prettier.forceFormatDocument<cr>")
-- Git DiffView
vim.keymap.set("n", "<leader>do", ":DiffviewOpen<CR>")
vim.keymap.set("n", "<leader>dc", ":DiffviewClose<CR>")
--nnoremap <leader>p :Prettier<CR>
--nnoremap <leader>ss :source ~/.config/nvim/init.vim<cr>

vim.keymap.set("n", "<leader>hh", "<Plug>RestNvim")
vim.keymap.set("n", "<leader>hp", "<Plug>RestNvimPreview")
vim.keymap.set("n", "<leader>hl", "<Plug>RestNvimLast")
vim.keymap.set("n", "<leader>rp", ":call CocAction('format')<cr>")

