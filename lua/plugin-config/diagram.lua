-- diagram.nvim 配置
-- 支持在 markdown 中渲染各种图表 (mermaid, plantuml, d2, gnuplot)

return {
  "3rd/diagram.nvim",
  dependencies = { "3rd/image.nvim" },
  opts = {
    -- 渲染事件配置
    events = {
      render_buffer = { "InsertLeave", "BufWinEnter", "TextChanged" },
      clear_buffer = { "BufLeave" },
    },
    -- 渲染器选项
    renderer_options = {
      mermaid = {
        theme = "forest",
        scale = 1
      },
      plantuml = {
        charset = nil
      },
      d2 = {
        theme_id = nil
      },
      gnuplot = {
        theme = nil,
        size = nil
      },
    },
  },
  -- 键位映射
  keys = {
    {
      "<leader>K",
      function() require("diagram").show_diagram_hover() end,
      mode = "n",
      ft = { "markdown", "norg" },
      desc = "显示图表预览 (Diagram display)",
    },
    {
      "R",
      function() require("diagram").render_buffer() end,
      mode = "n",
      ft = { "markdown", "norg" },
      desc = "重新渲染图表 (Diagram render)",
    },
  },
}
