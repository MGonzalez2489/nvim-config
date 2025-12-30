-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Select all (ctrl+a)
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Jumplist (ctrl+shift+m)
-- keymap.set("n", "<C-m>", "<C-i>", opts)

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- -- Resize window
keymap.set("n", "<C-w><C-l>", "<C-w><") --left
keymap.set("n", "<C-w><C-h>", "<C-w>>") --right
keymap.set("n", "<C-w><C-k>", "<C-w>+") --Up
keymap.set("n", "<C-w><C-j>", "<C-w>-") --Down

-- code companion
keymap.set({ "n", "v" }, "aa", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
keymap.set({ "n", "v" }, "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
-- cmd([[cab cc CodeCompanion]])

-- Mapeo para saltar entre ventanas (funciona en Snacks, Telescope y split normales)
vim.keymap.set("n", "<C-n>", "<C-w>w", { desc = "Saltar al Preview / Siguiente Ventana" })

-- Si quieres que funcione incluso mientras estás filtrando/escribiendo en el buscador de Snacks:
vim.keymap.set("i", "<C-n>", "<esc><C-w>w", { desc = "Saltar al Preview desde modo inserto" })
