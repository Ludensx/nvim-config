-- config/lazy.lua
-- Configuración del gestor de plugins lazy.nvim

-- Instalar lazy.nvim automáticamente si no existe
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Configurar lazy.nvim
require("lazy").setup({
  -- Los plugins se cargarán desde lua/plugins/*.lua
  { import = "plugins" },
}, {
  -- Configuración de lazy.nvim
  checker = {
    enabled = false,  -- No verificar actualizaciones automáticamente
  },
  change_detection = {
    enabled = true,
    notify = false,   -- No notificar cambios en archivos
  },
  ui = {
    border = "rounded",  -- Bordes redondeados (estética minimalista)
  },
})
