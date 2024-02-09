return {
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    opts = {
        reduced_blue = true,
    	on_palette = function(palette)
    	  palette.gray0 = '#0a0a0a'
    	  return palette
    	end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nordic",
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- this doesn't do anything for some reason but the default theme is fine
      opts.theme = 'nordic'
    end,
  },
}
