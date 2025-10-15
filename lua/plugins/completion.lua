-- plugins/completion.lua
-- Autocompletado inteligente mientras escribes

return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",     -- Autocompletado desde LSP
      "hrsh7th/cmp-buffer",       -- Autocompletado desde buffer
      "hrsh7th/cmp-path",         -- Autocompletado de rutas
      "L3MON4D3/LuaSnip",         -- Motor de snippets
      "saadparwaiz1/cmp_luasnip", -- Snippets para cmp
      "rafamadriz/friendly-snippets", -- Snippets predefinidos
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- Cargar snippets predefinidos
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        -- Apariencia de la ventana de autocompletado
        window = {
          completion = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
          }),
          documentation = cmp.config.window.bordered({
            border = "rounded",
          }),
        },

        -- Atajos de teclado
        mapping = cmp.mapping.preset.insert({
          -- Navegar en el menú
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          
          -- Scroll en documentación
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          
          -- Mostrar/ocultar autocompletado
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          
          -- Confirmar selección
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),

        -- Fuentes de autocompletado (en orden de prioridad)
        sources = cmp.config.sources({
          { name = "nvim_lsp" },    -- LSP
          { name = "luasnip" },     -- Snippets
          { name = "buffer" },      -- Texto del buffer actual
          { name = "path" },        -- Rutas de archivos
        }),

        -- Iconos y formato de items
        formatting = {
          format = function(entry, vim_item)
            -- Iconos para cada tipo
            local icons = {
              Text = "",
              Method = "",
              Function = "",
              Constructor = "",
              Field = "",
              Variable = "",
              Class = "",
              Interface = "",
              Module = "",
              Property = "",
              Unit = "",
              Value = "",
              Enum = "",
              Keyword = "",
              Snippet = "",
              Color = "",
              File = "",
              Reference = "",
              Folder = "",
              EnumMember = "",
              Constant = "",
              Struct = "",
              Event = "",
              Operator = "",
              TypeParameter = "",
            }

            vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]

            return vim_item
          end,
        },

        -- Comportamiento
        experimental = {
          ghost_text = true,  -- Mostrar preview del autocompletado
        },
      })
    end,
  },
}
