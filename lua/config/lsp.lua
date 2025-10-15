-- ~/.config/nvim/lua/config/lsp.lua
-- Configuración LSP mínima para Neovim 0.11.4

--print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
--print("🔧 Cargando configuración LSP")
--print("📌 Neovim version: " .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch)

-- Capacidades mejoradas con nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- Intentar cargar capacidades de nvim-cmp si está instalado
local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if status_ok then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

-- Función on_attach: se ejecuta cuando LSP se conecta
local on_attach = function(client, bufnr)
--  print("✅ LSP '" .. client.name .. "' conectado al buffer " .. bufnr)
  
  -- Atajos de teclado
  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
  end
  
  map('n', 'gd', vim.lsp.buf.definition, 'Ir a definición')
  map('n', 'gD', vim.lsp.buf.declaration, 'Ir a declaración')
  map('n', 'gr', vim.lsp.buf.references, 'Ver referencias')
  map('n', 'gi', vim.lsp.buf.implementation, 'Ir a implementación')
  map('n', 'K', vim.lsp.buf.hover, 'Mostrar documentación')
  map('n', '<C-k>', vim.lsp.buf.signature_help, 'Ayuda de firma')
  map('n', '<leader>rn', vim.lsp.buf.rename, 'Renombrar')
  map('n', '<leader>ca', vim.lsp.buf.code_action, 'Acciones de código')
  map('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, 'Formatear')
  map('n', '[d', vim.diagnostic.goto_prev, 'Diagnóstico anterior')
  map('n', ']d', vim.diagnostic.goto_next, 'Diagnóstico siguiente')
  map('n', '<leader>e', vim.diagnostic.open_float, 'Mostrar diagnóstico')
  map('n', '<leader>q', vim.diagnostic.setloclist, 'Lista de diagnósticos')
end

-- Configuración de diagnósticos
vim.diagnostic.config({
  virtual_text = { prefix = '●', spacing = 4 },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "✘",
      [vim.diagnostic.severity.WARN] = "▲",
      [vim.diagnostic.severity.HINT] = "⚑",
      [vim.diagnostic.severity.INFO] = "»",
    },
  },
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = { border = 'rounded', source = 'always' },
})
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- PERSONALIZACIÓN DE VENTANAS FLOTANTES
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- Configurar apariencia de las ventanas flotantes del LSP
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = "rounded",  -- Bordes redondeados
    -- Puedes usar: "none", "single", "double", "rounded", "solid", "shadow"
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = "rounded",
  }
)

-- Opcional: agregar un poco de transparencia
 --vim.api.nvim_set_hl(0, 'NormalFloat', {
  -- bg = '#1e1e2e',
  -- blend = 80,  -- 0-100, más alto = más transparente
-- })

-- Opcional: hacer el borde más visible con color diferente
 --vim.api.nvim_set_hl(0, 'FloatBorder', {
  -- fg = '#f9e2af',  -- Amarillo/dorado
  -- bg = '#1e1e2e',
-- })


-- Personalizar colores de las ventanas flotantes
-- Estas configuraciones se pueden ajustar según tu tema de colores
vim.api.nvim_set_hl(0, 'FloatBorder', {
  fg = '#89b4fa',  -- Color del borde (azul claro)
  bg = '#1e1e2e',  -- Color de fondo del popup
})

vim.api.nvim_set_hl(0, 'NormalFloat', {
  bg = '#1e1e2e',  -- Color de fondo del contenido
})


