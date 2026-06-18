return {
  -- Molten: Ejecución interactiva de celdas
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      -- Estas opciones deben setearse antes de que el plugin cargue
      vim.g.molten_image_provider = "image.nvim" -- Cambiado para soporte en Ghostty
      vim.g.molten_output_win_max_height = 30
      vim.g.molten_auto_open_output = false
      -- Output persistente: como texto virtual debajo de la celda (no float, que se
      -- cierra al moverte). La figura va en el virt text; se quita con <C-l> (MoltenDelete).
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_text_max_lines = 30
      vim.g.molten_image_location = "virt"
    end,
  },

  -- Configuración de image.nvim para Ghostty (protocolo kitty)
  {
    "3rd/image.nvim",
    opts = {
      backend = "kitty", -- Ghostty soporta el protocolo de kitty
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "markdown", "quarto" },
        },
      },
      max_width = 100,
      max_height = 30, -- antes 12: subía poco las figuras del output de molten
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    },
  },

  -- Quarto: Integración de notebooks y Jupytext
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      lspFeatures = {
        languages = { "python" },
        chunks = "all",
        diagnostics = { enabled = true },
        completion = { enabled = true },
      },
      codeRunner = {
        enabled = true,
        default_method = "molten",
      },
    },
  },

  -- Otter: LSP en bloques de código (Markdown/Quarto)
  {
    "jmbuhr/otter.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
  },

  -- Jupytext: Abrir .ipynb como scripts de Python automáticamente
  {
    "GCBallesteros/jupytext.nvim",
    opts = {
      custom_language_formatting = {
        python = {
          extension = "py",
          style = "percent",
          force_ft = "python",
        },
      },
    },
  },

  -- Asegurar que Treesitter tenga los parsers necesarios
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "python",
        "markdown",
        "markdown_inline",
        "yaml",
      },
    },
  },
}
