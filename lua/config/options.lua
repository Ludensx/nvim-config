-- config/options.lua
-- Opciones básicas de comportamiento de Neovim

local opt = vim.opt

-- Numeración de líneas
opt.number = true           -- Mostrar números de línea
opt.relativenumber = true   -- Números relativos (útil para movimientos)

-- Indentación
opt.tabstop = 2            -- Tamaño del tab visual
opt.shiftwidth = 2         -- Tamaño de indentación
opt.expandtab = true       -- Convertir tabs a espacios
opt.autoindent = true      -- Mantener indentación
opt.smartindent = true     -- Indentación inteligente

-- Búsqueda
opt.ignorecase = true      -- Ignorar mayúsculas en búsqueda
opt.smartcase = true       -- Ser sensible si usas mayúsculas

-- Apariencia
opt.termguicolors = true   -- Colores de 24-bit (importante para temas)
opt.signcolumn = "yes"     -- Columna de signos siempre visible (para LSP)
opt.cursorline = true      -- Resaltar línea actual
opt.wrap = false           -- No dividir líneas largas

-- Comportamiento
opt.mouse = "a"            -- Habilitar mouse
opt.clipboard = "unnamedplus"  -- Usar clipboard del sistema
opt.undofile = true        -- Guardar historial de deshacer
opt.swapfile = false       -- No crear archivos swap

-- Split windows
opt.splitright = true      -- Split vertical a la derecha
opt.splitbelow = true      -- Split horizontal abajo

-- Tiempo de espera para comandos
opt.updatetime = 250       -- Más rápido para autocompletado y LSP
opt.timeoutlen = 300       -- Tiempo para secuencias de teclas

-- Scrolling
opt.scrolloff = 8          -- Mantener 8 líneas visibles arriba/abajo del cursor

-- Mostrar caracteres invisibles (opcional, puedes desactivar)
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
