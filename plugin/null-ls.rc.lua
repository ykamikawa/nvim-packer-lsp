local status, nls = pcall(require, "null-ls")
if (not status) then return end

local nls_utils = require "null-ls.utils"
local b = nls.builtins

local with_diagnostics_code = function(builtin)
  return builtin.with {
    diagnostics_format = "#{m} [#{c}]",
  }
end

local with_root_file = function(builtin, file)
  return builtin.with {
    condition = function(utils)
      return utils.root_has_file(file)
    end,
  }
end

local sources = {
  -- completion
  -- b.completion.spell,

  -- formatting
  -- b.formatting.prettierd,                                -- js, ts, html, css, yaml, json, markdown, etc.
  b.formatting.eslint_d,                                 -- js, ts, react, vue
  b.formatting.shfmt,                                    -- Shell
  b.formatting.ruff,                                     -- Python
  b.formatting.black.with { extra_args = { "--fast" } }, -- Python
  -- b.formatting.isort,                                    -- Python
  b.formatting.djlint,                                   -- django, jinja.html, htmldjango
  b.formatting.gofumpt,                                  -- Go
  b.formatting.goimports,                                -- Go
  b.formatting.dart_format,                              -- Dart
  with_root_file(b.formatting.stylua, "stylua.toml"),    -- Lua

  -- diagnostics
  b.diagnostics.write_good,                            -- English
  b.diagnostics.markdownlint,                          -- markdown
  b.diagnostics.eslint_d,                              -- Javascript, Typescript
  b.diagnostics.tsc,                                   -- Typescript compiler
  b.diagnostics.ruff,                                  -- Python
  b.diagnostics.mypy,                                  -- Python
  -- b.diagnostics.flake8,                                -- Python
  b.diagnostics.curlylint,                             -- jinja.html, htmldjango
  b.diagnostics.staticcheck,                           -- Go
  with_root_file(b.diagnostics.selene, "selene.toml"), -- Lua
  with_diagnostics_code(b.diagnostics.shellcheck),     -- Shell
  b.diagnostics.zsh,                                   -- ZSH

  -- code actions
  b.code_actions.gitsigns,  -- Git operation
  b.code_actions.gitrebase, -- gitrebase
  b.code_actions.proselint, -- Markdonw, tex
  b.code_actions.eslint_d,  -- JS, TS, react, vue

  -- hover
  b.hover.dictionary,
}

nls.setup {
  debounce = 150,
  save_after_format = false,
  sources = sources,
  root_dir = nls_utils.root_pattern ".git",
}
