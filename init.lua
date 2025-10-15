-- init.lua - Punto de entrada de Neovim
-- Este archivo se ejecuta cuando abres nvim

-- Cargar opciones básicas
require("config.options")

-- Cargar keymaps (atajos de teclado)
require("config.keymaps")

-- Cargar gestor de plugins
require("config.lazy")

-- Cargar LSP
require("config.lsp")

