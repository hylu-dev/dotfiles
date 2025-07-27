return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false, -- Ensure the plugin loads during startup
    priority = 1000, -- Load before other plugins
    config = function()
      require("kanagawa").setup({
        compile = false, -- Enable compiling the colorscheme
        undercurl = true, -- Enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false, -- Set to true for transparent background
        dimInactive = false, -- Dim inactive windows
        terminalColors = true, -- Define vim.g.terminal_color_{0,17}
        colors = { -- Customize theme and palette colors
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function(colors)
          return {}
        end,
        theme = "wave", -- Set default theme (options: "wave", "dragon", "lotus")
        background = { -- Map background option to themes
          dark = "wave",
          light = "lotus",
        },
      })
      -- Load the colorscheme
      vim.cmd("colorscheme kanagawa")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa",
    },
  },
}
