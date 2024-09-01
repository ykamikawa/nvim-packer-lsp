local status, nt = pcall(require, 'neo-tree')
if not status then
  return
end

vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]
vim.keymap.set('n', '<C-n>', ':Neotree reveal<CR>')

nt.setup {
  default_component_configs = {
    indent = {
      -- indent guides
      with_markers = true,
      indent_marker = '│',
      last_indent_marker = '└',
      -- expander config, needed for nesting files
      with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
      expander_collapsed = '',
      expander_expanded = '',
    },
    git_status = {
      symbols = {
        -- Change type
        added = '', -- or "✚", but this is redundant info if you use git_status_colors on the name
        modified = '', -- or "", but this is redundant info if you use git_status_colors on the name
        deleted = '✖', -- this can only be used in the git_status source
        renamed = '󰑕', -- this can only be used in the git_status source
        -- Status type
        untracked = '',
        ignored = '',
        unstaged = '',
        staged = '󰱒',
        conflict = '',
      },
    },
  },
  window = {
    position = 'left',
    width = 40,
    mappings = {
      ['<cr>'] = 'open',
      ['l'] = 'open',
      ['s'] = '',
      ['sp'] = 'open_split',
      ['vs'] = 'open_vsplit',
      ['a'] = {
        'add',
        config = { show_path = 'none' },
      },
      ['A'] = 'add_directory',
      ['t'] = 'open_tabnew',
      ['d'] = 'delete',
      ['r'] = 'rename',
      ['y'] = 'copy_to_clipboard',
      ['m'] = 'move', -- takes text input for destination, also accepts the optional config.show_path option like "add".
      ['q'] = 'close_window',
    },
  },
  filesystem = {
    window = {
      mappings = {
        ['<space>'] = 'set_root',
        ['.'] = 'set_root',
        ['<bs>'] = 'navigate_up',
        ['h'] = 'navigate_up',
        ['/'] = 'fuzzy_finder',
        ['gk'] = 'prev_git_modified',
        ['gj'] = 'next_git_modified',
      },
    },
  },
}
