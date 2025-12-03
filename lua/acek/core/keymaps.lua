vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")

-- Split Windows
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split windows vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split windows horiaontally" })
keymap.set("n", "<leader>so", "<C-w>o", { desc = "Close all but this window" })
keymap.set("n", "<leader>sc", "<C-w>c", { desc = "Close current window" })

-- Navigate Split Windows
keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Move right a window" })
keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Move left a window" })
keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Move down a window" })
keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Move up a window" })
keymap.set("n", "<leader>wt", "<C-w>t", { desc = "Move to top left window" })
keymap.set("n", "<leader>wb", "<C-w>b", { desc = "Move to bottom right window" })


-- Move Split Windows
keymap.set("n", "<leader>wK", "<C-w>K", { desc = "Move current window to top" })
keymap.set("n", "<leader>wJ", "<C-w>J", { desc = "Move current window to bottom" })
keymap.set("n", "<leader>wx", "<C-w>x", { desc = "Swap current window with next one, or previous if none available" })
keymap.set("n", "<leader>wH", "<C-w>H", { desc = "Move current window to Left" })
keymap.set("n", "<leader>wL", "<C-w>L", { desc = "Move current window to right" })
keymap.set("n", "<leader>w;", "<C-w>|", { desc = "Move window to full width" })
keymap.set("n", "<leader>w_", "<C-w>_", { desc = "Move window to full height" })
keymap.set("n", "<leader>w=", "<C-w>=", { desc = "Set all windows to equal height" })

-- Highlighting
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
