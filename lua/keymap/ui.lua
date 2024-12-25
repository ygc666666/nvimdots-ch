-- 快捷键说明：
-- <leader>bn 新建缓冲区
-- <C-w>h 窗口焦点左移
-- <C-w>l 窗口焦点右移
-- <C-w>j 窗口焦点下移
-- <C-w>k 窗口焦点上移
-- tn 新建标签页
-- tk 移动到下一个标签页
-- tj 移动到上一个标签页
-- to 只保留当前标签页
-- <A-q> 关闭当前缓冲区
-- <A-i> 切换到下一个缓冲区
-- <A-o> 切换到上一个缓冲区
-- <A-S-i> 移动当前缓冲区到下一个位置
-- <A-S-o> 移动当前缓冲区到上一个位置
-- <leader>be 按扩展名排序缓冲区
-- <leader>bd 按目录排序缓冲区
-- <A-1> 跳转到缓冲区 1
-- <A-2> 跳转到缓冲区 2
-- <A-3> 跳转到缓冲区 3
-- <A-4> 跳转到缓冲区 4
-- <A-5> 跳转到缓冲区 5
-- <A-6> 跳转到缓冲区 6
-- <A-7> 跳转到缓冲区 7
-- <A-8> 跳转到缓冲区 8
-- <A-9> 跳转到缓冲区 9
-- <A-h> 水平缩小窗口
-- <A-j> 垂直缩小窗口
-- <A-k> 垂直放大窗口
-- <A-l> 水平放大窗口
-- <C-h> 窗口焦点左移
-- <C-j> 窗口焦点下移
-- <C-k> 窗口焦点上移
-- <C-l> 窗口焦点右移
-- <leader>Wh 窗口左移
-- <leader>Wj 窗口下移
-- <leader>Wk 窗口上移
-- <leader>Wl 窗口右移

local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
-- local map_callback = bind.map_callback

local builtin_map = {
    -- 内置: 缓冲区
    ["n|<leader>bn"] = map_cu("enew"):with_noremap():with_silent():with_desc("缓冲区: 新建"), -- 新建缓冲区

    -- 内置: 终端
    ["t|<C-w>h"] = map_cmd("<Cmd>wincmd h<CR>"):with_silent():with_noremap():with_desc("窗口: 焦点左移"), -- 窗口焦点左移
    ["t|<C-w>l"] = map_cmd("<Cmd>wincmd l<CR>"):with_silent():with_noremap():with_desc("窗口: 焦点右移"), -- 窗口焦点右移
    ["t|<C-w>j"] = map_cmd("<Cmd>wincmd j<CR>"):with_silent():with_noremap():with_desc("窗口: 焦点下移"), -- 窗口焦点下移
    ["t|<C-w>k"] = map_cmd("<Cmd>wincmd k<CR>"):with_silent():with_noremap():with_desc("窗口: 焦点上移"), -- 窗口焦点上移

    -- 内置: 标签页
    ["n|tn"] = map_cr("tabnew"):with_noremap():with_silent():with_desc("标签页: 新建"), -- 新建标签页
    ["n|tk"] = map_cr("tabnext"):with_noremap():with_silent():with_desc("标签页: 移动到下一个"), -- 移动到下一个标签页
    ["n|tj"] = map_cr("tabprevious"):with_noremap():with_silent():with_desc("标签页: 移动到上一个"), -- 移动到上一个标签页
    ["n|to"] = map_cr("tabonly"):with_noremap():with_silent():with_desc("标签页: 只保留当前"), -- 只保留当前标签页
}

bind.nvim_load_mapping(builtin_map)

