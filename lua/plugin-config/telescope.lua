telescope = require("telescope")
telescope.setup{
  defaults = { 
    file_ignore_patterns = {
      "node_modules",
	  ".git/", ".cache", "%.o", "%.a", "%.out", "%.class",
		"%.pdf", "%.mkv", "%.mp4", "%.zip"
    }
  },
  extensions = {
    project = {
      base_dirs = {
        {'~/developer-env', max_depth = 4},
        {'/workspace', max_depth = 4},
        {'~/.config', max_depth = 3},
      },
      hidden_files = false, -- default: false
      theme = "dropdown",
      sync_with_nvim_tree = false, -- default false
    }
  }
}
telescope.load_extension('project')
vim.keymap.set("n","<leader>p",function()
  telescope.extensions.project.project{}
end,{noremap = true, silent = true})
vim.keymap.set("n","<leader>nl",function()
  telescope.extensions.notify.notify{}
end,{noremap = true, silent = true})
