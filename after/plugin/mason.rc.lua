local status, mason = pcall(require, "mason")
if (not status) then return end

local status_lspconfig, lspconfig = pcall(require, "mason-lspconfig")
if (not status_lspconfig) then return end

mason.setup {}

lspconfig.setup {
  ensure_installed = {
    "jsonls",
    "yamlls",
    "taplo",
    "html",
    "tsserver",
    "pyright",
    "lua_ls",
    "tailwindcss",
    "graphql",
    "ruff",
    "ruff_lsp"
  },
}
