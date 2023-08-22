local status, saga = pcall(require, 'lspsaga')
if (not status) then return end

saga.setup({})

local opts = { noremap = true, silent = true }
vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
vim.keymap.set('n', 'gh', '<Cmd>Lspsaga lsp_finder<CR>', opts)
vim.keymap.set('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)
vim.keymap.set('n', 'gn', '<Cmd>Lspsaga rename<CR>', opts)
vim.keymap.set('n', 'ca', '<Cmd>Lspsaga code_action<CR>', opts)
vim.keymap.set('v', 'ca', '<Cmd>Lspsaga range_code_action<CR>', opts)
vim.keymap.set('n', 'cd', '<Cmd>Lspsaga show_line_diagnostics<CR>', { silent = true })
--vim.keymap.set('n', 'cd', '<Cmd>Lspsaga show_cursor_diagnostics<CR>', { silent = true })
vim.keymap.set('n', 'g]', '<Cmd>Lspsaga diagnostic_jump_next<CR>', { silent = true })
vim.keymap.set('n', 'gj', '<Cmd>Lspsaga diagnostic_jump_next<CR>', { silent = true })
vim.keymap.set('n', 'g[', '<Cmd>Lspsaga diagnostic_jump_prev<CR>', { silent = true })
vim.keymap.set('n', 'gk', '<Cmd>Lspsaga diagnostic_jump_prev<CR>', { silent = true })
vim.keymap.set('n', '<leader>o', '<Cmd>LSoutlineToggle<CR>', { silent = true })
-- Float terminal
vim.keymap.set('n', '<A-d>', '<cmd>Lspsaga open_floaterm<CR>', { silent = true })
-- if you want pass somc cli command into terminal you can do like this
-- open lazygit in lspsaga float terminal
vim.keymap.set('n', '<A-d>', '<cmd>Lspsaga open_floaterm lazygit<CR>', { silent = true })
-- close floaterm
vim.keymap.set('t', '<A-d>', [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })
