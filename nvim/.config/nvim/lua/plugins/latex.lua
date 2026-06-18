-- LaTeX: ajustes propios sobre los extras lang.tex (VimTeX + texlab) y
-- coding.luasnip. Los extras se habilitan en lazyvim.json; aqui solo
-- configuramos visor/compilador de VimTeX y la carga de snippets en Lua.
return {
  -- VimTeX: las variables g:vimtex_* deben fijarse en `init` (se leen al cargar).
  {
    "lervag/vimtex",
    init = function()
      -- Visor con SyncTeX (forward/inverse search). En Wayland usamos
      -- "zathura_simple": igual que "zathura" pero sin la deteccion de
      -- window ID via xdotool (que no funciona en Wayland y produce el
      -- error "Viewer cannot find Zathura window ID!").
      vim.g.vimtex_view_method = "zathura_simple"
      -- Compilacion continua con latexmk (requiere latexmk en el sistema).
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk = {
        aux_dir = "build",
        out_dir = "build",
        options = {
          "-pdf",
          "-shell-escape",
          "-verbose",
          "-file-line-error",
          "-synctex=1",
          "-interaction=nonstopmode",
        },
      }
      -- K lo usa el hover del LSP; <Leader>K queda para los docs de VimTeX.
      vim.g.vimtex_mappings_disable = { n = { "K" } }
      vim.g.vimtex_quickfix_mode = 0 -- no robar el foco con el quickfix al compilar
    end,
  },

  -- LuaSnip: ademas de los friendly-snippets (vscode) que ya carga el extra,
  -- carga snippets propios escritos en Lua desde ~/.config/nvim/luasnippets.
  {
    "L3MON4D3/LuaSnip",
    opts = function(_, opts)
      opts.enable_autosnippets = true -- expansion automatica (estilo LaTeX)
      require("luasnip.loaders.from_lua").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/luasnippets" },
      })
      return opts
    end,
  },
}
