telescope = require("telescope")
telescope.setup{
  extensions = {
    project = {
      base_dirs = {
        {'~/developer-env', max_depth = 3},
        {'~/.config', max_depth = 3},
      },
      hidden_files = true, -- default: false
      theme = "dropdown",
      order_by = "asc",
      search_by = "title",
      sync_with_nvim_tree = false, -- default false
    }
  }
}
telescope.load_extension('project')
vim.keymap.set("n","<leader>p",function()
  telescope.extensions.project.project{}
end,{noremap = true, silent = true})
