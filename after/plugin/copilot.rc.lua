vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-i>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

local status, chat = pcall(require, "CopilotChat")
if (not status) then return end
if (not chat) then return end
chat.setup {
  debug = true,    -- Enable debug mode
  model = 'gpt-4', -- Use the GPT-4 model
}

-- バッファの内容全体を使って Copilot とチャット
function CopilotChatBuffer()
  local input = vim.fn.input("Quick Chat: ")
  if input ~= "" then
    require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
  end
end

-- 選択範囲の内容全体を使って Copilot とチャット
function CopilotChatSelection()
  local input = vim.fn.input("Quick Chat: ")
  if input ~= "" then
    require("CopilotChat").ask(input, { selection = require("CopilotChat.select").selection })
  end
end

-- telescope を使ってアクションプロンプトを表示
function ShowCopilotChatActionPrompt()
  local actions = require("CopilotChat.actions")
  require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
end

-- 選択した範囲の内容全体にtelescopeを使ってアクションプロンプトを表示
function ShowCopilotChatActionPromptVisualSelection()
  local actions = require("CopilotChat.actions")
  require("CopilotChat.integrations.telescope").pick(actions.prompt_actions({
    selection = require("CopilotChat.select")
        .selection
  }))
end

-- telescopeを使ってアクションプロンプトのヘルプを表示
function ShowCopilotChatActionHelp()
  local actions = require("CopilotChat.actions")
  require("CopilotChat.integrations.telescope").pick(actions.help_actions())
end

-- Prompt Actionsの日本語化
local select = require('CopilotChat.select')
require("CopilotChat").setup {
  debug = true, -- Enable debugging

  -- プロンプトの設定
  -- デフォルトは英語なので日本語でオーバーライドしています
  prompts = {
    Explain = {
      prompt = '/COPILOT_EXPLAIN 選択したコードの説明を段落をつけて書いてください。',
    },
    Fix = {
      prompt = '/COPILOT_FIX このコードには問題があります。バグを修正したコードに書き換えてください。',
    },
    Optimize = {
      prompt = '/COPILOT_OPTIMIZE 選択したコードを最適化し、パフォーマンスと可読性を向上させてください。',
    },
    Docs = {
      prompt = '/COPILOT_DOCS 選択したコードのドキュメントを書いてください。ドキュメントをコメントとして追加した元のコードを含むコードブロックで回答してください。使用するプログラミング言語に最も適したドキュメントスタイルを使用してください（例：JavaScriptのJSDoc、Pythonのdocstringsなど）',
    },
    Tests = {
      prompt = '/COPILOT_TESTS 選択したコードの詳細な単体テスト関数を書いてください。',
    },
    FixDiagnostic = {
      prompt = '/COPILOT_FIXDIAGNOSTIC ファイル内の次のような診断上の問題を解決してください：',
      selection = select.diagnostics,
    },
    Commit = {
      prompt = '/COPILOT_COMMIT この変更をコミットしてください。',
    },
    CommitStaged = {
      prompt = '/COPILOT_COMMITSTAGED ステージングされた変更をコミットしてください。',
    },
  }
}

-- cq (Copilot Chat Quick) で buffer全体の内容でCopilot とチャット
vim.api.nvim_set_keymap("n", "cq", "<cmd>lua CopilotChatBuffer()<cr>", { noremap = true, silent = true })
-- cs (Copilot Chat Selection) で選択範囲とCopilot とチャット
vim.api.nvim_set_keymap("v", "cq", "<cmd>lua CopilotChatSelection()<cr>", { noremap = true, silent = true })
-- cp (Copilot Chat Prompt の略) でアクションプロンプトを表示
vim.api.nvim_set_keymap("n", "cp", "<cmd>lua ShowCopilotChatActionPrompt()<cr>",
  { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "cp", "<cmd>lua ShowCopilotChatActionPromptVisualSelection()<cr>",
  { noremap = true, silent = true })
-- ch (Copilot Chat Help) でアクションプロンプトのヘルプを表示
vim.api.nvim_set_keymap("n", "ch", "<cmd>lua ShowCopilotChatActionHelp()<cr>",
  { noremap = true, silent = true })
