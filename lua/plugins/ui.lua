-- plugins/ui.lua
-- Interfaz minimalista: statusline simple y limpia

return {
  -- Lualine - statusline minimalista
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",  -- Se adapta a tu colorscheme
          component_separators = { left = "|", right = "|" },
          section_separators = { left = "", right = "" },
          globalstatus = true,  -- Una sola statusline para todas las ventanas
        },
        sections = {
          -- Lado izquierdo
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff" },
          lualine_c = { 
            {
              "filename",
              path = 1,  -- Ruta relativa
              symbols = {
                modified = " ●",
                readonly = " ",
                unnamed = "[Sin nombre]",
              },
            },
          },
          
          -- Lado derecho
          lualine_x = {
            {
              "diagnostics",
              sources = { "nvim_lsp" },
              symbols = { error = " ", warn = " ", info = " ", hint = " " },
            },
            "encoding",
            "fileformat",
            "filetype",
          },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        extensions = { "nvim-tree", "toggleterm" },
      })
    end,
  },

  -- Iconos (necesarios para lualine y otros plugins)
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({
        default = true,
      })
    end,
  },

  -- Indent guides sutiles (líneas verticales de indentación)
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("ibl").setup({
        indent = {
          char = "│",
          tab_char = "│",
        },
        scope = { enabled = false },  -- Sin resaltado de scope (más minimalista)
        exclude = {
          filetypes = {
            "help",
            "alpha",
            "dashboard",
            "neo-tree",
            "Trouble",
            "lazy",
            "mason",
          },
        },
      })
    end,
  },
}
