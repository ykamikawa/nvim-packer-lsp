---@diagnostic disable: unused-local, redundant-parameter
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
  b.formatting.prettierd, -- js, ts, html, css, yaml, json, markdown, etc.
  b.formatting.shfmt, -- Shell
  b.formatting.black.with { extra_args = { "--fast" } }, -- Python
  b.formatting.isort, -- Python
  b.formatting.dart_format, -- Dart
  with_root_file(b.formatting.stylua, "stylua.toml"), -- Lua
  b.formatting.djhtml, -- Django/jinja

  -- diagnostics
  b.diagnostics.write_good, -- English
  b.diagnostics.markdownlint, -- markdown
  b.diagnostics.tsc, -- Typescript compiler
  b.diagnostics.mypy, -- Python
  with_root_file(b.diagnostics.selene, "selene.toml"), -- Lua
  with_diagnostics_code(b.diagnostics.shellcheck), -- Shell
  b.diagnostics.zsh, -- ZSH

  -- code actions
  b.code_actions.gitsigns, -- Git operation
  b.code_actions.gitrebase, -- gitrebase
  b.code_actions.proselint, -- Markdonw, tex
  b.code_actions.eslint_d, -- JS, TS, react, vue

  -- hover
  b.hover.dictionary,
}

nls.setup {
  debounce = 150,
  save_after_format = false,
  sources = sources,
  root_dir = nls_utils.root_pattern ".git",
}
