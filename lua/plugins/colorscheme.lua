

return {
  { "catppuccin/nvim" },

  -- Configure LazyVim to load the colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}

-- return {
--   -- add gruvbox
--   {
--     "ellisonleao/gruvbox.nvim",
--     opts = {
--       terminal_colors = true,
--       contrast = "soft",
--       transparent_mode = false,
--     },
--   },
--
--   -- Configure LazyVim to load gruvbox
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "gruvbox",
--     },
--   },
-- }
