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
-- Acciones rápidas (Refactor, Fix, Explain)
keymap.set({ "n", "v" }, "<leader>ap", "<cmd>CodeCompanionActions<cr>", { desc = "AI Actions" })

-- Chat con contexto (Toggle)
keymap.set({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "AI Chat" })

-- Inline Edit
keymap.set({ "n", "v" }, "<leader>ai", "<cmd>CodeCompanion<cr>", { desc = "AI Inline Edit" })

-- Añadir selección al chat
keymap.set("v", "<leader>av", "<cmd>CodeCompanionChat Add<cr>", { desc = "Add to AI Chat" })

-- Mapeo para saltar entre ventanas (funciona en Snacks, Telescope y split normales)
vim.keymap.set("n", "<C-n>", "<C-w>w", { desc = "Saltar al Preview / Siguiente Ventana" })

-- Si quieres que funcione incluso mientras estás filtrando/escribiendo en el buscador de Snacks:
vim.keymap.set("i", "<C-n>", "<esc><C-w>w", { desc = "Saltar al Preview desde modo inserto" })
