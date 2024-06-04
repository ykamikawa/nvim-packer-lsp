local image_status, image = pcall(require, 'image')
if not image_status then
  print 'image.nvim is not installed'
  return
end

local text_status, text = pcall(require, 'jupytext')
if not text_status then
  print 'jupytext is not installed'
  return
end

local nn_status, nn = pcall(require, 'notebook-navigator')
if not nn_status then
  print 'notebook-navigator is not installed'
  return
end

-- image.nvim
-- Example for configuring Neovim to load user-installed installed Lua rocks:
package.path = package.path .. ';' .. vim.fn.expand '$HOME' .. '/.luarocks/share/lua/5.1/?/init.lua;'
package.path = package.path .. ';' .. vim.fn.expand '$HOME' .. '/.luarocks/share/lua/5.1/?.lua;'
image.setup {
  backend = 'kitty',
  max_width = 100,
  max_height = 12,
  max_height_window_percentage = math.huge,
  max_width_window_percentage = math.huge,
  window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
  window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', '' },
}

text.setup()

-- molten-nvim
vim.g.molten_image_provider = 'image.nvim'
-- vim.g.molten_output_win_max_height = 500
-- vim.g.molten_use_border_highlights = false
-- vim.g.molten_image_provider = 'wezterm'
-- vim.g.molten_auto_open_output = false

-- don't change the mappings (unless it's related to your bug)
vim.keymap.set('n', '<leader>mi', ':MoltenInit<CR>')
vim.keymap.set('n', '<leader>e', ':MoltenEvaluateOperator<CR>')
vim.keymap.set('n', '<leader>rr', ':MoltenReevaluateCell<CR>')
vim.keymap.set('v', '<leader>r', ':<C-u>MoltenEvaluateVisual<CR>gv')
vim.keymap.set('n', '<leader>os', ':noautocmd MoltenEnterOutput<CR>')
vim.keymap.set('n', '<leader>oh', ':MoltenHideOutput<CR>')
vim.keymap.set('n', '<leader>md', ':MoltenDelete<CR>')

-- notebook-navigator
nn.setup { activate_hydra_keys = '<leader>no', repl_provider = 'molten' }
vim.api.nvim_set_keymap(
  'n',
  ']h',
  "<cmd>lua require('notebook-navigator').move_cell('d')<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  'n',
  '[h',
  "<cmd>lua require('notebook-navigator').move_cell('u')<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  'n',
  '<leader>rc',
  "<cmd>lua require('notebook-navigator').run_cell()<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  'n',
  '<leader>rm',
  "<cmd>lua require('notebook-navigator').run_and_move()<CR>",
  { noremap = true, silent = true }
)
