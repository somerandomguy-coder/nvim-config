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
function _G.run_current_file()
    local file_name = vim.api.nvim_buf_get_name(0)
    local file_ext = vim.fn.expand("%:e")
    local cmd = ""

    -- 1. Determine the command based on file extension
    if file_ext == "py" then
        cmd = "python3 " .. file_name
    elseif file_ext == "js" then
        cmd = "node " .. file_name
    elseif file_ext == "html" then
        cmd = "firefox " .. file_name -- Or 'google-chrome'
    elseif file_ext == "sh" then
        cmd = "bash " .. file_name
    elseif file_ext == "go" then
        cmd = "go run " .. file_name
    else
        print("Extension not supported for auto-run")
        return
    end

    -- 2. Ensure terminal is open (using your existing function)
    -- If no terminal window exists, open it
    if not (term_win and vim.api.nvim_win_is_valid(term_win)) then
        toggle_terminal()
    end

    -- 3. Send the command to the terminal buffer
    -- We use \13 to simulate the 'Enter' key
    vim.api.nvim_chan_send(vim.bo[term_buf].channel, cmd .. "\13")
end

-- Keymap to run: Let's use <leader>r for "Run"
vim.keymap.set('n', '<leader>r', '<cmd>lua run_current_file()<CR>', { desc = 'Run current file in terminal' })
