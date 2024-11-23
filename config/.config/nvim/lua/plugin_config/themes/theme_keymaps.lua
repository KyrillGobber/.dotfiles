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
