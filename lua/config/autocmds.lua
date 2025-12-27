-- Brief highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank({
        higroup = 'IncSearch', -- Use the 'IncSearch' color group
        timeout = 150,         -- How long the highlight lasts (ms)
    })
  end,
})
