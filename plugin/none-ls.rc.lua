local status, nls = pcall(require, 'null-ls')
if not status then
  return
end

local formatting = nls.builtins.formatting
local diagnostics = nls.builtins.diagnostics
local code_actions = nls.builtins.code_actions
local hover = nls.builtins.hover
local nls_utils = require 'null-ls.utils'

local with_diagnostics_code = function(builtin)
  return builtin.with {
    diagnostics_format = '#{m} [#{c}]',
  }
end

local sources = {
  -- completion
  -- b.completion.spell,

  -- formatting
  -- formatting.prettierd,                                -- js, ts, html, css, yaml, json, markdown, etc.
  formatting.eslint_d, -- js, ts, react, vue
  formatting.shfmt, -- Shell
  formatting.ruff, -- Python
  formatting.black.with { extra_args = { '--fast' } }, -- Python
  -- formatting.isort,                                    -- Python
  formatting.djlint, -- django, jinja.html, htmldjango
  formatting.gofumpt, -- Go
  formatting.goimports, -- Go
  formatting.dart_format, -- Dart
  formatting.stylua, -- Lua

  -- diagnostics
  diagnostics.write_good, -- English
  diagnostics.markdownlint, -- markdown
  diagnostics.eslint_d, -- Javascript, Typescript
  diagnostics.tsc, -- Javascript, Typescript
  diagnostics.ruff, -- Python
  diagnostics.mypy, -- Python
  -- diagnostics.flake8,                                -- Python
  diagnostics.curlylint, -- jinja.html, htmldjango
  diagnostics.staticcheck, -- Go
  diagnostics.selene.with { extra_args = { '--display-style-guide' } }, -- Lua
  with_diagnostics_code(diagnostics.shellcheck), -- Shell
  diagnostics.zsh, -- ZSH

  -- code actions
  code_actions.gitsigns, -- Git operation
  code_actions.gitrebase, -- gitrebase
  code_actions.proselint, -- Markdonw, tex
  code_actions.eslint_d, -- js, ts, react, vue

  -- hover
  hover.dictionary,
}

nls.setup {
  debounce = 150,
  save_after_format = false,
  sources = sources,
  root_dir = nls_utils.root_pattern '.git',
}
