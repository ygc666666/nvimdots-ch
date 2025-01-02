local IS_DEV = false

local prompts = {
    -- 代码相关提示词
    Explain = "请解释以下代码的工作原理。",
    Review = "请审查以下代码并提供改进建议。",
    Tests = "请解释所选代码的工作原理，然后为其生成单元测试。",
    Refactor = "请重构以下代码以提高其清晰度和可读性。",
    FixCode = "请修复以下代码使其按预期工作。",
    FixError = "请解释以下文本中的错误并提供解决方案。",
    BetterNamings = "请为以下变量和函数提供更好的名称。",
    Documentation = "请为以下代码提供文档。",
    SwaggerApiDocs = "请使用Swagger为以下API提供文档。",
    SwaggerJsDocs = "请使用Swagger为以下API编写JSDoc。",
    -- 文本相关提示词
    Summarize = "请总结以下文本。",
    Spelling = "请纠正以下文本中的语法和拼写错误。",
    Wording = "请改进以下文本的语法和措辞。",
    Concise = "请重写以下文本使其更简洁。",
}

return {
  { import = "plugins.extras.copilot-vim" }, -- Or use { import = "lazyvim.plugins.extras.coding.copilot" },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>a", group = "ai" },
      },
    },
  },
  {
    dir = IS_DEV and "~/Projects/research/CopilotChat.nvim" or nil,
    "CopilotC-Nvim/CopilotChat.nvim",
    -- version = "v3.3.0", -- Use a specific version to prevent breaking changes
    dependencies = {
      { "nvim-telescope/telescope.nvim" }, -- Use telescope for help actions
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      question_header = "## User ",
      answer_header = "## Copilot ",
      error_header = "## Error ",
      prompts = prompts,
      auto_follow_cursor = false, -- Don't follow the cursor after getting response
      mappings = {
        -- Use tab for completion
        complete = {
          detail = "Use @<Tab> or /<Tab> for options.",
          insert = "<Tab>",
        },
        -- Close the chat
        close = {
          normal = "q",
          insert = "<C-c>",
        },
        -- Reset the chat buffer
        reset = {
          normal = "<C-x>",
          insert = "<C-x>",
        },
        -- Submit the prompt to Copilot
        submit_prompt = {
          normal = "<CR>",
          insert = "<C-CR>",
        },
        -- Accept the diff
        accept_diff = {
          normal = "<C-y>",
          insert = "<C-y>",
        },
        -- Show help
        show_help = {
          normal = "g?",
        },
      },
    },
    config = function(_, opts)
      local chat = require("CopilotChat")
      chat.setup(opts)

      local select = require("CopilotChat.select")
      vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
        chat.ask(args.args, { selection = select.visual })
      end, { nargs = "*", range = true })

      -- Inline chat with Copilot
      vim.api.nvim_create_user_command("CopilotChatInline", function(args)
        chat.ask(args.args, {
          selection = select.visual,
          window = {
            layout = "float",
            relative = "editor",
            width = 0.5, -- 设置宽度为屏幕宽度的一半
            height = 0.4, -- 设置高度为屏幕高度的40%
            row = (vim.o.lines - vim.o.lines * 0.4) / 2, -- 设置到屏幕中间
            col = (vim.o.columns - vim.o.columns * 0.5) / 2, -- 设置到屏幕中间
          },
        })
      end, { nargs = "*", range = true })

      -- Restore CopilotChatBuffer
      vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
        chat.ask(args.args, { selection = select.buffer })
      end, { nargs = "*", range = true })

      -- Custom buffer for CopilotChat
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-*",
        callback = function()
          vim.opt_local.relativenumber = true
          vim.opt_local.number = true

          -- Get current filetype and set it to markdown if the current filetype is copilot-chat
          local ft = vim.bo.filetype
          if ft == "copilot-chat" then
            vim.bo.filetype = "markdown"
          end
        end,
      })
    end,
    event = "VeryLazy",
    keys = {
      -- Show prompts actions with telescope
    --   {
    --     "<leader>ap",
    --     function()
    --       local actions = require("CopilotChat.actions")
    --       require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
    --     end,
    --     desc = "CopilotChat - Prompt actions",
    --   },
    --   {
    --     "<leader>ap",
    --     ":lua require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').prompt_actions({selection = require('CopilotChat.select').visual}))<CR>",
    --     mode = "x",
    --     desc = "CopilotChat - Prompt actions",
    --   },
      -- Code related commands
    --   { "<leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
    --   { "<leader>at", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
    --   { "<leader>ar", "<cmd>CopilotChatReview<cr>", desc = "CopilotChat - Review code" },
    --   { "<leader>aR", "<cmd>CopilotChatRefactor<cr>", desc = "CopilotChat - Refactor code" },
    --   { "<leader>an", "<cmd>CopilotChatBetterNamings<cr>", desc = "CopilotChat - Better Naming" },
      -- Chat with Copilot in visual mode
    --   {
    --     "<leader>av",
    --     ":CopilotChatVisual",
    --     mode = "x",
    --     desc = "CopilotChat - Open in vertical split",
    --   },
    --   {
    --     "<leader>ax",
    --     ":CopilotChatInline<cr>",
    --     mode = "x",
    --     desc = "CopilotChat - Inline chat",
    --   },
    --   -- Custom input for CopilotChat
    --   {
    --     "<leader>ai",
    --     function()
    --       local input = vim.fn.input("Ask Copilot: ")
    --       if input ~= "" then
    --         vim.cmd("CopilotChat " .. input)
    --       end
    --     end,
    --     desc = "CopilotChat - Ask input",
    --   },
    --   -- Generate commit message based on the git diff
    --   {
    --     "<leader>am",
    --     "<cmd>CopilotChatCommit<cr>",
    --     desc = "CopilotChat - Generate commit message for all changes",
    --   },
    --   -- Quick chat with Copilot
    --   {
    --     "<leader>aq",
    --     function()
    --       local input = vim.fn.input("Quick Chat: ")
    --       if input ~= "" then
    --         vim.cmd("CopilotChatBuffer " .. input)
    --       end
    --     end,
    --     desc = "CopilotChat - Quick chat",
    --   },
      -- Debug
    --   { "<leader>ad", "<cmd>CopilotChatDebugInfo<cr>", desc = "CopilotChat - Debug Info" },
    --   -- Fix the issue with diagnostic
    --   { "<leader>af", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "CopilotChat - Fix Diagnostic" },
    --   -- Clear buffer and chat history
    --   { "<leader>al", "<cmd>CopilotChatReset<cr>", desc = "CopilotChat - Clear buffer and chat history" },
    --   -- Toggle Copilot Chat Vsplit
    --   { "<leader>av", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle" },
    --   -- Copilot Chat Models
    --   { "<leader>a?", "<cmd>CopilotChatModels<cr>", desc = "CopilotChat - Select Models" },
    --   -- Copilot Chat Agents
    --   { "<leader>aa", "<cmd>CopilotChatAgents<cr>", desc = "CopilotChat - Select Agents" },
    },
  }
}