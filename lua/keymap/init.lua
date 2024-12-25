-- 快捷键说明：
-- <leader>ph 显示插件管理器
-- <leader>ps 同步插件
-- <leader>pu 更新插件
-- <leader>pi 安装插件
-- <leader>pl 显示插件日志
-- <leader>pc 检查插件
-- <leader>pd 调试插件
-- <leader>pp 插件性能分析
-- <leader>pr 恢复插件
-- <leader>px 清理插件
-- jk 切换到普通模式

-- 加载键映射助手模块
require("keymap.helpers")
local bind = require("keymap.bind")
local map_cr = bind.map_cr -- 创建带 <CR> 的命令映射
local map_cmd = bind.map_cmd -- 创建命令映射
-- local map_cu = bind.map_cu
-- local map_callback = bind.map_callback

-- 插件管理器相关的快捷键映射
local plug_map = {
    -- 插件管理器: lazy.nvim
    ["n|<leader>ph"] = map_cr("Lazy"):with_silent():with_noremap():with_nowait():with_desc("插件: 显示插件管理器"), -- 显示插件管理器
    ["n|<leader>ps"] = map_cr("Lazy sync"):with_silent():with_noremap():with_nowait():with_desc("插件: 同步插件"), -- 同步插件
    ["n|<leader>pu"] = map_cr("Lazy update"):with_silent():with_noremap():with_nowait():with_desc("插件: 更新插件"), -- 更新插件
    ["n|<leader>pi"] = map_cr("Lazy install"):with_silent():with_noremap():with_nowait():with_desc("插件: 安装插件"), -- 安装插件
    ["n|<leader>pl"] = map_cr("Lazy log"):with_silent():with_noremap():with_nowait():with_desc("插件: 显示插件日志"), -- 显示插件日志
    ["n|<leader>pc"] = map_cr("Lazy check"):with_silent():with_noremap():with_nowait():with_desc("插件: 检查插件"), -- 检查插件
    ["n|<leader>pd"] = map_cr("Lazy debug"):with_silent():with_noremap():with_nowait():with_desc("插件: 调试插件"), -- 调试插件
    ["n|<leader>pp"] = map_cr("Lazy profile"):with_silent():with_noremap():with_nowait():with_desc("插件: 插件性能分析"), -- 插件性能分析
    ["n|<leader>pr"] = map_cr("Lazy restore"):with_silent():with_noremap():with_nowait():with_desc("插件: 恢复插件"), -- 恢复插件
    ["n|<leader>px"] = map_cr("Lazy clean"):with_silent():with_noremap():with_nowait():with_desc("插件: 清理插件"), -- 清理插件

    -- 插入模式下使用 jk 切换到普通模式
    ["i|jk"] = map_cmd("<Esc>"):with_noremap():with_desc("编辑: 切换到普通模式"), -- 切换到普通模式
}

-- 加载插件管理器相关的快捷键映射
bind.nvim_load_mapping(plug_map)

-- CopilotChat 相关的快捷键映射
local copilot_chat_map = {
    -- CopilotChat - 提示操作
    ["n|<leader>ap"] = map_cr(":lua require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').prompt_actions())<CR>")
      :with_silent()
      :with_noremap()
      :with_nowait()
      :with_desc("CopilotChat - 提示操作"),
    -- CopilotChat - 提示操作 (可视模式)
    ["x|<leader>ap"] = map_cr(":lua require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').prompt_actions({selection = require('CopilotChat.select').visual}))<CR>")
      :with_silent()
      :with_noremap()
      :with_nowait()
      :with_desc("CopilotChat - 可视模式提示操作"),
    -- 解释代码
    ["n|<leader>ae"] = map_cr("CopilotChatExplain")
      :with_desc("CopilotChat - 解释代码"),
    -- 生成测试
    ["n|<leader>at"] = map_cr("CopilotChatTests")
      :with_desc("CopilotChat - 生成测试"),
    -- 代码审查
    ["n|<leader>ar"] = map_cr("CopilotChatReview")
      :with_desc("CopilotChat - 代码审查"),
    -- 重构代码
    ["n|<leader>aR"] = map_cr("CopilotChatRefactor")
      :with_desc("CopilotChat - 重构代码"),
    -- 优化命名
    ["n|<leader>an"] = map_cr("CopilotChatBetterNamings")
      :with_desc("CopilotChat - 优化命名"),
    -- 在可视模式下打开 CopilotChat
    ["x|<leader>av"] = map_cmd(":CopilotChatVisual")
      :with_desc("CopilotChat - 在可视模式下打开"),
    -- 内联聊天
    ["x|<leader>ax"] = map_cr("CopilotChatInline")
      :with_desc("CopilotChat - 内联聊天"),
    -- 命令行输入
    ["n|<leader>ai"] = map_cmd("<Cmd>lua local input=vim.fn.input('询问Copilot: ') if input~='' then vim.cmd('CopilotChat '..input) end<CR>")
      :with_desc("CopilotChat - 命令行输入"),
    -- 生成提交信息
    ["n|<leader>am"] = map_cr("CopilotChatCommit")
      :with_desc("CopilotChat - 生成提交信息"),
    -- 快速聊天
    ["n|<leader>aq"] = map_cmd("<Cmd>lua local input=vim.fn.input('快速聊天: ') if input~='' then vim.cmd('CopilotChat '..input) end<CR>")
      :with_desc("CopilotChat - 快速聊天"),
    -- 调试信息
    ["n|<leader>ad"] = map_cr("CopilotChatDebugInfo")
      :with_desc("CopilotChat - 调试信息"),
    -- 修复诊断
    ["n|<leader>af"] = map_cr("CopilotChatFixDiagnostic")
      :with_desc("CopilotChat - 修复诊断"),
    -- 清空缓冲区和历史
    ["n|<leader>al"] = map_cr("CopilotChatReset")
      :with_desc("CopilotChat - 清空缓冲区和历史"),
    -- 打开/关闭 CopilotChat
    ["n|<leader>av"] = map_cr("CopilotChatToggle")
      :with_desc("CopilotChat - 打开或关闭"),
    -- 选择模型
    ["n|<leader>a?"] = map_cr("CopilotChatModels")
      :with_desc("CopilotChat - 选择模型"),
    -- 选择代理
    ["n|<leader>aa"] = map_cr("CopilotChatAgents")
      :with_desc("CopilotChat - 选择代理"),
  }
  
bind.nvim_load_mapping(copilot_chat_map)

-- 加载插件相关的快捷键映射
require("keymap.completion")
require("keymap.editor")
require("keymap.lang")
require("keymap.tool")
require("keymap.ui")

-- 尝试加载用户自定义的快捷键映射
local ok, mappings = pcall(require, "user.keymap.init")
if ok then
    require("modules.utils.keymap").replace(mappings)
end