return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {},
  config = function()
      require("snacks").setup{}
  end,
}
