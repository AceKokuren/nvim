local M = {
    "neanias/everforest-nvim",
    lazy = false,
    priority = 1000,
}

function M.config()
    local everforest = require("everforest")
    everforest.setup({
        background = "medium",
        transparent_background_level = 0,

    })
    everforest.load()
end

return M
