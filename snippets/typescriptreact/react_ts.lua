-- Puedes guardarlo en un archivo .lua (por ejemplo, react.lua) dentro de tu directorio de snippets de LuaSnip.
-- Importar la función 's' para definir un snippet y 't' para texto
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fm = ls.filetype_snippet -- Si quieres restringirlo a tipos de archivo específicos

-- Definición del Snippet para React Arrow Function Component
return {
  fm("typescript,typescriptreact,javascript,javascriptreact", {
    s({
      trig = "rafc", -- El prefijo o 'trigger' (rafc)
      dscr = "Creates a React Arrow Function Component with ES7 module system", -- La descripción
      name = "reactArrowFunctionComponent", -- La clave o nombre del snippet
    }, {
      t("import React from 'react'"),
      t(""),
      t({ -- Definición del componente con nodos de inserción
        "export const ",
        i(1, "${TM_FILENAME_BASE}"), -- Primer nodo de inserción (nombre del componente), con fallback ${TM_FILENAME_BASE}
        " = () => {",
      }),
      t("  return ("),
      t("    <div>"),
      i(2, "first"), -- Segundo nodo de inserción (contenido del div)
      t("</div>"),
      t("  )"),
      t("}"),
      t(""),
    }),
  }),
}
