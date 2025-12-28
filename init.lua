local term_buf = nil
local term_win = nil

function _G.toggle_terminal()
  if term_win and vim.api.nvim_win_is_valid(term_win) then
    vim.api.nvim_win_close(term_win, {force = true})
    term_win = nil
  else
    -- Open a vertical split on the far right
    vim.cmd("botright vsplit")
    -- Adjust width (e.g., 60 columns wide)
    vim.cmd("vertical resize 60")
    if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
      vim.api.nvim_win_set_buf(0, term_buf)
    else
      vim.cmd("term")
      term_buf = vim.api.nvim_get_current_buf()
    end
    term_win = vim.api.nvim_get_current_win()
    vim.cmd("startinsert") -- Auto-enter insert mode
  end
end


require("config.lazy")
require("config.keymaps")
require("config.options")
require("config.autocmds")

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf }
    
    vim.api.nvim_set_keymap('i', '<A-e>', '<Esc>e', { noremap = true, silent = true })
    -- Knowledge
    vim.keymap.set('n', 'K',  vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    
    -- Actions
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    
    -- Diagnostics (Errors/Warnings)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  end,
})
