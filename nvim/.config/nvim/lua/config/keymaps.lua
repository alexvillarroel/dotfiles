-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Molten Python bindings
vim.keymap.set("n", "<leader>ml", ":MoltenEvaluateLine<cr>", { desc = "Molten: Evaluar Línea" })
vim.keymap.set("n", "<leader>mc", ":MoltenReevaluateCell<cr>", { desc = "Molten: Evaluar Celda" })
vim.keymap.set("v", "<leader>ml", ":<C-u>MoltenEvaluateVisual<cr>gv", { desc = "Molten: Evaluar Selección" })
vim.keymap.set("n", "<leader>mi", ":MoltenInit<cr>", { desc = "Molten: Inicializar" })
-- Ctrl+l: quitar el output persistente de la celda actual (y limpiar resaltado de búsqueda)
vim.keymap.set("n", "<C-l>", function()
  local ok, err = pcall(vim.cmd, "MoltenDelete")
  if not ok then
    vim.notify("MoltenDelete falló: " .. tostring(err), vim.log.levels.WARN)
  end
  vim.cmd("nohlsearch")
end, { desc = "Molten: borrar output de la celda" })
-- Personal bindings
vim.keymap.set("n", "<leader>cp", ':let @+ = expand("%:p")<CR>', { desc = "Copiar ruta absoluta del archivo" })

-- Comentar como gc con Ctrl+/ (mapeo <C-_> por si el terminal no manda <C-/>)
for _, key in ipairs({ "<C-/>", "<C-_>" }) do
  vim.keymap.set("n", key, "gcc", { remap = true, desc = "Toggle comentario línea" })
  vim.keymap.set("x", key, "gc", { remap = true, desc = "Toggle comentario selección" })
end
