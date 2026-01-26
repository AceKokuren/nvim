-- lua/acek/plugins/lsp.lua
return {
  -- This is the main plugin for this file.
  "neovim/nvim-lspconfig",

  -- All other LSP-related plugins are its dependencies.
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "mfussenegger/nvim-jdtls",
    "hrsh7th/cmp-nvim-lsp",
  },

  config = function()
    -- =================================================================
    -- 1. DEFINE SHARED CONFIGURATION (Keymaps and Capabilities)
    -- =================================================================
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- This on_attach function will be used for all servers.
    local on_attach = function(client, bufnar)
      local keymap = vim.keymap
      local opts = { buffer = bufnar, silent = true }
      opts.desc = "Show LSP references"
      keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
      opts.desc = "Go to declaration"
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      opts.desc = "Show LSP definitions"
      keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
      opts.desc = "Show LSP implementations"
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
      opts.desc = "Show LSP type definitions"
      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
      opts.desc = "See available code actions"
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
      opts.desc = "Smart rename"
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      opts.desc = "Show buffer diagnostics"
      keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
      opts.desc = "Show line diagnostics"
      keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
      opts.desc = "Go to previous diagnostic"
      keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
      opts.desc = "Go to next diagnostic"
      keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
      opts.desc = "Show documentation for what is under cursor"
      keymap.set("n", "K", vim.lsp.buf.hover, opts)
      opts.desc = "Restart LSP"
      keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
    end

    -- =================================================================
    -- 2. SETUP MASON & THE BRIDGE TO LSPCONFIG
    -- =================================================================
    -- FIX: Your Mason UI icons are restored here.
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "jsonls",
        "html",
        "cssls",
        "jdtls",
        "bashls",
        "dockerls",
        "yamlls",
      },
    })

    -- =================================================================
    -- 3. SETUP LSP SERVERS
    -- =================================================================
    local lspconfig = require("lspconfig")
    local servers = { "lua_ls", "jsonls", "html", "cssls", "bashls", "dockerls", "yamlls" }

    for _, server_name in ipairs(servers) do
      local server_opts = {
        capabilities = capabilities,
        on_attach = on_attach,
      }
      if server_name == "lua_ls" then
        server_opts.settings = { Lua = { runtime = { version = "LuaJIT" }, diagnostics = { globals = { "vim", "require" } } } }
      end
      -- This uses the older, deprecated API, but it is the one that works for you.
      lspconfig[server_name].setup(server_opts)
    end

    -- =================================e=================================
    -- 4. SPECIAL SETUP FOR JDTLS (JAVA)
    -- =================================================================
    local jdtls = require("jdtls")
    -- This also uses the older API, as it was part of the working config.
    lspconfig.jdtls.setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        on_attach(client, bufnr) -- Run the generic keymaps first
        -- And then add the Java-specific ones
        local map = function(mode, lhs, rhs, desc) vim.keymap.set(mode, lhs, rhs, { silent = true, buffer = bufnr, desc = "JDTLS: " .. desc }) end
        map("n", "<leader>do", jdtls.organize_imports, "Organize Imports")
        map("n", "<leader>dt", jdtls.test_nearest_method, "Test Nearest Method")
        map("n", "<leader>dT", jdtls.test_class, "Test Class")
        map("v", "<leader>de", function() jdtls.extract_variable(true) end, "Extract Variable")
        map("n", "<leader>de", jdtls.extract_variable, "Extract Variable")
      end,
    })
  end,
}

