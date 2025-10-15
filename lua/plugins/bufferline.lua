-- ~/.config/nvim/lua/plugins/bufferline.lua
-- Pestañas superiores para ver archivos abiertos (como VSCode)

return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require("bufferline").setup({
      options = {
        mode = "buffers", -- "tabs" o "buffers"
        
        -- Estilo de las pestañas
        style_preset = require("bufferline").style_preset.default,
        themable = true,
        
        -- Números en las pestañas
        numbers = "none", -- "none" | "ordinal" | "buffer_id" | "both"
        
        -- Indicador de buffer actual
        indicator = {
          icon = '▎',
          style = 'icon', -- 'icon' | 'underline' | 'none'
        },
        
        -- Botón para cerrar buffers
        buffer_close_icon = '󰅖',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        
        -- Longitud máxima del nombre
        max_name_length = 18,
        max_prefix_length = 15,
        truncate_names = true,
        tab_size = 18,
        
        -- Diagnósticos LSP en las pestañas
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
        
        -- Mostrar solo si hay más de un buffer
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        show_duplicate_prefix = true,
        
        -- Separadores
        separator_style = "thin", -- "slant" | "slope" | "thick" | "thin" | { 'any', 'any' }
        
        -- Comportamiento
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        auto_toggle_bufferline = true,
        
        -- Ordenar buffers
        sort_by = 'insert_after_current', -- 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs'
        
        -- Offset para Neo-tree (no sobreponer el explorador)
        offsets = {
          {
            filetype = "neo-tree",
            text = "📁 Explorador",
            text_align = "center",
            separator = true,
          }
        },
        
        -- Colores personalizados según el estado
        color_icons = true,
        get_element_icon = function(element)
          local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
          return icon, hl
        end,
        
        -- Hover muestra información
        hover = {
          enabled = true,
          delay = 200,
          reveal = {'close'}
        },
      },
    })
    
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- ATAJOS DE TECLADO PARA NAVEGACIÓN
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    
    -- Navegar entre buffers (pestañas)
    vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>', { desc = 'Siguiente buffer', silent = true })
    vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { desc = 'Buffer anterior', silent = true })
    
    -- Ir a buffer específico con Alt+número
    vim.keymap.set('n', '<A-1>', '<Cmd>BufferLineGoToBuffer 1<CR>', { desc = 'Ir a buffer 1' })
    vim.keymap.set('n', '<A-2>', '<Cmd>BufferLineGoToBuffer 2<CR>', { desc = 'Ir a buffer 2' })
    vim.keymap.set('n', '<A-3>', '<Cmd>BufferLineGoToBuffer 3<CR>', { desc = 'Ir a buffer 3' })
    vim.keymap.set('n', '<A-4>', '<Cmd>BufferLineGoToBuffer 4<CR>', { desc = 'Ir a buffer 4' })
    vim.keymap.set('n', '<A-5>', '<Cmd>BufferLineGoToBuffer 5<CR>', { desc = 'Ir a buffer 5' })
    vim.keymap.set('n', '<A-6>', '<Cmd>BufferLineGoToBuffer 6<CR>', { desc = 'Ir a buffer 6' })
    vim.keymap.set('n', '<A-7>', '<Cmd>BufferLineGoToBuffer 7<CR>', { desc = 'Ir a buffer 7' })
    vim.keymap.set('n', '<A-8>', '<Cmd>BufferLineGoToBuffer 8<CR>', { desc = 'Ir a buffer 8' })
    vim.keymap.set('n', '<A-9>', '<Cmd>BufferLineGoToBuffer 9<CR>', { desc = 'Ir a buffer 9' })
    
    -- Mover buffers
    vim.keymap.set('n', '<A-<>', ':BufferLineMovePrev<CR>', { desc = 'Mover buffer izquierda', silent = true })
    vim.keymap.set('n', '<A->>', ':BufferLineMoveNext<CR>', { desc = 'Mover buffer derecha', silent = true })
    
    -- Cerrar buffers
    vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { desc = 'Cerrar buffer actual', silent = true })
    vim.keymap.set('n', '<leader>bD', ':bdelete!<CR>', { desc = 'Forzar cerrar buffer', silent = true })
    vim.keymap.set('n', '<leader>bo', ':BufferLineCloseOthers<CR>', { desc = 'Cerrar otros buffers', silent = true })
    vim.keymap.set('n', '<leader>br', ':BufferLineCloseRight<CR>', { desc = 'Cerrar buffers a la derecha', silent = true })
    vim.keymap.set('n', '<leader>bl', ':BufferLineCloseLeft<CR>', { desc = 'Cerrar buffers a la izquierda', silent = true })
    
    -- Ordenar buffers
    vim.keymap.set('n', '<leader>be', ':BufferLineSortByExtension<CR>', { desc = 'Ordenar por extensión', silent = true })
    vim.keymap.set('n', '<leader>bt', ':BufferLineSortByDirectory<CR>', { desc = 'Ordenar por directorio', silent = true })
    
    -- Pick buffer (selector interactivo)
    vim.keymap.set('n', '<leader>bp', ':BufferLinePick<CR>', { desc = 'Elegir buffer', silent = true })
  end,
}
