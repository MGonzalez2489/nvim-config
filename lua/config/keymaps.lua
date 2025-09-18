-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Select all (ctrl+a)
-- keymap.set("n", "<C-a>", "gg<S-v>G")

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
--
