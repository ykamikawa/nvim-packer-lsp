--vim.lsp.set_log_level("debug")

local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then return end

local protocol = require('vim.lsp.protocol')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)

  if client.name == 'tsserver' then
    client.server_capabilities.documentFormattingProvide = false
  elseif client.name == 'jsonls' then
    --client.resolved_capabilities.document_formatting = false
    --client.resolved_capabilities.document_range_formatting = false
  end
end

protocol.CompletionItemKind = {
  '', -- Text
  '', -- Method
  '', -- Function
  '', -- Constructor
  '', -- Field
  '', -- Variable
  '', -- Class
  'ﰮ', -- Interface
  '', -- Module
  '', -- Property
  '', -- Unit
  '', -- Value
  '', -- Enum
  '', -- Keyword
  '﬌', -- Snippet
  '', -- Color
  '', -- File
  '', -- Reference
  '', -- Folder
  '', -- EnumMember
  '', -- Constant
  '', -- Struct
  '', -- Event
  'ﬦ', -- Operator
  '', -- TypeParameter
}

-- Set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

-- JSON
nvim_lsp.jsonls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- YAML
nvim_lsp.yamlls.setup {
  on_attach = on_attach,
  provideFormatter = false, -- use prettier formattnig in null-ls
  capabilities = capabilities
}

-- TOML
nvim_lsp.taplo.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

-- HTML
nvim_lsp.html.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Javascript
-- Typescript
nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "typescript-language-server", "--stdio" }
}

-- Dart
nvim_lsp.dartls.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

-- python
nvim_lsp.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

-- lua
nvim_lsp.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

-- tailwindCSS
nvim_lsp.tailwindcss.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

-- graphQL
nvim_lsp.graphql.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  update_in_insert = false,
  virtual_text = false,
  severity_sort = true,
}
)

-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
  virtual_text = false,
  update_in_insert = true,
  float = {
    source = "always", -- Or "if_many"
  },
})

-- keymaps
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>') -- カーソル下の変数の情報
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>') -- カーソル下の参照箇所の表示
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>') -- カーソル下の定義ジャンプ
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>') -- 変数のリネーム
vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>') -- Error/warning/Hintの修正候補
vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.format({async=true})<CR>') -- format
vim.keymap.set('n', '<Leader>x', '<cmd>lua vim.lsp.buf.format({async=true})<CR>') -- format
vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'gj', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
vim.keymap.set('n', 'gk', '<cmd>lua vim.diagnostic.goto_prev()<CR>')

-- lsp_signature
local status, lsp_s = pcall(require, "lsp_signature")
if (not status) then return end
lsp_s.setup {}

local status, fidget = pcall(require, "fidget")
if (not status) then return end
fidget.setup {}
