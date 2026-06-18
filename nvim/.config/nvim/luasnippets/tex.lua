-- Snippets propios de LaTeX para LuaSnip (cargados por lua/plugins/latex.lua).
-- Edita o agrega libremente; se recargan al guardar este archivo.
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

-- Solo expandir dentro de modo matematico (usa la deteccion de VimTeX).
local function in_mathzone()
  return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end
local math = { condition = in_mathzone, show_condition = in_mathzone }

return {
  -- Entornos: "beg" -> \begin{...}\end{...}
  s(
    "beg",
    fmta(
      [[
        \begin{<>}
            <>
        \end{<>}
      ]],
      { i(1), i(2), rep(1) }
    )
  ),
  -- Ecuacion numerada
  s("eq", fmta([[
\begin{equation}
    <>
\end{equation}
  ]], { i(1) })),
}, {
  -- AUTOSNIPPETS (segundo valor de retorno): se expanden solos al teclear.
  -- Fraccion en modo math: "//" -> \frac{}{}
  s({ trig = "//", snippetType = "autosnippet" }, fmta("\\frac{<>}{<>}", { i(1), i(2) }), math),
  -- Subindice: una letra/numero seguido de ";" -> x_{...}  (captura regex)
  s(
    { trig = "([%w]);", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>_{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
    }),
    math
  ),
  -- Math en linea: "mk" -> \( \)
  s({ trig = "mk", snippetType = "autosnippet" }, fmta("\\( <> \\)", { i(1) })),
  -- Math en bloque: "dm" -> \[ ... \]
  s({ trig = "dm", snippetType = "autosnippet" }, fmta("\\[\n    <>\n\\]", { i(1) })),
}
