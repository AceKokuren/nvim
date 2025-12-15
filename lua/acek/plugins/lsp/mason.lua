return {
    "mason-org/mason.nvim",
    dependencies = {
        "mason-org/mason-lspconfig.nvim",
    },

    config = function()
        local mason_lspconfig = require("mason-lspconfig")

        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        })

        mason_lspconfig.setup({
            ensure_installed = {
                "lua_ls",
                "jdtls",
                "cssls",
                "emmet_ls",
                "html",
                "lemminx",

            }
        })
    end,
}
