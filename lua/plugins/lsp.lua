return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      local mason_lspconfig = require("mason-lspconfig")

      mason_lspconfig.setup({
        ensure_installed = { "pyright", "html", "cssls", "ts_ls", "lua_ls", "gopls"},
      })

      -- MODERN 0.11+ WAY TO ENABLE SERVERS
      -- Instead of lspconfig.pyright.setup({}), we use vim.lsp.enable
      -- Tell LSP we have an autocomplete window ready
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      mason_lspconfig.setup_handlers({
        function(server_name)
          -- Updated for 0.11+ with capabilities
          vim.lsp.enable(server_name)
          
          -- This line ensures the server sends autocomplete data
          vim.lsp.config(server_name, { capabilities = capabilities })
        end,
      })
      -- Custom configuration for specific servers (like Lua)
      -- In 0.11, we use vim.lsp.config to tweak settings
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            diagnostics = { globals = { 'vim' } },
            workspace = { checkThirdParty = false },
          },
        },
        vim.lsp.config('gopls', {
        settings = {
            gopls = {
            analyses = { unusedparams = true },
            staticcheck = true,
    },
  },
})
      })
    end,
  },
}
