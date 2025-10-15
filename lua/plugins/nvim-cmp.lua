-- ~/.config/nvim/lua/plugins/nvim-cmp.lua
-- Autocompletado inteligente (como IntelliSense de VSCode)

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    -- Fuentes de autocompletado
    "hrsh7th/cmp-nvim-lsp",     -- LSP
    "hrsh7th/cmp-buffer",        -- Palabras del buffer
    "hrsh7th/cmp-path",          -- Rutas de archivos
    "hrsh7th/cmp-cmdline",       -- Comandos de Neovim
    
    -- Snippets (fragmentos de código)
    "L3MON4D3/LuaSnip",          -- Motor de snippets
    "saadparwaiz1/cmp_luasnip",  -- Integración con cmp
    "rafamadriz/friendly-snippets", -- Colección de snippets predefinidos
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    
    -- Cargar snippets predefinidos (como los de VSCode)
    require("luasnip.loaders.from_vscode").lazy_load()
    
    cmp.setup({
      -- Motor de snippets
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      
      -- Ventana de completado
      window = {
        completion = cmp.config.window.bordered({
          border = "rounded",
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        }),
        documentation = cmp.config.window.bordered({
          border = "rounded",
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        }),
      },
      
      -- Mapeo de teclas
      mapping = cmp.mapping.preset.insert({
        -- Navegar por las sugerencias
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        
        -- Scroll en la documentación
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        
        -- Abrir/cerrar completado
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        
        -- Confirmar selección
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
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
      
      -- Fuentes de sugerencias (en orden de prioridad)
      sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 },  -- LSP (más importante)
        { name = "luasnip", priority = 750 },    -- Snippets
        { name = "path", priority = 500 },       -- Rutas de archivos
        { name = "buffer", priority = 250 },     -- Palabras del buffer actual
      }),
      
      -- Formato de las sugerencias
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, item)
          -- Iconos para cada tipo de sugerencia
          local icons = {
            Text = "󰉿",
            Method = "󰆧",
            Function = "󰊕",
            Constructor = "",
            Field = "󰜢",
            Variable = "󰀫",
            Class = "󰠱",
            Interface = "",
            Module = "",
            Property = "󰜢",
            Unit = "󰑭",
            Value = "󰎠",
            Enum = "",
            Keyword = "󰌋",
            Snippet = "",
            Color = "󰏆",
            File = "󰈙",
            Reference = "󰈇",
            Folder = "󰉋",
            EnumMember = "",
            Constant = "󰏿",
            Struct = "󰙅",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "",
          }
          
          -- Establecer el icono
          item.kind = string.format("%s %s", icons[item.kind] or "", item.kind)
          
          -- Mostrar de dónde viene la sugerencia
          item.menu = ({
            nvim_lsp = "[LSP]",
            luasnip = "[Snippet]",
            buffer = "[Buffer]",
            path = "[Path]",
          })[entry.source.name]
          
          return item
        end,
      },
      
      -- Comportamiento
      experimental = {
        ghost_text = true, -- Mostrar sugerencia en gris (como GitHub Copilot)
      },
    })
    
    -- Autocompletado en la línea de comandos
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
        { name = "cmdline" },
      }),
    })
    
    -- Autocompletado en búsquedas
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })
  end,
}
