local keymap = vim.keymap

-- Leader
vim.g.mapleader = " "

----------------
-- Nomal mode --
----------------
keymap.set('n', 'x', '"_x')

-- Increment/decrement
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- Delete a word backwards
keymap.set('n', 'dw', 'vb"_d')

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G')

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- Tab
-- New tab
keymap.set('n', 'te', ':tabedit')
keymap.set('n', 'tn', ':tabnew<CR>')
keymap.set('n', '<C-t>n', ':tabnew<CR>')
-- Move tab
keymap.set('n', '<C-t>N', ':tabnext<CR>')
keymap.set('n', '<C-t>p', ':tabprevious<CR>')
keymap.set('n', '<Leader>t', 'gt')
keymap.set('n', '<Leader>T', 'gT')
keymap.set('n', '<Tab>', 'gt')

-- buffer
-- Delete buffer
keymap.set('n', 'bd', ':bdelete<CR>')

-- Window
-- Split window
keymap.set('n', 'sp', ':split<Return><C-w>w')
keymap.set('n', 'vs', ':vsplit<Return><C-w>w')
-- Resize window
keymap.set('n', 'sh', '<C-w><')
keymap.set('n', 'sl', '<C-w>>')
keymap.set('n', 'sk', '<C-w>+')
keymap.set('n', 'sj', '<C-w>-')

-- Move to begging / end of line
keymap.set('', '<leader>h', '^')
keymap.set('', '<leader>l', '$')

-- Move to display line
keymap.set('n', 'j', 'gj')
keymap.set('n', 'k', 'gk')

-- Save and finish
keymap.set('n', '<space>w', ':w!<CR>')
keymap.set('n', '<space>q', ':q!<CR>')

-- Start terminal on new tab
keymap.set('n', '@t', ':tabe<CR>:terminal<CR>')

-- Search
keymap.set('n', '<Esc><Esc>', ':nohlsearch<CR><Esc>')


-----------------
-- Insert mode --
-----------------
keymap.set('i', 'jj', '<ESC>', { silent = true })
keymap.set('i', 'jjw', '<ESC>:w!<CR>', { silent = true })
keymap.set('i', 'jjq', '<ESC>:q!<CR>', { silent = true })


-------------------
-- Terminal mode --
-------------------
-- Finish terminal by Ctrl + q
keymap.set('t', '<C-q>', '<C-\\><C-n>:q<CR>')
-- Move to normal mode from terminal mode by ESC
keymap.set('t', '<ESC>', '<C-\\><C-n>')
-- Move to normal mode from terminal mode by Ctrl + w
keymap.set('t', '<C-w>', '<C-\\><C-n>')
-- Tab move in terminal mode
keymap.set('t', '<C-l>', '<C-\\><C-n>gt')
keymap.set('t', '<C-h>', '<C-\\><C-n>gT')
