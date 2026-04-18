require('opencode').setup({
  server = {
    start = function()
      vim.o.autoread = true
    end,
  },
})