local builtin = require('telescope.builtin')
local telescope = require('telescope')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fc', ':Telescope git_status <cr>', {})
--vim.keymap.set('n', '<leader>fq', builtin.quickfix, {})
vim.keymap.set("n", "<leader>fs", require("auto-session.session-lens").search_session, {
  noremap = true,
})
vim.keymap.set('n', '<leader>ca', ':Telescope coc line_code_actions <cr>', {})
vim.keymap.set('n', '<leader>cs', ':Telescope coc document_symbols <cr>', {})
vim.keymap.set('n', '<leader>cd', ':Telescope coc diagnostics <cr>', {})
vim.keymap.set('n', '<leader>cm', ':Telescope coc commands <cr>', {})
vim.keymap.set('n', '<leader>td', ':Telescope coc definitions <cr>', {})
vim.keymap.set('n', '<leader>tr', ':Telescope coc references <cr>', {})