-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- CONFIGURACIÓN DE SERVIDORES
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- Autocomando para iniciar LSP cuando se abre un archivo
vim.api.nvim_create_autocmd("FileType", {
  pattern = { 
    "lua", "typescript", "javascript", "typescriptreact", "javascriptreact",
    "python", "rust", "html", "css", "json", "yaml", "dockerfile", "sql"
  },
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    local server_name = nil
    local cmd = nil
    local settings = {}
    
    -- Configurar según el tipo de archivo
    if ft == "lua" then
      server_name = "lua_ls"
      cmd = { "lua-language-server" }
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          diagnostics = { globals = {'vim'} },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = { enable = false },
        },
      }
      
    elseif ft == "typescript" or ft == "javascript" or ft == "typescriptreact" or ft == "javascriptreact" then
      server_name = "tsserver"
      -- Intentar con typescript-language-server primero
      if vim.fn.executable("typescript-language-server") == 1 and vim.fn.executable("tsserver") == 1 then
        cmd = { "typescript-language-server", "--stdio" }
        server_name = "ts_ls"
      -- Si no, intentar con tsserver directamente
      elseif vim.fn.executable("tsserver") == 1 then
        cmd = { "tsserver", "--stdio" }
        server_name = "tsserver"
      else
        print("⚠️  TypeScript no está instalado. Instala con: npm install -g typescript typescript-language-server")
        return
      end
      -- Configuraciones específicas para React/Next.js
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          }
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          }
        }
      }
      
    elseif ft == "html" then
      server_name = "html"
      cmd = { "vscode-html-language-server", "--stdio" }
      settings = {
        html = {
          format = {
            templating = true,
            wrapLineLength = 120,
            wrapAttributes = 'auto',
          },
          hover = {
            documentation = true,
            references = true,
          },
        }
      }
      
    elseif ft == "css" then
      server_name = "cssls"
      cmd = { "vscode-css-language-server", "--stdio" }
      settings = {
        css = {
          validate = true,
          lint = {
            unknownAtRules = "ignore",
          }
        },
        scss = {
          validate = true,
        },
        less = {
          validate = true,
        }
      }
      
    elseif ft == "json" then
      server_name = "jsonls"
      cmd = { "vscode-json-language-server", "--stdio" }
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
          validate = { enable = true },
        }
      }
      
    elseif ft == "yaml" then
      server_name = "yamlls"
      cmd = { "yaml-language-server", "--stdio" }
      settings = {
        yaml = {
          schemaStore = {
            enable = true,
            url = "https://www.schemastore.org/api/json/catalog.json",
          },
          schemas = {
            kubernetes = "*.yaml",
            ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
            ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
            ["https://raw.githubusercontent.com/compose-spec/compose-go/master/schema/compose-spec.json"] = "docker-compose.{yml,yaml}",
          },
        }
      }
      
    elseif ft == "dockerfile" then
      server_name = "dockerls"
      cmd = { "docker-langserver", "--stdio" }
      
    elseif ft == "sql" then
      server_name = "sqlls"
      cmd = { "sql-language-server", "up", "--method", "stdio" }
      
    elseif ft == "python" then
      server_name = "pylsp"
      cmd = { "pylsp" }
      
    elseif ft == "rust" then
      server_name = "rust_analyzer"
      cmd = { "rust-analyzer" }
    end
    
    if not server_name then return end
    
    -- Verificar si el comando existe
    if vim.fn.executable(cmd[1]) == 0 then
      print("⚠️  " .. cmd[1] .. " no está instalado")
      return
    end
    
    -- Buscar directorio raíz del proyecto
    local root_patterns = {
      '.git', 
      'package.json', 
      'tsconfig.json',
      'jsconfig.json',
      'Cargo.toml', 
      'pyproject.toml',
      'compose.yaml',
      'docker-compose.yml',
      'nest-cli.json',
    }
    
    local root_dir = vim.fs.dirname(
      vim.fs.find(root_patterns, {
        upward = true,
        path = vim.fn.expand('%:p:h'),
      })[1]
    ) or vim.fn.getcwd()
    
    -- Iniciar el servidor LSP
    --print("🚀 Iniciando " .. server_name .. "...")
    local client_id = vim.lsp.start({
      name = server_name,
      cmd = cmd,
      root_dir = root_dir,
      settings = settings,
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)
      end,
    })
    
    if client_id then
      --print("✅ " .. server_name .. " iniciado (ID: " .. client_id .. ")")
    else
      print("❌ Error al iniciar " .. server_name)
    end
  end,
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- COMANDOS PERSONALIZADOS
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

vim.api.nvim_create_user_command('LspStatus', function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    print("❌ No hay servidores LSP conectados")
  else
    print("✅ Servidores LSP activos:")
    for _, client in ipairs(clients) do
      print("  • " .. client.name .. " (ID: " .. client.id .. ")")
    end
  end
end, {})

vim.api.nvim_create_user_command('LspLog', function()
  vim.cmd('edit ' .. vim.lsp.get_log_path())
end, {})

vim.api.nvim_create_user_command('LspRestart', function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  for _, client in ipairs(clients) do
    vim.lsp.stop_client(client.id)
  end
  vim.cmd('edit')
  print("🔄 LSP reiniciado")
end, {})

vim.api.nvim_create_user_command('LspInstalled', function()
  print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
  print("📦 Servidores LSP instalados:")
  print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
  
  local servers = {
    { name = "Lua", cmd = "lua-language-server" },
    { name = "TypeScript/JavaScript", cmd = "typescript-language-server" },
    { name = "HTML", cmd = "vscode-html-language-server" },
    { name = "CSS", cmd = "vscode-css-language-server" },
    { name = "JSON", cmd = "vscode-json-language-server" },
    { name = "YAML", cmd = "yaml-language-server" },
    { name = "Docker", cmd = "docker-langserver" },
    { name = "SQL", cmd = "sql-language-server" },
    { name = "Python", cmd = "pylsp" },
    { name = "Rust", cmd = "rust-analyzer" },
    { name = "Tailwind CSS", cmd = "tailwindcss-language-server" },
    { name = "GraphQL", cmd = "graphql-lsp" },
  }
  
  for _, server in ipairs(servers) do
    local installed = vim.fn.executable(server.cmd) == 1
    local status = installed and "✅" or "❌"
    print(string.format("%s %-25s %s", status, server.name, server.cmd))
  end
  
  print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
  print("Para instalar: npm install -g <nombre-del-servidor>")
end, {})

--print("✅ Configuración LSP cargada")
--print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
