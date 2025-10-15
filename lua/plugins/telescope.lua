-- ~/.config/nvim/lua/plugins/telescope.lua
-- Búsqueda difusa de archivos (como Ctrl+P en VSCode)

return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- FZF nativo para mejor rendimiento (opcional pero recomendado)
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    
    telescope.setup({
      defaults = {
        prompt_prefix = " 🔍 ",
        selection_caret = " ➤ ",
        path_display = { "truncate" },
        
        -- Configuración de ventana
        layout_strategy = 'horizontal',
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        sorting_strategy = "ascending",
        
        -- Mapeos de teclas dentro de Telescope
        mappings = {
          i = { -- Modo inserción
            ["<C-n>"] = actions.move_selection_next,
            ["<C-p>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-c>"] = actions.close,
            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,
            ["<CR>"] = actions.select_default,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,
            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
            ["<PageUp>"] = actions.results_scrolling_up,
            ["<PageDown>"] = actions.results_scrolling_down,
            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-l>"] = actions.complete_tag,
            ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
          },
          n = { -- Modo normal
            ["<esc>"] = actions.close,
            ["<CR>"] = actions.select_default,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,
            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["j"] = actions.move_selection_next,
            ["k"] = actions.move_selection_previous,
            ["H"] = actions.move_to_top,
            ["M"] = actions.move_to_middle,
            ["L"] = actions.move_to_bottom,
            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,
            ["gg"] = actions.move_to_top,
            ["G"] = actions.move_to_bottom,
            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
            ["<PageUp>"] = actions.results_scrolling_up,
            ["<PageDown>"] = actions.results_scrolling_down,
            ["?"] = actions.which_key,
          },
        },
      },
      pickers = {
        find_files = {
          theme = "dropdown",
          previewer = false,
          hidden = true, -- Mostrar archivos ocultos
        },
        live_grep = {
          theme = "dropdown",
        },
        buffers = {
          theme = "dropdown",
          previewer = false,
          initial_mode = "normal",
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })
    
    -- Cargar extensión FZF si está disponible
    pcall(telescope.load_extension, 'fzf')
    
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    -- ATAJOS DE TECLADO (estilo VSCode)
    -- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    
    local builtin = require('telescope.builtin')
    
    -- Buscar archivos (Ctrl+P en VSCode)
    vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Buscar archivos' })
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
    
    -- Buscar en el contenido de archivos (Ctrl+Shift+F en VSCode)
    vim.keymap.set('n', '<C-f>', builtin.live_grep, { desc = 'Buscar en archivos' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep' })
    
    -- Ver buffers abiertos (Ctrl+Tab en VSCode)
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find Buffers' })
    vim.keymap.set('n', '<leader><tab>', builtin.buffers, { desc = 'Ver buffers' })
    
    -- Buscar en archivos recientes
    vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Recent Files' })
    
    -- Buscar en el buffer actual
    vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = 'Buscar en buffer' })
    
    -- Buscar ayuda de Neovim
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help Tags' })
    
    -- Buscar comandos
    vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = 'Commands' })
    
    -- Buscar en Git
    vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Git Files' })
    vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = 'Git Commits' })
    vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Git Branches' })
    
    -- Buscar símbolos LSP en el archivo actual
    vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = 'Document Symbols' })
    
    -- Buscar símbolos LSP en el workspace
    vim.keymap.set('n', '<leader>fS', builtin.lsp_workspace_symbols, { desc = 'Workspace Symbols' })
    
    -- Buscar diagnósticos
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Diagnostics' })
  end,
}
