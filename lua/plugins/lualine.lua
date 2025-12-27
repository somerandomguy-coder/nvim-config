return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- Custom function to show Harpoon index
    local function harpoon_status()
      local harpoon = require("harpoon")
      local list = harpoon:list()
      local root_dir = list.config:get_root_dir()
      local current_file_path = vim.api.nvim_buf_get_name(0)
      
      -- Shorten the path to match Harpoon's internal storage
      local relative_path = vim.fn.fnamemodify(current_file_path, ":.")
      
      for i, item in ipairs(list.items) do
        if item.value == relative_path then
          return "󰛢 " .. i -- Returns the Harpoon icon + index (e.g., 󰛢 1)
        end
      end
      return ""
    end

    require('lualine').setup({
      options = {
        theme = 'auto', -- Matches whatever colorscheme you pick
        globalstatus = true, -- One statusline at the bottom for all splits
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 
          { 'filename', path = 1 }, -- path = 1 shows parent folders
          { harpoon_status, color = { fg = "#2471a3", gui = "bold" } } 
        },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
    })
  end
}
