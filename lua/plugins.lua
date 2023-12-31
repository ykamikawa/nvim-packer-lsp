local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  -- Color scheme
  use {
    'svrana/neosolarized.nvim',
    requires = { 'tjdevries/colorbuddy.nvim' }
  }
  use {
    'tjdevries/gruvbuddy.nvim',
    requires = { 'tjdevries/colorbuddy.nvim' }
  }
  use "folke/tokyonight.nvim"
  use "sainnhe/everforest"

  -- Icon and color
  use 'kyazdani42/nvim-web-devicons' -- File icons
  use 'norcalli/nvim-colorizer.lua' -- colorizer of color code

  -- Statusline and bufferline
  use 'nvim-lualine/lualine.nvim' -- Statusline
  use 'nvim-lua/plenary.nvim' -- Common utilities
  use 'akinsho/nvim-bufferline.lua' -- bufferline

  -- LSP and completion
  use 'onsails/lspkind-nvim' -- vscode-like pictograms
  use 'hrsh7th/cmp-buffer' -- nvim-cmp source for buffer words
  use 'hrsh7th/cmp-nvim-lsp' -- nvim-cmp source for neovim's built-in LSP
  use 'hrsh7th/cmp-cmdline' -- Completion of command line
  use 'hrsh7th/cmp-path' -- Completion of file and directory
  use 'hrsh7th/vim-vsnip' -- snipet
  use 'hrsh7th/nvim-cmp' -- Completion
  use 'neovim/nvim-lspconfig' -- LSP
  use 'williamboman/mason.nvim' -- LSP installer
  use 'williamboman/mason-lspconfig.nvim' -- LSP installer config
  use 'glepnir/lspsaga.nvim' -- LSP UIs
  use 'ray-x/lsp_signature.nvim' -- Signature for LSP
  -- use { 'j-hui/fidget.nvim', tag = 'legacy' } -- Visualize running lsp server
  use 'jose-elias-alvarez/nvim-lsp-ts-utils' -- utilities of typescript-language-server

  -- Formatter and linter
  use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  use 'MunifTanjim/prettier.nvim' -- Prettier plugin for Neovim's built-in LSP client

  -- Syntax highlight
  use {
    'nvim-treesitter/nvim-treesitter', -- syntax highlight
    run = ':TSUpdate'
  }
  use 'nvim-treesitter/nvim-treesitter-textobjects' -- Additional textobjects for treesitter
  use 'romgrk/nvim-treesitter-context' -- Show code context in the above

  -- Filer
  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  }

  -- Fuzzy finder
  use 'nvim-telescope/telescope.nvim' -- fuzzy finder
  use 'nvim-telescope/telescope-file-browser.nvim' -- filer of telescope

  -- Git
  use 'lewis6991/gitsigns.nvim'
  use 'dinhhuy258/git.nvim' -- For git blame & browse

  -- Cursor
  use 'rainbowhxch/accelerated-jk.nvim'
  -- use 'karb94/neoscroll.nvim' -- scroll smoothlly
  use 'lukas-reineke/indent-blankline.nvim' -- visualize indent

  -- Completion
  use 'windwp/nvim-autopairs' -- autopairs
  use 'windwp/nvim-ts-autotag' -- autotag

  -- Greeter
  use 'goolord/alpha-nvim'

  -- Utilities
  use 'folke/zen-mode.nvim'
  use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install" })
end)
