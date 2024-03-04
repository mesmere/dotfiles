return {{
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
	 visible = true,
	 show_hidden_count = false,
	 -- visible but dimmed
	 hide_dotfiles = true,
	 hide_gitignored = true,
	 -- actually hidden
	 never_show = {
	   '.git',
	 },
      },
    }
  }
}}
