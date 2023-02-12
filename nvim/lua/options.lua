vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.syntax = true

--vim.opt.number = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.smartindent = true
vim.opt.cursorline = true
vim.opt.ruler = true -- line and such at bottom right
--vim.opt.updatetime = 300 -- defined in coc.lua
vim.opt.showmode = false
vim.opt.swapfile = false
vim.opt.showtabline = 2
vim.opt.compatible = false
vim.opt.termguicolors = true

vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true -- autosave like vimscripts :au FocusLost * :wa
vim.opt.autoread = true
vim.opt.clipboard = 'unnamedplus'

-- use spaces for tabs and whatnot
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.shiftround = true
vim.opt.expandtab = true

vim.cmd("au FocusLost * :wa")
