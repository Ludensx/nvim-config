-- plugins/colorscheme.lua
-- Tema de colores que combina con tu setup de qtile

return {
  -- Tokyo Night - minimalista, oscuro, colores vibrantes
  {
    "folke/tokyonight.nvim",
    lazy = false,  -- Cargar inmediatamente
    priority = 1000,  -- Cargar antes que otros plugins
    config = function()
      require("tokyonight").setup({
        style = "night",  -- night, storm, moon, day
        transparent = true,  -- Fondo transparente
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = false },
          functions = { bold = true },
          variables = {},
          sidebars = "transparent",  -- Sidebars transparentes
          floats = "transparent",    -- Ventanas flotantes transparentes
        },
        -- Personalizar colores para combinar con tu setup
        on_colors = function(colors)
          colors.bg = "#1c1c1c"           -- Tu bg_primary
          colors.bg_dark = "#1c1c1c"
          colors.bg_float = "#1c1c1c"
          colors.bg_sidebar = "#1c1c1c"
          colors.blue = "#1793d1"         -- Tu arch_blue
          colors.blue1 = "#4a90e2"        -- Tu accent
          colors.green = "#2ecc71"        -- Tu success
          colors.red = "#e74c3c"          -- Tu urgent
        end,
        on_highlights = function(hl, c)
          -- Cursor con tu color azul de Arch
          hl.Cursor = { fg = c.bg, bg = c.blue }
          hl.CursorLine = { bg = "#2d2d2d" }  -- Tu bg_secondary
          
          -- Números de línea más sutiles
          hl.LineNr = { fg = "#5a5a5a" }
          hl.CursorLineNr = { fg = c.blue, bold = true }
        end,
      })
      
      -- Activar el tema
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
}
