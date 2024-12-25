-- 快捷键说明：
-- <F1> 切换 Markdown 预览（render-markdown.nvim 插件）
-- <F12> 切换 Markdown 预览（MarkdownPreview 插件）

local bind = require("keymap.bind")
local map_cr = bind.map_cr -- 创建带 <CR> 的命令映射
-- local map_cu = bind.map_cu
-- local map_cmd = bind.map_cmd
-- local map_callback = bind.map_callback

local plug_map = {
    -- 插件 render-markdown.nvim
    ["n|<F1>"] = map_cr("RenderMarkdown toggle")
        :with_noremap()
        :with_silent()
        :with_desc("工具: 切换 Markdown 预览"), -- 切换 Markdown 预览
    -- 插件 MarkdownPreview
    ["n|<F12>"] = map_cr("MarkdownPreviewToggle")
        :with_noremap()
        :with_silent()
        :with_desc("工具: 预览 Markdown"), -- 预览 Markdown
}

bind.nvim_load_mapping(plug_map) -- 加载插件相关的快捷键映射