local plug_map = {
    -- 插件: nvim-bufdel
    ["n|<A-q>"] = map_cr("BufDel"):with_noremap():with_silent():with_desc("缓冲区: 关闭当前"), -- 关闭当前缓冲区

    -- 插件: bufferline.nvim
    ["n|<A-i>"] = map_cr("BufferLineCycleNext"):with_noremap():with_silent():with_desc("缓冲区: 切换到下一个"), -- 切换到下一个缓冲区
    ["n|<A-o>"] = map_cr("BufferLineCyclePrev"):with_noremap():with_silent():with_desc("缓冲区: 切换到上一个"), -- 切换到上一个缓冲区
    ["n|<A-S-i>"] = map_cr("BufferLineMoveNext"):with_noremap():with_silent():with_desc("缓冲区: 移动到下一个位置"), -- 移动当前缓冲区到下一个位置
    ["n|<A-S-o>"] = map_cr("BufferLineMovePrev"):with_noremap():with_silent():with_desc("缓冲区: 移动到上一个位置"), -- 移动当前缓冲区到上一个位置
    ["n|<leader>be"] = map_cr("BufferLineSortByExtension"):with_noremap():with_desc("缓冲区: 按扩展名排序"), -- 按扩展名排序缓冲区
    ["n|<leader>bd"] = map_cr("BufferLineSortByDirectory"):with_noremap():with_desc("缓冲区: 按目录排序"), -- 按目录排序缓冲区
    ["n|<A-1>"] = map_cr("BufferLineGoToBuffer 1"):with_noremap():with_silent():with_desc("缓冲区: 跳转到 1"), -- 跳转到缓冲区 1
    ["n|<A-2>"] = map_cr("BufferLineGoToBuffer 2"):with_noremap():with_silent():with_desc("缓冲区: 跳转到 2"), -- 跳转到缓冲区 2
    ["n|<A-3>"] = map_cr("BufferLineGoToBuffer 3"):with_noremap():with_silent():with_desc("缓冲区: 跳转到 3"), -- 跳转到缓冲区 3
    ["n|<A-4>"] = map_cr("BufferLineGoToBuffer 4"):with_noremap():with_silent():with_desc("缓冲区: 跳转到 4"), -- 跳转到缓冲区 4
    ["n|<A-5>"] = map_cr("BufferLineGoToBuffer 5"):with_noremap():with_silent():with_desc("缓冲区: 跳转到 5"), -- 跳转到缓冲区 5
    ["n|<A-6>"] = map_cr("BufferLineGoToBuffer 6"):with_noremap():with_silent():with_desc("缓冲区: 跳转到 6"), -- 跳转到缓冲区 6
    ["n|<A-7>"] = map_cr("BufferLineGoToBuffer 7"):with_noremap():with_silent():with_desc("缓冲区: 跳转到 7"), -- 跳转到缓冲区 7
    ["n|<A-8>"] = map_cr("BufferLineGoToBuffer 8"):with_noremap():with_silent():with_desc("缓冲区: 跳转到 8"), -- 跳转到缓冲区 8
    ["n|<A-9>"] = map_cr("BufferLineGoToBuffer 9"):with_noremap():with_silent():with_desc("缓冲区: 跳转到 9"), -- 跳转到缓冲区 9

    -- 插件: smart-splits.nvim
    ["n|<A-h>"] = map_cu("SmartResizeLeft"):with_silent():with_noremap():with_desc("窗口: 水平缩小"), -- 水平缩小窗口
    ["n|<A-j>"] = map_cu("SmartResizeDown"):with_silent():with_noremap():with_desc("窗口: 垂直缩小"), -- 垂直缩小窗口
    ["n|<A-k>"] = map_cu("SmartResizeUp"):with_silent():with_noremap():with_desc("窗口: 垂直放大"), -- 垂直放大窗口
    ["n|<A-l>"] = map_cu("SmartResizeRight"):with_silent():with_noremap():with_desc("窗口: 水平放大"), -- 水平放大窗口
    ["n|<C-h>"] = map_cu("SmartCursorMoveLeft"):with_silent():with_noremap():with_desc("窗口: 焦点左移"), -- 窗口焦点左移
    ["n|<C-j>"] = map_cu("SmartCursorMoveDown"):with_silent():with_noremap():with_desc("窗口: 焦点下移"), -- 窗口焦点下移
    ["n|<C-k>"] = map_cu("SmartCursorMoveUp"):with_silent():with_noremap():with_desc("窗口: 焦点上移"), -- 窗口焦点上移
    ["n|<C-l>"] = map_cu("SmartCursorMoveRight"):with_silent():with_noremap():with_desc("窗口: 焦点右移"), -- 窗口焦点右移
    ["n|<leader>Wh"] = map_cu("SmartSwapLeft"):with_silent():with_noremap():with_desc("窗口: 左移"), -- 窗口左移
    ["n|<leader>Wj"] = map_cu("SmartSwapDown"):with_silent():with_noremap():with_desc("窗口: 下移"), -- 窗口下移
    ["n|<leader>Wk"] = map_cu("SmartSwapUp"):with_silent():with_noremap():with_desc("窗口: 上移"), -- 窗口上移
    ["n|<leader>Wl"] = map_cu("SmartSwapRight"):with_silent():with_noremap():with_desc("窗口: 右移"), -- 窗口右移
}

