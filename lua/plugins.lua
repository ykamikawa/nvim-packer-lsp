local status, packer = pcall(require, 'packer')
if not status then
  print 'Packer is not installed'
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  -- Color scheme
  use 'tjdevries/colorbuddy.nvim'
  use {
    'svrana/neosolarized.nvim',
    requires = { 'tjdevries/colorbuddy.nvim' },
  }
  use {
    'tjdevries/gruvbuddy.nvim',
    requires = { 'tjdevries/colorbuddy.nvim' },
  }
  use 'folke/tokyonight.nvim'
  use 'sainnhe/everforest'

  -- Icon and color
  use 'kyazdani42/nvim-web-devicons' -- File icons
  use 'norcalli/nvim-colorizer.lua'  -- colorizer of color code

  -- UI
  -- Statusline
  use 'nvim-lualine/lualine.nvim' -- Statusline
  use 'nvim-lua/plenary.nvim'     -- Common utilities
  -- Bufferline
  use 'akinsho/nvim-bufferline.lua'

  -- LSP completion
  use 'hrsh7th/nvim-cmp'                     -- Completion
  use 'onsails/lspkind-nvim'                 -- vscode-like pictograms
  use 'hrsh7th/cmp-buffer'                   -- nvim-cmp source for buffer words
  use 'hrsh7th/cmp-nvim-lsp'                 -- nvim-cmp source for neovim's built-in LSP
  use 'hrsh7th/cmp-nvim-lsp-signature-help'  -- Displaying function signature
  use 'hrsh7th/cmp-cmdline'                  -- Completion of command line
  use 'hrsh7th/cmp-path'                     -- Completion of file and directory
  use 'hrsh7th/vim-vsnip'                    -- snipet
  -- LSP server management
  use 'neovim/nvim-lspconfig'                -- LSP server configuration
  use 'williamboman/mason.nvim'              -- LSP installer
  use 'williamboman/mason-lspconfig.nvim'    -- LSP installer config
  -- LSP UI
  use 'glepnir/lspsaga.nvim'                 -- LSP UIs
  use 'ray-x/lsp_signature.nvim'             -- Signature for LSP
  -- use { 'j-hui/fidget.nvim', tag = 'legacy' } -- Visualize running lsp server
  use 'jose-elias-alvarez/nvim-lsp-ts-utils' -- utilities of typescript-language-server

  -- Formatter and linter
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'vim-test/vim-test'
  use {
    'nvimtools/none-ls.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'vim-test/vim-test',
    },
  }                               -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  use 'nanotee/sqls.nvim'         -- SQL language server
  use 'MunifTanjim/prettier.nvim' -- Prettier plugin for Neovim's built-in LSP client

  -- Syntax highlight
  use {
    'nvim-treesitter/nvim-treesitter', -- syntax highlight
    run = ':TSUpdate',
  }
  -- use 'RRethy/nvim-treesitter-endwise' -- Wisely add "end"
  use 'nvim-treesitter/nvim-treesitter-textobjects' -- Additional textobjects for treesitter
  use 'romgrk/nvim-treesitter-context'              -- Show code context in the above

  -- Filer
  use 'MunifTanjim/nui.nvim'      -- Filer
  use { '3rd/image.nvim', version = '1.1.0' }
  use 's1n7ax/nvim-window-picker' -- Window picker
  use {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      '3rd/image.nvim',
      {
        's1n7ax/nvim-window-picker',
        version = '2.*',
      },
    },
  }

  -- Fuzzy finder
  use 'nvim-telescope/telescope.nvim'              -- fuzzy finder
  use 'nvim-telescope/telescope-file-browser.nvim' -- filer of telescope
  use 'nvim-telescope/telescope-dap.nvim'          -- dap of telescope

  -- Git
  use 'lewis6991/gitsigns.nvim'
  use 'dinhhuy258/git.nvim' -- For git blame & browse

  -- Copilot
  use 'github/copilot.vim'
  -- CopilotChat
  use {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
    requires = {
      'nvim-lua/plenary.nvim',
      'github/copilot.vim',
    },
  }

  -- DAP
  use 'mfussenegger/nvim-dap'
  use 'nvim-neotest/nvim-nio'
  use { 'rcarriga/nvim-dap-ui', requires = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' } }
  use 'theHamsta/nvim-dap-virtual-text'
  use 'mfussenegger/nvim-dap-python'
  use 'LiadOz/nvim-dap-repl-highlights'

  -- Cursor
  use 'rainbowhxch/accelerated-jk.nvim'
  -- use 'karb94/neoscroll.nvim' -- scroll smoothlly
  use 'lukas-reineke/indent-blankline.nvim' -- visualize indent

  -- Completion
  use 'windwp/nvim-autopairs'  -- autopairs
  use 'windwp/nvim-ts-autotag' -- autotag

  -- Greeter
  use 'goolord/alpha-nvim'

  -- Speed loading lua modules and files
  use 'lewis6991/impatient.nvim'

  -- Utilities
  use 'folke/zen-mode.nvim'
  use { 'iamcco/markdown-preview.nvim', run = 'cd app && npm install' }
end)
