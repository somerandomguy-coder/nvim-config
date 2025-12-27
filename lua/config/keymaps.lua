local builtin = require("telescope.builtin")

-- The "Big Three" for daily work
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Search Text (Grep)' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Open Buffers' })

-- Navigate through screen
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

-- Stay in middle 
vim.api.nvim_set_keymap('n', 'h', 'hzz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', 'jzz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'k', 'kzz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'l', 'lzz', { noremap = true, silent = true })

-- Exit terminal mode with double Escape
vim.keymap.set('t', '<Esc><Esc>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })

-- Optional: If you want Esc Esc to also clear search highlights in Normal mode
vim.keymap.set('n', '<Esc><Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })

-- This works like the old :so but specifically for Lua
vim.keymap.set('n', '<leader>x', '<cmd>source %<CR>', { desc = 'Source current file' })
vim.keymap.set('n', '<leader>R', function()
    -- This clears the cache for your 'plugins' and 'config' folders
    for name, _ in pairs(package.loaded) do
        if name:match('^plugins') or name:match('^config') then
            package.loaded[name] = nil
        end
    end
    dofile(vim.env.MYVIMRC)
    print("Config Reloaded!")
end, { desc = 'Reload entire nvim config' })
vim.keymap.set({'n', 't'}, '<C-t>', '<cmd>lua toggle_terminal()<CR>', { desc = 'Toggle Terminal' })


