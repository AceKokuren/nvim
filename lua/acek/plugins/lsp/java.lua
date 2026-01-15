-- lua/plugins/lsp/java.lua
return {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "williamboman/mason.nvim",
  },
  config = function()
    -- Find the jdtls installation path from mason
    local jdtls_path = require("mason-registry").get_package("jdtls"):get_install_path()
    local jdtls_launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

    -- Find the project name
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

    -- Define the workspace directory for this project
    -- This is where jdtls will store its data
    local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/workspace/" .. project_name

    -- Determine OS-specific configuration path
    local os
    if vim.fn.has("win32") == 1 then
      os = "win"
    elseif vim.fn.has("mac") == 1 then
      os = "mac"
    else
      os = "linux"
    end

    -- Main jdtls configuration
    local config = {
      cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        jdtls_launcher,
        "-configuration",
        jdtls_path .. "/config_" .. os,
        "-data",
        workspace_dir,
      },
      -- Use nvim-lspconfig's default on_attach, but add custom keymaps for Java
      on_attach = function(client, bufnr)
        -- Call the default on_attach function from your main LSP config
        require("plugins.lsp").on_attach(client, bufnr)

        -- Custom keymaps for Java
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { silent = true, buffer = bufnr, desc = "LSP: " .. desc })
        end

        map("n", "<leader>di", "<Cmd>JdtlsInstallAPlugin<CR>", "Install JDTLS Plugin")
        map("n", "<leader>do", "<Cmd>JdtlsOrganizeImports<CR>", "Organize Imports")
        map("n", "<leader>dt", "<Cmd>JdtlsTestNearestMethod<CR>", "Test Nearest Method")
        map("n", "<leader>dT", "<Cmd>JdtlsTestClass<CR>", "Test Class")
        map("v", "<leader>de", "<Esc><Cmd>JdtlsExtractVisual<CR>", "Extract Visual")
      end,

      -- Specify the root directory for projects
      root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),

      -- Other settings
      settings = {
        java = {
          signatureHelp = { enabled = true },
          contentProvider = { preferred = "fernflower" },
          completion = {
            favoriteStaticMembers = {
              "org.hamcrest.MatcherAssert.assertThat",
              "org.hamcrest.Matchers.*",
              "org.junit.jupiter.api.Assertions.*",
              "java.util.Objects.requireNonNull",
              "java.util.Objects.requireNonNullElse",
              "org.mockito.Mockito.*",
            },
          },
          sources = {
            organizeImports = {
              starThreshold = 9999,
              staticStarThreshold = 9999,
            },
          },
          codeGeneration = {
            toString = {
              template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            },
            useBlocks = true,
          },
        },
      },
    }

    -- Start the jdtls server
    require("jdtls").start_or_attach(config)
  end,
}
