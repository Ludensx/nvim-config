-- ~/.config/nvim/lua/plugins/bufdelete.lua
-- Cerrar buffers sin cerrar ventanas (como cerrar pestañas en VSCode)

return {
  "moll/vim-bbye",
  event = "VeryLazy",
  config = function()
    -- Reemplazar los atajos en bufferline.lua
    vim.keymap.set('n', '<leader>bd', ':Bdelete<CR>', { desc = 'Cerrar buffer', silent = true })
    vim.keymap.set('n', '<leader>bD', ':Bdelete!<CR>', { desc = 'Forzar cerrar buffer', silent = true })
    
    -- Atajo alternativo con Ctrl+W (como en VSCode/navegadores)
    vim.keymap.set('n', '<C-w>', ':Bdelete<CR>', { desc = 'Cerrar buffer', silent = true })
  end,
}
