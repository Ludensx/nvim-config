-- ~/.config/nvim/lua/plugins/neo-tree.lua
-- Explorador de archivos estilo VSCode

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- iconos de archivos
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true, -- Cerrar Neo-tree si es la última ventana
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      
      -- Apariencia
      default_component_configs = {
        indent = {
          indent_size = 2,
          padding = 1,
          with_markers = true,
          indent_marker = "│",
          last_indent_marker = "└",
          with_expanders = true,
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "",
          default = "",
        },
        modified = {
          symbol = "●",
        },
        name = {
          trailing_slash = false,
          use_git_status_colors = true,
        },
        git_status = {
          symbols = {
            -- Símbolos de estado Git
            added     = "✚",
            modified  = "",
            deleted   = "✖",
            renamed   = "➜",
            untracked = "★",
            ignored   = "◌",
            unstaged  = "✗",
            staged    = "✓",
            conflict  = "",
          }
        },
      },
      
      -- Configuración de la ventana
      window = {
        position = "right",
        width = 30,
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        mappings = {
          -- Navegación básica
          ["<space>"] = "toggle_node",
          ["<cr>"] = "open",
          ["<esc>"] = "cancel",
          ["P"] = { "toggle_preview", config = { use_float = true } },
          
          -- Abrir archivos en diferentes modos
          ["s"] = "open_split",          -- Abrir en split horizontal
          ["v"] = "open_vsplit",         -- Abrir en split vertical
          ["t"] = "open_tabnew",         -- Abrir en nueva pestaña
          
          -- Operaciones de archivos
          ["a"] = "add",                 -- Crear archivo/carpeta
          ["d"] = "delete",              -- Eliminar
          ["r"] = "rename",              -- Renombrar
          ["y"] = "copy_to_clipboard",   -- Copiar
          ["x"] = "cut_to_clipboard",    -- Cortar
          ["p"] = "paste_from_clipboard",-- Pegar
          ["c"] = "copy",                -- Copiar (interno)
          ["m"] = "move",                -- Mover
          
          -- Navegación
          ["<bs>"] = "navigate_up",      -- Subir un nivel
          ["."] = "set_root",            -- Establecer como raíz
          ["H"] = "toggle_hidden",       -- Mostrar/ocultar archivos ocultos
          ["/"] = "fuzzy_finder",        -- Búsqueda difusa
          ["D"] = "fuzzy_finder_directory",
          
          -- Refresh
          ["R"] = "refresh",
          
          -- Ayuda
          ["?"] = "show_help",
          
          -- Git
          ["gu"] = "git_unstage_file",
          ["ga"] = "git_add_file",
          ["gc"] = "git_commit",
          ["gp"] = "git_push",
        },
      },
      
      filesystem = {
        filtered_items = {
          visible = false, -- Mostrar archivos filtrados en gris
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = true, -- solo funciona en Windows
          hide_by_name = {
            "node_modules",
            ".git",
            ".DS_Store",
          },
          hide_by_pattern = {
            --"*.meta",
          },
          always_show = {
            ".env",
            ".gitignore",
          },
          never_show = {
            ".DS_Store",
            "thumbs.db",
          },
        },
        follow_current_file = {
          enabled = true, -- Destacar el archivo actual
          leave_dirs_open = false,
        },
        group_empty_dirs = false,
        hijack_netrw_behavior = "open_default",
        use_libuv_file_watcher = true, -- Auto-refresh cuando cambian archivos
        window = {
          mappings = {
            ["<bs>"] = "navigate_up",
            ["."] = "set_root",
            ["H"] = "toggle_hidden",
            ["/"] = "fuzzy_finder",
            ["D"] = "fuzzy_finder_directory",
            ["f"] = "filter_on_submit",
            ["<c-x>"] = "clear_filter",
          },
        },
      },
      
      -- Configuración para buffers
      buffers = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = false,
        },
        group_empty_dirs = true,
        show_unloaded = true,
      },
      
      -- Configuración para Git
      git_status = {
        window = {
          position = "float",
          mappings = {
            ["A"]  = "git_add_all",
            ["gu"] = "git_unstage_file",
            ["ga"] = "git_add_file",
            ["gr"] = "git_revert_file",
            ["gc"] = "git_commit",
            ["gp"] = "git_push",
            ["gg"] = "git_commit_and_push",
          }
        }
      },
    })
    
    -- Atajos de teclado para Neo-tree
    vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { desc = 'Toggle Neo-tree' })
    vim.keymap.set('n', '<leader>o', ':Neotree focus<CR>', { desc = 'Focus Neo-tree' })
    vim.keymap.set('n', '<leader>gs', ':Neotree git_status<CR>', { desc = 'Git status' })
  end,
}
