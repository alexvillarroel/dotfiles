return {
  "GCBallesteros/NotebookNavigator.nvim",
  keys = {
    {
      "]h",
      function()
        require("notebook-navigator").move_cell("d")
      end,
    },
    {
      "[h",
      function()
        require("notebook-navigator").move_cell("u")
      end,
    },
    { "<leader>X", "<cmd>lua require('notebook-navigator').run_cell()<cr>" },
    { "<leader>x", "<cmd>lua require('notebook-navigator').run_and_move()<cr>" },
    {
      "<C-S-CR>",
      -- molten directo sobre el rango de la celda; evita que el provider de
      -- NotebookNavigator inserte un "# %%" al correr la última celda
      function()
        local cell = require("notebook-navigator").miniai_spec("i")
        pcall(vim.fn.MoltenEvaluateRange, cell.from.line, cell.to.line)
      end,
      mode = { "n", "i" },
      desc = "Run cell (# %%) en molten",
    },
    {
      "<C-S-/>",
      "<cmd>lua require('notebook-navigator').add_cell_below()<cr>",
      mode = { "n", "i" },
      desc = "Nueva celda # %% debajo",
    },
    {
      -- fallback: nvim puede normalizar shift+"/" a "?"
      "<C-?>",
      "<cmd>lua require('notebook-navigator').add_cell_below()<cr>",
      mode = { "n", "i" },
      desc = "Nueva celda # %% debajo",
    },
  },
  dependencies = {
    "nvim-mini/mini.comment",
    "hkupty/iron.nvim",
    "nvimtools/hydra.nvim", -- swapped from anuvyklack/hydra.nvim
  },
  event = "VeryLazy",
  config = function()
    -- iron necesita su propio setup; sin él repl_open_cmd queda nil y vim.cmd(nil) revienta
    require("iron.core").setup({
      config = { repl_open_cmd = "botright vsplit" },
    })

    local nn = require("notebook-navigator")
    nn.setup({
      activate_hydra_keys = "<leader>h",
      syntax_highlight = true, -- resalta la línea "# %%" para ver la celda
      cell_highlight_group = "CursorLine",
      repl_provider = "molten",
    })
  end,
}
