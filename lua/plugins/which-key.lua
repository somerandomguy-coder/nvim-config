return {
  "folke/which-key.nvim",
  event = "VeryLazy", -- This ensures it loads almost immediately
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300 -- This is the delay (ms) before the menu pops up
  end,
  opts = {
    -- your configuration
  }
}