bind.nvim_load_mapping(plug_map)

local mapping = {}

function mapping.gitsigns(buf)
    local actions = require("gitsigns.actions")
    local map = {
        ["n|]g"] = bind.map_callback(function()
            if vim.wo.diff then
                return "]g"
            end
            vim.schedule(function()
                actions.next_hunk()
            end)
            return "<Ignore>"
        end)
            :with_buffer(buf)
            :with_expr()
            :with_desc("git: 跳转到下一个 hunk"), -- 跳转到下一个 hunk
        ["n|[g"] = bind.map_callback(function()
            if vim.wo.diff then
                return "[g"
            end
            vim.schedule(function()
                actions.prev_hunk()
            end)
            return "<Ignore>"
        end)
            :with_buffer(buf)
            :with_expr()
            :with_desc("git: 跳转到上一个 hunk"), -- 跳转到上一个 hunk
        ["n|<leader>gs"] = bind.map_callback(function()
            actions.stage_hunk()
        end)
            :with_buffer(buf)
            :with_desc("git: 暂存 hunk"), -- 暂存 hunk
        ["v|<leader>gs"] = bind.map_callback(function()
            actions.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)
            :with_buffer(buf)
            :with_desc("git: 暂存 hunk"), -- 暂存 hunk
        ["n|<leader>gu"] = bind.map_callback(function()
            actions.undo_stage_hunk()
        end)
            :with_buffer(buf)
            :with_desc("git: 撤销暂存 hunk"), -- 撤销暂存 hunk
        ["n|<leader>gr"] = bind.map_callback(function()
            actions.reset_hunk()
        end)
            :with_buffer(buf)
            :with_desc("git: 重置 hunk"), -- 重置 hunk
        ["v|<leader>gr"] = bind.map_callback(function()
            actions.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)
            :with_buffer(buf)
            :with_desc("git: 重置 hunk"), -- 重置 hunk
        ["n|<leader>gR"] = bind.map_callback(function()
            actions.reset_buffer()
        end)
            :with_buffer(buf)
            :with_desc("git: 重置缓冲区"), -- 重置缓冲区
        ["n|<leader>gp"] = bind.map_callback(function()
            actions.preview_hunk()
        end)
            :with_buffer(buf)
            :with_desc("git: 预览 hunk"), -- 预览 hunk
        ["n|<leader>gb"] = bind.map_callback(function()
            actions.blame_line({ full = true })
        end)
            :with_buffer(buf)
            :with_desc("git: 责备行"), -- 责备行
        -- 文本对象
        ["ox|ih"] = bind.map_callback(function()
            actions.text_object()
        end):with_buffer(buf),
    }
    bind.nvim_load_mapping(map)
end

return mapping