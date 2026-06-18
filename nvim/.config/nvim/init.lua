-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
-- Configuración personal
vim.opt.clipboard = "unnamedplus"

-- Atajo para abrir init.lua
vim.keymap.set("n", "<leader>ev", ":e ~/.config/nvim/init.lua<CR>", { noremap = true })
-- Sigue la linea anterior
vim.opt.whichwrap = vim.opt.whichwrap + "<,>,[,],h,l"
