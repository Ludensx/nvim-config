# 🚀 Mi Configuración de Neovim

Configuración personal de Neovim optimizada para desarrollo web (NestJS, React, TypeScript) en Arch Linux.

![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white)

## ✨ Características

- 🎨 **LSP nativo** - Soporte para múltiples lenguajes con Neovim 0.11+
- 🔍 **Telescope** - Búsqueda difusa de archivos
- 📁 **Neo-tree** - Explorador de archivos lateral
- 💡 **nvim-cmp** - Autocompletado inteligente
- 🎯 **Treesitter** - Syntax highlighting mejorado
- 🌿 **Gitsigns** - Integración con Git
- 📊 **Bufferline** - Pestañas para archivos abiertos
- 🎨 **Lualine** - Statusline moderna
- 🔧 **Autopairs** - Auto-cierre de paréntesis
- 💬 **Comment.nvim** - Comentarios rápidos

## 📋 Requisitos

- **Neovim** >= 0.11.0
- **Git** >= 2.19.0
- **Node.js** >= 18.0 (para LSP servers)
- **ripgrep** (para Telescope)
- **fd** (opcional, para mejor búsqueda)
- Una **Nerd Font** (recomendado: JetBrains Mono Nerd Font)

### Arch Linux

```bash
sudo pacman -S neovim git nodejs npm ripgrep fd ttf-jetbrains-mono-nerd
```

## 🚀 Instalación

### 1. Hacer backup de tu configuración actual (si existe)

```bash
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
```

### 2. Clonar este repositorio

```bash
git clone https://github.com/Ludensx/nvim-config.git ~/.config/nvim
```

### 3. Abrir Neovim

```bash
nvim
```

Lazy.nvim se instalará automáticamente y descargará todos los plugins.

### 4. Instalar Language Servers

```bash
# TypeScript/JavaScript
npm install -g typescript typescript-language-server

# HTML/CSS/JSON
npm install -g vscode-langservers-extracted

# Lua
sudo pacman -S lua-language-server

# Python
sudo pacman -S python-lsp-server

# Otros según necesites...
```

Verifica los servidores instalados con `:LspInstalled` dentro de Neovim.

## 🎯 Lenguajes Soportados

- ✅ TypeScript/JavaScript (React, NestJS, Express)
- ✅ HTML/CSS
- ✅ JSON/YAML
- ✅ Lua
- ✅ Python
- ✅ Rust
- ✅ Docker
- ✅ SQL
- ✅ Markdown

## ⌨️ Atajos Principales

> `<leader>` está configurado como `espacio`

### General
- `<leader>e` - Abrir/cerrar explorador de archivos
- `Ctrl+p` - Buscar archivos
- `Ctrl+f` - Buscar en archivos
- `Ctrl+s` - Guardar archivo
- `gcc` - Comentar/descomentar línea
- `K` - Ver documentación (LSP)

### Navegación
- `Tab` / `Shift+Tab` - Siguiente/anterior buffer
- `Ctrl+h/j/k/l` - Moverse entre ventanas
- `<leader>sv` - Split vertical
- `<leader>sh` - Split horizontal

### LSP
- `gd` - Ir a definición
- `gr` - Ver referencias
- `<leader>rn` - Renombrar
- `<leader>ca` - Acciones de código
- `[d` / `]d` - Diagnóstico anterior/siguiente

### Git
- `]c` / `[c` - Siguiente/anterior cambio
- `<leader>hp` - Preview cambio
- `<leader>hs` - Stage cambio
- `<leader>hr` - Reset cambio
- `<leader>hb` - Git blame

### Terminal
- `Ctrl+\` - Abrir/cerrar terminal
- `<leader>th` - Terminal horizontal
- `<leader>tf` - Terminal flotante
- `<leader>gg` - LazyGit (si está instalado)

## 📁 Estructura

```
~/.config/nvim/
├── init.lua                 # Punto de entrada
├── lua/
│   ├── config/
│   │   ├── options.lua      # Opciones generales
│   │   ├── keymaps.lua      # Atajos de teclado
│   │   ├── lazy.lua         # Configuración de Lazy
│   │   ├── lsp.lua          # Configuración LSP
│   │   └── windows.lua      # Gestión de ventanas
│   └── plugins/
│       ├── neo-tree.lua     # Explorador de archivos
│       ├── telescope.lua    # Búsqueda difusa
│       ├── bufferline.lua   # Pestañas
│       ├── nvim-cmp.lua     # Autocompletado
│       ├── gitsigns.lua     # Integración Git
│       ├── comment.lua      # Comentarios
│       ├── autopairs.lua    # Auto-cerrar pares
│       ├── lualine.lua      # Statusline
│       └── ...
├── .gitignore
└── README.md
```

## 🎨 Personalización

### Cambiar el tema de colores

Edita `lua/plugins/` y agrega tu tema favorito. Ejemplo:

```lua
return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    vim.cmd.colorscheme "catppuccin-mocha"
  end,
}
```

### Agregar un nuevo LSP

1. Instala el servidor: `npm install -g nombre-del-servidor`
2. Edita `lua/config/lsp.lua`
3. Agrega el filetype al `pattern` y la configuración correspondiente

Ver documentación en el código para más detalles.

## 🐛 Troubleshooting

### Los plugins no se instalan

```vim
:Lazy sync
```

### LSP no funciona

1. Verifica que el servidor esté instalado: `which nombre-servidor`
2. Revisa los logs: `:LspLog`
3. Verifica servidores disponibles: `:LspInstalled`

### Iconos no se ven correctamente

Instala una Nerd Font y configúrala en tu terminal.

## 📚 Recursos

- [Documentación de Neovim](https://neovim.io/doc/)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [LSP Config](https://github.com/neovim/nvim-lspconfig)
- [Awesome Neovim](https://github.com/rockerBOO/awesome-neovim)

## 📝 Notas

Esta configuración está optimizada para:
- Arch Linux
- Neovim 0.11+
- Desarrollo web (NestJS, React, TypeScript)
- Trabajo con Git

## 📄 Licencia

MIT License - siéntete libre de usar y modificar esta configuración.

## 🙏 Créditos

Configuración personal inspirada en la comunidad de Neovim.
Recopila información de diferentes fuentes, principalmente documenteción oficial y Claude(Sonnet 4.5).

---

⭐ Si te fue útil, dale una estrella al repo!
