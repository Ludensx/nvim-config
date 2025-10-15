-- plugins/treesitter.lua
-- Syntax highlighting muy mejorado con muchos colores

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        -- Lenguajes a instalar automáticamente
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          "javascript",
          "typescript",
          "tsx",
          "html",
          "css",
          "python",
          "json",
          "yaml",
          "markdown",
          "bash",
        },
        
        -- Instalar parsers automáticamente
        auto_install = true,
        
        -- Highlighting mejorado
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        
        -- Indentación basada en treesitter
        indent = {
          enable = true,
        },
        
        -- Selección incremental (opcional pero útil)
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
      })
    end,
  },
}
