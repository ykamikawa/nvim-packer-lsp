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

-- chat with Copilot using the selected content
function CopilotChatSelection()
  local input = vim.fn.input 'Quick Chat: '
  if input ~= '' then
    chat.ask(input, { selection = select.selection })
  end
end

-- chat with Copilot using the entire buffer content
function CopilotChatBuffer()
  local input = vim.fn.input 'Quick Chat: '
  if input ~= '' then
    chat.ask(input, { selection = select.buffer })
  end
end

-- chat with Copilot using the selected content
function CopilotChatLoadRepository()
  local repo_path = vim.fn.input('Enter repository repository path: ')
  if repo_path == '' then
    repo_path = vim.fn.system('git rev-parse --show-toplevel'):gsub("\n", "")
  else
    -- Check if the path is relative and convert to absolute path
    if not repo_path:match("^/") then
      repo_path = vim.fn.expand(vim.fn.getcwd() .. '/' .. repo_path)
    end
  end
  local input = vim.fn.input 'Quick Chat: '
  if input ~= '' then
    local gpt_repo_loader_dir = os.getenv("HOME") .. '/gpt-repository-loader/'
    local output_file_path = gpt_repo_loader_dir .. 'output.txt'
    local cmd = 'python ' ..
        gpt_repo_loader_dir ..
        'gpt_repository_loader.py ' .. repo_path .. ' -o ' .. output_file_path
    vim.fn.system(cmd)
    local file_path = vim.fn.expand(output_file_path)
    local file_content = vim.fn.readfile(file_path)
    if not file_content or #file_content == 0 then
      vim.notify('No content found in ' .. file_path, vim.log.levels.ERROR)
      return
    end
    chat.ask(input, {
      selection = function()
        return
        {
          lines = table.concat(file_content, '\n'),
          filename = file_path,
          filetype = vim.fn.fnamemodify(file_path, ':e'),
        }
      end
    })
  end
end

chat.setup {
  debug = true,           -- Enable debug mode
  proxy = nil,            -- Proxy server URL
  allow_insecure = false, -- Allow insecure connections

  model = "gpt-4o",       -- Model to use for chat
  temperature = 0.1,      -- Temperature for sampling

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
    LoadRepository = {
      prompt = "Load and chat with the content of gpt-repository-loader file for the current repository",
      selection = CopilotChatLoadRepository,
    }
  },
  window = {
    layout = 'vertical',                                   -- 'vertical', 'horizontal', 'float', 'replace'
    width = 0.3,                                           -- fractional width of parent, or absolute width in columns when > 1
    height = 1.0,                                          -- fractional height of parent, or absolute height in rows when > 1
    -- Options below only apply to floating windows
    relative = 'editor',                                   -- 'editor', 'win', 'cursor', 'mouse'
    border = 'single',                                     -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
    row = 0,                                               -- row position of the window, default is centered
    col = vim.o.columns - math.floor(vim.o.columns * 0.3), -- column position of the window, default is centered
    title = 'Copilot Chat',                                -- title of chat window
    footer = nil,                                          -- footer of chat window
    zindex = 1,                                            -- determines if window is on top or below other floating windows
  },
}
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
-- cr (Copilot Chat Load Repository) chat with Copilot using the GPT repository loader file content
vim.api.nvim_set_keymap('n', 'cr', '<cmd>lua CopilotChatLoadRepository()<cr>', { noremap = true, silent = true })
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
