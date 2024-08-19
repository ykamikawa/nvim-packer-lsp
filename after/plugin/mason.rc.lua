local status, mason = pcall(require, 'mason')
if not status then
  print 'Mason is not installed'
  return
end

local status_lspconfig, lspconfig = pcall(require, 'mason-lspconfig')
if not status_lspconfig then
  print 'Mason-lspconfig is not installed'
  return
end

mason.setup {}

lspconfig.setup {
  ensure_installed = {
    'jsonls',
    'yamlls',
    'taplo',
    'html',
    'tsserver',
    'gopls',
    'pyright',
    'ruff',
    'ruff_lsp',
    'lua_ls',
    'tailwindcss',
    'graphql',
  },
}
