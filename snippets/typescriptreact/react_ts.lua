local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("typescriptreact", {
  s(
    "rfc",
    fmt(
      [[
      export const {}=()=>{{
      return({});
      }}
  ]],
      {
        f(function()
          return vim.fn.expand("%:t:r")
        end),
        i(1),
      }
    )
  ),
})
