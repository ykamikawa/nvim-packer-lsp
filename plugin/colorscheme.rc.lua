local Color, colors, Group, groups, styles = require('colorbuddy').setup()

if Color_scheme == 'gruvbox' then
  require('colorbuddy').colorscheme 'gruvbuddy'

  -- Use Color.new(<name>, <#rrggbb>) to create new colors
  -- They can be accessed through colors.<name>
  Color.new('background', '#282c34')
  Color.new('black', '#000000')
  Color.new('red', '#cc6666')
  Color.new('green', '#99cc99')
  Color.new('yellow', '#f0c674')

  -- Define highlights in terms of `colors` and `groups`
  Group.new('Function', colors.yellow, colors.background, styles.bold)
  Group.new('luaFunctionCall', groups.Function, groups.Function, groups.Function)

  -- Define highlights in relative terms of other colors
  Group.new('Error', colors.red:light(), nil, styles.bold)
elseif Color_scheme == 'neosolarized' then
  local status, c = pcall(require, Color_scheme)
  if not status then
    return
  end

  c.setup {
    comment_italics = true,
  }

  Color.new('black', '#000000')
  Group.new('CursorLine', colors.none, colors.base03, styles.NONE, colors.base1)
  Group.new('CursorLineNr', colors.yellow, colors.black, styles.NONE, colors.base1)
  Group.new('Visual', colors.none, colors.base03, styles.reverse)

  local cError = groups.Error.fg
  local cInfo = groups.Information.fg
  local cWarn = groups.Warning.fg
  local cHint = groups.Hint.fg

  Group.new('DiagnosticVirtualTextError', cError, cError:dark():dark():dark():dark(), styles.NONE)
  Group.new('DiagnosticVirtualTextInfo', cInfo, cInfo:dark():dark():dark(), styles.NONE)
  Group.new('DiagnosticVirtualTextWarn', cWarn, cWarn:dark():dark():dark(), styles.NONE)
  Group.new('DiagnosticVirtualTextHint', cHint, cHint:dark():dark():dark(), styles.NONE)
  Group.new('DiagnosticUnderlineError', colors.none, colors.none, styles.undercurl, cError)
  Group.new('DiagnosticUnderlineWarn', colors.none, colors.none, styles.undercurl, cWarn)
  Group.new('DiagnosticUnderlineInfo', colors.none, colors.none, styles.undercurl, cInfo)
  Group.new('DiagnosticUnderlineHint', colors.none, colors.none, styles.undercurl, cHint)
elseif Color_scheme == 'tokyonight' then
  local function setTokyo()
    vim.g.tokyonight_style = 'night'
    vim.g.tokyonight_italic_functions = true
    vim.g.tokyonight_transparent = true
    vim.g.tokyonight_transparent_sidebar = true
    vim.g.tokyonight_sidebars = { 'qf', 'vista_kind', 'terminal', 'packer' }

    -- Change the "hint" color to the "orange" color, and make the "error" color bright red
    -- vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }

    vim.cmd [[colorscheme tokyonight]]
  end

  local status_ok, _ = pcall(setTokyo)

  if not status_ok then
    print 'Failed to set colorschema tokyonight'
  end
elseif Color_scheme == 'everforest' then
  local function setEverForest()
    vim.g.everforest_background = 'hard'
    vim.g.everforest_better_performance = 1

    vim.cmd [[colorscheme everforest]]
  end

  local status_ok, _ = pcall(setEverForest)

  if not status_ok then
    print 'Failed to set colorschema everforest'
  end
end
