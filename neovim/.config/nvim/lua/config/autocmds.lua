-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_autocmd("FileType", {
  -- Don't auto-insert the comment leader on the new line after a hanging inline comment
  command = "set formatoptions+=/"
})

-- lazyvim turns on spellcheck in markdown files lmfao
vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
