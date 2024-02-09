-- neovim's built-in session autosaving seems to work fine
return {}

--return {{
--  "rmagatti/auto-session",
--  opts = {
--    -- autosave but don't autoload, since autoload isn't compatible with lazy.nvim popups
--    auto_session_enabled = false,
--    auto_session_create_enabled = true
--  },
--  config = function(_, opts)
--    vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
--    require("auto-session").setup(opts)
--  end
--}}
