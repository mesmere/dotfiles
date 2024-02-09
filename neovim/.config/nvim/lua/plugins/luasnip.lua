return {
  { "L3MON4D3/LuaSnip", enabled = false },
  {
    -- remove luasnip from the nvim-cmp sources so that cmp doesn't complain
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      for k,v in ipairs(opts.sources) do
        if v.name == "luasnip" then
          table.remove(opts.sources, k)
          break
        end
      end
    end,
  }
}
