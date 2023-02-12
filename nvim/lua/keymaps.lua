-- Maintain visual mode after shifting with > and <
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('n', '<C-Tab>', ':bnext<cr>')
vim.keymap.set('n', '<S-C-Tab>', ':bNext<cr>')
vim.keymap.set('n', '<F4>', ':bd<cr>')
vim.keymap.set('n', '<F1>', ':NvimTreeToggle<cr>')
vim.keymap.set('n', '<F2>', ':NvimTreeFindFile<cr>')

--nnoremap <leader>p :Prettier<CR>
--nnoremap <leader>ss :source ~/.config/nvim/init.vim<cr>
