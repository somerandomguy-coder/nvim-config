return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        local autopairs = require("nvim-autopairs")

        autopairs.setup({
            check_ts = true, -- Enable Treesitter integration
            ts_config = {
                lua = { "string" }, -- Don't add pairs in lua string nodes
                javascript = { "template_string" },
            },
            enable_check_bracket_line = false,
            fast_wrap = {
              map = '<M-e>', -- Alt + e
              chars = { '{', '[', '(', '"', "'" },
              offset = 0, 
              end_key = '$',
              keys = 'qwertyuiopzxcvbnmasdfghjkl',
              check_comma = true,
              highlight = 'Search',
              highlight_grey='Comment'
            },
        })

        -- Integration with nvim-cmp (Autocomplete)
        -- If you select a function from the menu, it adds the () automatically
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        local cmp = require("cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
}
