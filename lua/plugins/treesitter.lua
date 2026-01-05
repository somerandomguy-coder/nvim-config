return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  config = function()
    -- This 'pcall' (protected call) catches the error 
    -- and tells you exactly what happened.
    local ok, configs = pcall(require, "nvim-treesitter.configs")
    if not ok then
      print("Treesitter configuration could not be loaded!")
      return
    end

    configs.setup({
      ensure_installed = { 
        "python", "html", "css", "javascript", "typescript", 
        "lua", "vim", "vimdoc", "query", "bash", "go", "gomod" 
      },
      highlight = { enable = true },
    })
  end
}
