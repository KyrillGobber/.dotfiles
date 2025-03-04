-- Maintain visual mode after shifting with > and <
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')
-- Move selected line / block of text in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- Centered half page scroll
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- Keep search centered
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- quickfix navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Search and replace word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.api.nvim_set_keymap('n', '<C-Tab>', ':bnext<cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<S-C-Tab>', ':bNext<cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-N>', ':bnext<cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-P>', ':bNext<cr>', {noremap = true, silent = true})

vim.keymap.set('n', '<F4>', ':bd<cr>')
vim.keymap.set('n', '<leader>cl', ':set conceallevel=0<cr>')

vim.keymap.set('n', '<leader>P', ':Prettier<cr>')

function Cycle_colorschemes()
    local colorschemes = {
        "kanagawa",
        "rose-pine",
        "onedark"
    }
    local current = vim.g.colors_name
    local next_index = 1
    for i, scheme in ipairs(colorschemes) do
        if scheme == current then
            next_index = (i % #colorschemes) + 1
            break
        end
    end
    vim.cmd('colorscheme ' .. colorschemes[next_index])
    vim.notify('Switched to colorscheme: ' .. vim.g.colors_name)
end

vim.keymap.set('n', '<leader>t', Cycle_colorschemes, {desc = 'Cycle colorschemes'})

-- CodeCompanion
vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<LocalLeader>c", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])

