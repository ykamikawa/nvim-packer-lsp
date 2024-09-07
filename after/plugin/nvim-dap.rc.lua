local dap_status, dap = pcall(require, 'dap')
if not dap_status then
  print 'Dap is not installed'
  return
end

local dapui_status, dapui = pcall(require, 'dapui')
if not dapui_status then
  print 'Dapui is not installed'
  return
end

local virtual_text_status, virtual_text = pcall(require, 'nvim-dap-virtual-text')
if not virtual_text_status then
  print 'Dap-virtual-text is not installed'
  return
end

local highlight_status, highlight = pcall(require, 'nvim-dap-repl-highlights')
if not highlight_status then
  print 'Nvim-dap-repl-highlights is not installed'
  return
end

local python_status, python = pcall(require, 'dap-python')
if not python_status then
  print 'Dap-python is not installed'
  return
end

dapui.setup {
  icons = { expanded = '▾', collapsed = '▸', current_frame = '●' },
  mappings = {
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  element_mappings = {},
  expand_lines = true,
  force_buffers = true,
  layouts = {
    {
      elements = {
        { id = 'watches',     size = 0.20 },
        { id = 'stacks',      size = 0.20 },
        { id = 'breakpoints', size = 0.20 },
        { id = 'scopes',      size = 0.40 },
      },
      size = 64,
      position = 'right',
    },
    {
      elements = {
        'repl',
        'console',
      },
      size = 0.20,
      position = 'bottom',
    },
  },
  floating = {
    max_height = nil,
    max_width = nil,
    border = "single",
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  controls = {
    enabled = true,
    element = "repl",
    icons = {
      pause = "⏸",
      play = "▶",
      step_into = "⏎",
      step_over = "⏭",
      step_out = "⏮",
      step_back = "b",
      run_last = "▶▶",
      terminate = "⏹",
    },
  },
  render = {
    max_type_length = nil,
    max_value_lines = 100,
  }
}
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

-- nvim-dap-virtual-text
virtual_text.setup {}

-- nvim-dap-repl-highlights
highlight.setup()

-- nvim-dap-python
local venv = os.getenv 'VIRTUAL_ENV'
if venv == nil then
  print 'VIRTUAL_ENV is not set'
  return
else
  local command = string.format('%s/bin/python', venv)
  python.setup(command)
  python.test_runner = 'pytest'
end

-- key mappings
vim.api.nvim_set_keymap('n', '<F5>', ':DapContinue<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<F10>', ':DapStepOver<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<F11>', ':DapStepInto<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<F12>', ':DapStepOut<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>b', ':DapToggleBreakpoint<CR>', { silent = true })
vim.api.nvim_set_keymap(
  'n',
  '<leader>B',
  ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Breakpoint condition: "))<CR>',
  { silent = true }
)
vim.api.nvim_set_keymap(
  'n',
  '<leader>lp',
  ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
  { silent = true }
)
vim.api.nvim_set_keymap('n', '<leader>d', ':lua require("dapui").toggle()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>co', ':DapContinue<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>dc', ':lua require("dapui").close()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>dr', ':lua require("dap").repl.open()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>dl', ':lua require("dap").run_last()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader><leader>d', ":lua require('dapui').eval()<CR>", { silent = true })
