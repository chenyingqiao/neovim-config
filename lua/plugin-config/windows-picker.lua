-- nvim-windows-picker 窗口选择器
picker = require("window-picker")
picker.setup({
  filter_rule = {
	bo = {
	  filetype = {},
	  buftypt = {}
	},
  }
})
