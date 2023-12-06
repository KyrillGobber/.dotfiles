local builtin = require('telescope.builtin')
--local telescope = require('telescope')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>cs', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>ac', builtin.diagnostics, {})
--vim.keymap.set('n', '<leader>gs', builtin.git_status, {})
vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})
-- vim.keymap.set('n', '<leader>ca', ':Telescope coc line_code_actions <cr>', {})
-- vim.keymap.set('n', '<leader>cs', ':Telescope coc document_symbols <cr>', {})
-- vim.keymap.set('n', '<leader>cd', ':Telescope coc diagnostics <cr>', {})
-- vim.keymap.set('n', '<leader>cm', ':Telescope coc commands <cr>', {})
-- vim.keymap.set('n', '<leader>td', ':Telescope coc definitions <cr>', {})
-- vim.keymap.set('n', '<leader>tr', ':Telescope coc references <cr>', {})

require("telescope").setup {
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }

      -- pseudo code / specification for writing custom displays, like the one
      -- for "codeactions"
      -- specific_opts = {
      --   [kind] = {
      --     make_indexed = function(items) -> indexed_items, width,
      --     make_displayer = function(widths) -> displayer
      --     make_display = function(displayer) -> function(e)
      --     make_ordinal = function(e) -> string
      --   },
      --   -- for example to disable the custom builtin "codeactions" display
      --      do the following
      --   codeactions = false,
      -- }
    }
  }
}
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("ui-select")
