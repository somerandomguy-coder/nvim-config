return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        -- These are the "brains" for your languages
        ensure_installed = { 
            "pyright",    -- Python
            "html",       -- HTML
            "cssls",      -- CSS
            "ts_ls",      -- JS/Node
        },
      })
    end,
  }
}
