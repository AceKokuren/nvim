return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        require("lualine").setup{
            lualine_c = { { 'filename', path = 2 } }
        }
    end,
}
