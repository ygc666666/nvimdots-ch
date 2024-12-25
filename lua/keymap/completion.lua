-- 快捷键说明：
-- n 表示普通模式，v 表示可视模式
-- <A-f> 切换自动格式化
-- <A-S-f> 手动格式化缓冲区
-- <leader>li 显示 LSP 信息
-- <leader>lr 重启 LSP
-- go 切换大纲视图
-- gto 在 Telescope 中切换大纲视图
-- g[ 跳转到上一个诊断信息
-- g] 跳转到下一个诊断信息
-- <leader>lx 显示行诊断信息
-- gs 显示签名帮助
-- gr 重命名（文件范围）
-- gR 重命名（项目范围）
-- K 显示文档
-- ga 执行代码操作
-- gd 预览定义
-- gD 跳转到定义
-- gh 显示引用
-- gm 显示实现
-- gci 显示传入调用
-- gco 显示传出调用
-- <leader>td 切换当前缓冲区的虚拟文本显示
-- <leader>th 切换当前缓冲区的内联提示显示

local bind = require("keymap.bind")
local map_cr = bind.map_cr -- 创建带 <CR> 的命令映射
local map_cmd = bind.map_cmd -- 创建命令映射
local map_callback = bind.map_callback -- 创建回调函数映射

-- 插件相关的快捷键映射
local plug_map = {
    ["n|<A-f>"] = map_cmd("<Cmd>FormatToggle<CR>"):with_noremap():with_desc("格式化器: 切换自动格式化"), -- 切换自动格式化
    ["n|<A-S-f>"] = map_cmd("<Cmd>Format<CR>"):with_noremap():with_desc("格式化器: 手动格式化缓冲区"), -- 手动格式化缓冲区
}
bind.nvim_load_mapping(plug_map) -- 加载插件相关的快捷键映射

local mapping = {}

-- 定义 LSP 相关的快捷键映射
function mapping.lsp(buf)
    local map = {
        -- 仅在附加了 LSP 的缓冲区中有效的 LSP 相关快捷键映射
        ["n|<leader>li"] = map_cr("LspInfo"):with_silent():with_buffer(buf):with_desc("LSP: 显示信息"), -- 显示 LSP 信息
        ["n|<leader>lr"] = map_cr("LspRestart"):with_silent():with_buffer(buf):with_nowait():with_desc("LSP: 重启"), -- 重启 LSP
        ["n|go"] = map_cr("AerialToggle!"):with_silent():with_buffer(buf):with_desc("LSP: 切换大纲视图"), -- 切换大纲视图
        ["n|gto"] = map_callback(function()
                require("telescope").extensions.aerial.aerial()
            end)
            :with_silent()
            :with_buffer(buf)
            :with_desc("LSP: 在 Telescope 中切换大纲视图"), -- 在 Telescope 中切换大纲视图
        ["n|g["] = map_cr("Lspsaga diagnostic_jump_prev")
            :with_silent()
            :with_buffer(buf)
            :with_desc("LSP: 跳转到上一个诊断信息"), -- 跳转到上一个诊断信息
        ["n|g]"] = map_cr("Lspsaga diagnostic_jump_next")
            :with_silent()
            :with_buffer(buf)
            :with_desc("LSP: 跳转到下一个诊断信息"), -- 跳转到下一个诊断信息
        ["n|<leader>lx"] = map_cr("Lspsaga show_line_diagnostics ++unfocus")
            :with_silent()
            :with_buffer(buf)
            :with_desc("LSP: 显示行诊断信息"), -- 显示行诊断信息
        ["n|gs"] = map_callback(function()
            vim.lsp.buf.signature_help()
        end):with_desc("LSP: 显示签名帮助"), -- 显示签名帮助
        ["n|gr"] = map_cr("Lspsaga rename"):with_silent():with_buffer(buf):with_desc("LSP: 文件范围重命名"), -- 重命名（文件范围）
        ["n|gR"] = map_cr("Lspsaga rename ++project")
            :with_silent()
            :with_buffer(buf)
            :with_desc("LSP: 项目范围重命名"), -- 重命名（项目范围）
        ["n|K"] = map_cr("Lspsaga hover_doc"):with_silent():with_buffer(buf):with_desc("LSP: 显示文档"), -- 显示文档
        ["nv|ga"] = map_cr("Lspsaga code_action")
            :with_silent()
            :with_buffer(buf)
            :with_desc("LSP: 执行代码操作"), -- 执行代码操作
        ["n|gd"] = map_cr("Glance definitions"):with_silent():with_buffer(buf):with_desc("LSP: 预览定义"), -- 预览定义
        ["n|gD"] = map_cr("Lspsaga goto_definition"):with_silent():with_buffer(buf):with_desc("LSP: 跳转到定义"), -- 跳转到定义
        ["n|gh"] = map_cr("Glance references"):with_silent():with_buffer(buf):with_desc("LSP: 显示引用"), -- 显示引用
        ["n|gm"] = map_cr("Glance implementations")
            :with_silent()
            :with_buffer(buf)
            :with_desc("LSP: 显示实现"), -- 显示实现
        ["n|gci"] = map_cr("Lspsaga incoming_calls")
            :with_silent()
            :with_buffer(buf)
            :with_desc("LSP: 显示传入调用"), -- 显示传入调用
        ["n|gco"] = map_cr("Lspsaga outgoing_calls")
            :with_silent()
            :with_buffer(buf)
            :with_desc("LSP: 显示传出调用"), -- 显示传出调用
        ["n|<leader>td"] = map_callback(function()
                _toggle_diagnostic()
            end)
            :with_noremap()
            :with_silent()
            :with_desc("编辑: 切换当前缓冲区的虚拟文本显示"), -- 切换当前缓冲区的虚拟文本显示
        ["n|<leader>th"] = map_callback(function()
                _toggle_inlayhint()
            end)
            :with_noremap()
            :with_silent()
            :with_desc("编辑: 切换当前缓冲区的内联提示显示"), -- 切换当前缓冲区的内联提示显示
    }
    bind.nvim_load_mapping(map) -- 加载 LSP 相关的快捷键映射

    -- 尝试加载用户自定义的 LSP 快捷键映射
    local ok, user_mappings = pcall(require, "user.keymap.completion")
    if ok and type(user_mappings.lsp) == "function" then
        require("modules.utils.keymap").replace(user_mappings.lsp(buf))
    end
end

return mapping