-- ~/.config/nvim/lua/plugins/comment.lua
-- Comentar/descomentar código fácilmente (como Ctrl+/ en VSCode)

return {
  'numToStr/Comment.nvim',
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring", -- Comentarios context-aware
  },
  config = function()
    require('Comment').setup({
      -- Agregar espacio después del comentario
      padding = true,
      
      -- Mantener cursor en su posición
      sticky = true,
      
      -- Ignorar líneas vacías
      ignore = '^$',
      
      -- Integración con treesitter para comentarios inteligentes
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      
      -- Mappings
      toggler = {
        line = 'gcc',  -- Comentar línea actual
        block = 'gbc', -- Comentar bloque
      },
      opleader = {
        line = 'gc',   -- Operador de línea
        block = 'gb',  -- Operador de bloque
      },
      extra = {
        above = 'gcO', -- Comentar línea arriba
        below = 'gco', -- Comentar línea abajo
        eol = 'gcA',   -- Comentar al final de línea
      },
      mappings = {
        basic = true,
        extra = true,
      },
    })
    
    -- Atajo adicional para comentar en modo visual (como Ctrl+/ en VSCode)
    vim.keymap.set('n', '<C-_>', 'gcc', { remap = true, desc = 'Comentar línea' })
    vim.keymap.set('v', '<C-_>', 'gc', { remap = true, desc = 'Comentar selección' })
    -- Nota: Ctrl+/ se detecta como Ctrl+_ en terminals
  end,
}
