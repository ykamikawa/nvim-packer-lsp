local status, ts = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

ts.setup {
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  ensure_installed = {
    "comment",
    "bash",
    "json",
    "toml",
    "yaml",
    "html",
    "css",
    "scss",
    "http",
    "lua",
    "python",
    "go",
    "rust",
    "javascript",
    "typescript",
    "tsx",
    "dart",
    "graphql",
    "dockerfile",
    "vim",
    "markdown",
    "markdown_inline"
  },
  autotag = {
    enable = true,
  },
  endwise = {
    enable = true
  },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
