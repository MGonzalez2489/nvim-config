return {

  "L3MON4D3/LuaSnip",
  event = "VeryLazy",
  run = "make install_jsregexp",
  dependencies = {
    {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_lua").lazy_load({ paths = { "~/.config/nvim/snippets/" } })
      end,
    },
  },

  opts = {
    history = true,
    delete_check_events = "TextChanged",
  },
}
-- return {
--   "L3MON4D3/LuaSnip",
--   event = "VeryLazy",
--   run = "make install_jsregexp",
--   config = function()
--     require("luasnip.loaders.from_lua").lazy_load({ paths = { "~/.config/nvim/snippets/" } })
--     local ls = require("luasnip")
--
--     local M = {}
--
--     function M.expand_or_jump()
--       if ls.expand_or_jumpable() then
--         ls.expand_or_jump()
--       end
--     end
--
--     function M.jump_next()
--       if ls.jumpable(1) then
--         ls.jump(1)
--       end
--     end
--
--     function M.jump_prev()
--       if ls.jumpable(-1) then
--         ls.jump(-1)
--       end
--     end
--
--     function M.change_choice()
--       if ls.choice_active() then
--         ls.change_choice(1)
--       end
--     end
--
--     function M.reload_package(package_name)
--       for module_name, _ in pairs(package.loaded) do
--         if string.find(module_name, "^" .. package_name) then
--           package.loaded[module_name] = nil
--           require(module_name)
--         end
--       end
--     end
--
--     function M.refresh_snippets()
--       ls.cleanup()
--       M.reload_package("~/.config/nvim/snippets/") --replace for a relative path
--       -- M.reload_package('user.snips')
--     end
--
--
--
--     vim.keymap.set("n", ",r", 'lua require("luasnip.loaders.from_lua").load({paths = {"~/.config/nvim/snippets/"})')
--   end,
--
--   -- lazy = true,
--   -- build = (not LazyVim.is_win())
--   --     and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
--   --   or nil,
--   -- dependencies = {
--   --   {
--   --     "rafamadriz/friendly-snippets",
--   --     config = function()
--   --       require("luasnip.loaders.from_lua").lazy_load({ paths = { "~/.config/nvim/snippets/" } })
--   --     end,
--   --   },
--   -- },
--   -- opts = {
--   --   history = true,
--   --   delete_check_events = "TextChanged",
--   -- },
-- }
