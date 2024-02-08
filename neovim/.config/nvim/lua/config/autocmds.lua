-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function(args)
    vim.opt.colorcolumn = "+1"
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "javascript",
  callback = function(args)
    vim.opt.cindent = true
  end
})
