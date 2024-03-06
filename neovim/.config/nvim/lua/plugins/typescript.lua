return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "typescript", "javascript" })
      end
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      separate_diagnostic_server = false
    },
  },
--  {
--    "mfussenegger/nvim-dap",
--    optional = true,
--    dependencies = {
--      {
--        "williamboman/mason.nvim",
--        opts = function(_, opts)
--          opts.ensure_installed = opts.ensure_installed or {}
--          table.insert(opts.ensure_installed, "js-debug-adapter")
--        end,
--      },
--    },
--    -- https://www.lazyvim.org/extras/lang/typescript#nvim-dap-optional
--  }
}
