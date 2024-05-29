vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap('i', '<C-i>', 'copilot#Accept("<CR>")', { silent = true, expr = true })

local status, chat = pcall(require, 'CopilotChat')
if not status then
  return
end
if not chat then
  return
end

local select = require 'CopilotChat.select'
local actions = require 'CopilotChat.actions'
local telescope = require 'CopilotChat.integrations.telescope'

chat.setup {
  debug = true, -- Enable debug mode
  window = {
    layout = 'horizontal', -- 'vertical', 'horizontal', 'float', 'replace'
    width = 0.5, -- fractional width of parent, or absolute width in columns when > 1
    height = 0.4, -- fractional height of parent, or absolute height in rows when > 1
    -- Options below only apply to floating windows
    relative = 'editor', -- 'editor', 'win', 'cursor', 'mouse'
    border = 'single', -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
    row = 1, -- row position of the window, default is centered
    col = nil, -- column position of the window, default is centered
    title = 'Copilot Chat', -- title of chat window
    footer = nil, -- footer of chat window
    zindex = 1, -- determines if window is on top or below other floating windows
  },
  -- Override the default prompts
  prompts = {
    Explain = {
      prompt = '/COPILOT_EXPLAIN 選択したコードの説明を段落をつけて書いてください。',
      selection = select.selection,
    },
    Fix = {
      prompt = '/COPILOT_FIX このコードには問題があります。バグを修正したコードに書き換えてください。',
      selection = select.selection,
    },
    Optimize = {
      prompt = '/COPILOT_OPTIMIZE 選択したコードを最適化し、パフォーマンスと可読性を向上させてください。',
      selection = select.selection,
    },
    Docs = {
      prompt = '/COPILOT_DOCS 選択したコードのドキュメントを書いてください。ドキュメントをコメントとして追加した元のコードを含むコードブロックで回答してください。使用するプログラミング言語に最も適したドキュメントスタイルを使用してください（例：JavaScriptのJSDoc、Pythonのdocstringsなど）',
      selection = select.selection,
    },
    Tests = {
      prompt = '/COPILOT_TESTS 選択したコードの詳細な単体テスト関数を書いてください。',
      selection = select.selection,
    },
    FixDiagnostic = {
      prompt = '/COPILOT_FIXDIAGNOSTIC ファイル内の次のような診断上の問題を解決してください：',
      selection = select.diagnostics or select.selection,
    },
    Commit = {
      prompt = '/COPILOT_COMMIT この変更をコミットしてください。',
      selection = select.gitdiff or select.selection,
    },
    CommitStaged = {
      prompt = '/COPILOT_COMMITSTAGED ステージングされた変更をコミットしてください。',
      selection = select.selection,
    },
  },
}

-- chat with Copilot using the entire buffer content
function CopilotChatBuffer()
  local input = vim.fn.input 'Quick Chat: '
  if input ~= '' then
    chat.ask(input, { selection = select.buffer })
  end
end

-- chat with Copilot using the selected content
function CopilotChatSelection()
  local input = vim.fn.input 'Quick Chat: '
  if input ~= '' then
    chat.ask(input, { selection = select.selection })
  end
end

-- display the action prompt using telescope
function ShowCopilotChatActionPrompt()
  telescope.pick(actions.prompt_actions())
end

-- display the action prompt using telescope with the visual selection
function ShowCopilotChatActionPromptVisualSelection()
  telescope.pick(actions.prompt_actions {
    selection = select.selection,
  })
end

-- display the action help using telescope
function ShowCopilotChatActionHelp()
  telescope.pick(actions.help_actions())
end

-- cq (Copilot Chat Buffer) chat with Copilot using the entire buffer content
vim.api.nvim_set_keymap('n', 'cq', '<cmd>lua CopilotChatBuffer()<cr>', { noremap = true, silent = true })
-- cs (Copilot Chat Selection) chat with Copilot using the selected content
vim.api.nvim_set_keymap('v', 'cq', '<cmd>lua CopilotChatSelection()<cr>', { noremap = true, silent = true })
-- cp (Copilot Chat Prompt) display the action prompt using telescope
vim.api.nvim_set_keymap('n', 'cp', '<cmd>lua ShowCopilotChatActionPrompt()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap(
  'v',
  'cp',
  '<cmd>lua ShowCopilotChatActionPromptVisualSelection()<cr>',
  { noremap = true, silent = true }
)
-- ch (Copilot Chat Help) display the action help using telescope
vim.api.nvim_set_keymap('n', 'ch', '<cmd>lua ShowCopilotChatActionHelp()<cr>', { noremap = true, silent = true })
