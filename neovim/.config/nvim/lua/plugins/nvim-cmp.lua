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
}}
