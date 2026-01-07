local function get_jdtls()
    local mason_registry = require("mason-registry")
    local jdtls = mason_registry.get_package("jdtls")
    local jdtls_path = jdtls:get_install_path()
    local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
    local SYSTEM = "mac"
    local config = jdtls_path .. "/config_" .. SYSTEM
    local lombok = jdtls_path .. "/lombok.jar"

    return launcher, config, lombok
end

local function get_bundles()
    local mason_registry = require("mason-registry") 
    local java_debug = mason_registry.get_package("java-debug-adapter")
    local java_debug_path = java_debug:get_install_path()

    local bundles = {
        vim.fn.glob(java_debug_path .. "/extensions/server/com.microsoft.java.debug.plugin-*.jar", 1)
    }

    local java_test = mason_registry.get_package("java-test")
    local java_test_path = java_test:get_install_path()
    vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. "/extensions/server/*.jar",1), "\n"))

    return bundles
end

local function get_workspace()
    local home = os.getenv "HOME"
    local workspace_path = home .. "/Documents/coding/workspace"
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local workspace_dir = workspace_path .. project_name
    return workspace_dir
end

local function java_keymaps()
    vim.cmd("command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)")
    vim.cmd("command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()")
    vim e
end
