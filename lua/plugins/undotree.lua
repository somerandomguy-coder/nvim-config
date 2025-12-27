return {
  'mbbill/undotree',
  config = function()
    -- Set a keymap to toggle the tree
    vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = "Toggle UndoTree" })
  end
}
