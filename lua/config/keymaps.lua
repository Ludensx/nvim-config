-- config/keymaps.lua
-- Atajos de teclado personalizados

-- Líder key: La tecla que usarás para la mayoría de comandos
vim.g.mapleader = " "        -- Espacio como líder
vim.g.maplocalleader = " "

local keymap = vim.keymap.set

-- Modo normal --

-- Mejor navegación de ventanas
keymap("n", "<C-h>", "<C-w>h", { desc = "Ir a ventana izquierda" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Ir a ventana abajo" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Ir a ventana arriba" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Ir a ventana derecha" })

-- Resize de ventanas
keymap("n", "<C-Up>", ":resize +2<CR>", { desc = "Aumentar altura" })
keymap("n", "<C-Down>", ":resize -2<CR>", { desc = "Disminuir altura" })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Disminuir ancho" })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Aumentar ancho" })

-- Navegación de buffers
keymap("n", "<S-l>", ":bnext<CR>", { desc = "Buffer siguiente" })
keymap("n", "<S-h>", ":bprevious<CR>", { desc = "Buffer anterior" })
keymap("n", "<leader>x", ":bdelete<CR>", { desc = "Cerrar buffer" })

-- Guardar y salir rápido
keymap("n", "<leader>w", ":w<CR>", { desc = "Guardar archivo" })
keymap("n", "<leader>q", ":q<CR>", { desc = "Salir" })

-- Limpiar resaltado de búsqueda
keymap("n", "<Esc>", ":noh<CR>", { desc = "Limpiar búsqueda" })

-- Mover líneas arriba/abajo
keymap("n", "<A-j>", ":m .+1<CR>==", { desc = "Mover línea abajo" })
keymap("n", "<A-k>", ":m .-2<CR>==", { desc = "Mover línea arriba" })

-- Modo visual --

-- Mantener selección al indentar
keymap("v", "<", "<gv", { desc = "Indentar izquierda" })
keymap("v", ">", ">gv", { desc = "Indentar derecha" })

-- Mover bloques de texto
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Mover bloque abajo" })
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Mover bloque arriba" })

-- Mejor paste (no pierde lo copiado)
keymap("v", "p", '"_dP', { desc = "Paste sin perder clipboard" })

-- Modo insert --

-- Salir del modo insert
keymap("i", "jk", "<ESC>", { desc = "Salir de insert mode" })
keymap("i", "kj", "<ESC>", { desc = "Salir de insert mode" })
