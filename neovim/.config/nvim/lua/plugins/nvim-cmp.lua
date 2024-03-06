return {{
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    for k,v in ipairs(opts.sources) do
      if v.name == "path" then
        table.remove(opts.sources, k)
        break
      end
    end
  end,
  config = function(_, opts)
    local cmp = require("cmp")
    opts.mapping["<Tab>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
    opts.mapping["<CR>"] = cmp.config.disable
    cmp.setup(opts)

    local js_config = {
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
      })
    }
    cmp.setup.filetype('javascript', js_config)
    cmp.setup.filetype('typescript', js_config)
  end,
}}
