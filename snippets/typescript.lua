local ls = require("luasnip")

local t = ls.text_node

return {
  ls.snippet({ trig = "hit" }, { t("wasaaa ts bitch!") }),
  ls.snippet({ trig = "cl" }, {
    t("console.log("),
    i(1), -- El cursor se posicionará aquí
    t(")"),
  }),
}
