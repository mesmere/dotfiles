return {{
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    -- remove git branch
    table.remove(opts.sections.lualine_b, 1)

    -- remove clock
    table.remove(opts.sections.lualine_z, 1)
  end,
}}
