local status, bufferline = pcall(require, "bufferline")
if (not status) then return end

bufferline.setup({
  options = {
    mode = "buffers",
    indicator = { style = "underline" },
    diagnostics = "nvim_lsp",
    separator_style = 'slant',
    color_icons = true,
    always_show_bufferline = true,
    offsets = {
      {
        filetype = "neo-tree",
        text = "󰥨 File Explorer",
        text_align = "left",
        separator = true,
      },
    },
  },
  highlights = {
    separator = {
      fg = '#073642',
      bg = '#002b36',
    },
    separator_selected = {
      fg = '#073642',
    },
    background = {
      fg = '#657b83',
      bg = '#002b36'
    },
    buffer_selected = {
      fg = '#fdf6e3',
      bold = true,
    },
    fill = {
      bg = '#073642'
    }
  },
})

vim.keymap.set('n', '<Leader><Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
vim.keymap.set('n', '<Leader><S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})
