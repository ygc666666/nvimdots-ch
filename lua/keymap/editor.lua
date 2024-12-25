-- 快捷键说明：
-- n 表示普通模式，v 表示可视模式，i 表示插入模式，c 表示命令模式
-- <C-s> 保存文件
-- <C-q> 保存文件并退出
-- <A-S-q> 强制退出
-- <C-u> 删除前一个块
-- <C-b> 光标左移
-- <C-a> 光标移动到行首
-- <C-s> 保存文件（插入模式）
-- <C-q> 保存文件并退出（插入模式）
-- <C-b> 光标左移（命令模式）
-- <C-f> 光标右移（命令模式）
-- <C-a> 光标移动到行首（命令模式）
-- <C-e> 光标移动到行尾（命令模式）
-- <C-d> 删除（命令模式）
-- <C-h> 退格（命令模式）
-- <C-t> 补全当前文件路径（命令模式）
-- J 将当前行向下移动
-- K 将当前行向上移动
-- < 将缩进减少
-- > 将缩进增加
-- Y 复制到行尾
-- D 删除到行尾
-- n 跳转到下一个搜索结果
-- N 跳转到上一个搜索结果
-- J 合并下一行
-- <S-Tab> 切换代码折叠
-- <Esc> 清除搜索高亮
-- <leader>o 切换拼写检查
-- <leader>ss 保存会话
-- <leader>sl 加载当前会话
-- <leader>sd 删除会话
-- gcc 切换行注释
-- gbc 切换块注释
-- gc 切换行注释（操作符）
-- gb 切换块注释（操作符）
-- gc 切换行注释（可视模式）
-- gb 切换块注释（可视模式）
-- <leader>gd 显示差异
-- <leader>gD 关闭差异
-- <leader>w 跳转到单词
-- <leader>j 跳转到行
-- <leader>k 跳转到行
-- <leader>c 跳转到一个字符
-- <leader>C 跳转到两个字符
-- <leader>Ss 切换搜索和替换面板
-- <leader>Sp 搜索并替换当前单词（项目）
-- <leader>Sf 搜索并替换当前单词（文件）
-- m 跨语法树操作
-- <A-s> 使用 sudo 保存文件

local bind = require("keymap.bind")
local map_cr = bind.map_cr -- 创建带 <CR> 的命令映射
local map_cu = bind.map_cu -- 创建带 <C-u> 和 <CR> 的命令映射
local map_cmd = bind.map_cmd -- 创建命令映射
local map_callback = bind.map_callback -- 创建回调函数映射
local et = bind.escape_termcode -- 转义终端代码

-- 内置快捷键映射
local builtin_map = {
    -- 内置: 保存 & 退出
    ["n|<C-s>"] = map_cu("write"):with_noremap():with_silent():with_desc("编辑: 保存文件"), -- 保存文件
    ["n|<C-q>"] = map_cr("wq"):with_desc("编辑: 保存文件并退出"), -- 保存文件并退出
    ["n|<A-S-q>"] = map_cr("q!"):with_desc("编辑: 强制退出"), -- 强制退出

    -- 内置: 插入模式
    ["i|<C-u>"] = map_cmd("<C-G>u<C-U>"):with_noremap():with_desc("编辑: 删除前一个块"), -- 删除前一个块
    ["i|<C-b>"] = map_cmd("<Left>"):with_noremap():with_desc("编辑: 光标左移"), -- 光标左移
    ["i|<C-a>"] = map_cmd("<ESC>^i"):with_noremap():with_desc("编辑: 光标移动到行首"), -- 光标移动到行首
    ["i|<C-s>"] = map_cmd("<Esc>:w<CR>"):with_desc("编辑: 保存文件"), -- 保存文件
    ["i|<C-q>"] = map_cmd("<Esc>:wq<CR>"):with_desc("编辑: 保存文件并退出"), -- 保存文件并退出

    -- 内置: 命令模式
    ["c|<C-b>"] = map_cmd("<Left>"):with_noremap():with_desc("编辑: 光标左移"), -- 光标左移
    ["c|<C-f>"] = map_cmd("<Right>"):with_noremap():with_desc("编辑: 光标右移"), -- 光标右移
    ["c|<C-a>"] = map_cmd("<Home>"):with_noremap():with_desc("编辑: 光标移动到行首"), -- 光标移动到行首
    ["c|<C-e>"] = map_cmd("<End>"):with_noremap():with_desc("编辑: 光标移动到行尾"), -- 光标移动到行尾
    ["c|<C-d>"] = map_cmd("<Del>"):with_noremap():with_desc("编辑: 删除"), -- 删除
    ["c|<C-h>"] = map_cmd("<BS>"):with_noremap():with_desc("编辑: 退格"), -- 退格
    ["c|<C-t>"] = map_cmd([[<C-R>=expand("%:p:h") . "/" <CR>]])
        :with_noremap()
        :with_desc("编辑: 补全当前文件路径"), -- 补全当前文件路径

    -- 内置: 可视模式
    ["v|J"] = map_cmd(":m '>+1<CR>gv=gv"):with_desc("编辑: 将当前行向下移动"), -- 将当前行向下移动
    ["v|K"] = map_cmd(":m '<-2<CR>gv=gv"):with_desc("编辑: 将当前行向上移动"), -- 将当前行向上移动
    ["v|<"] = map_cmd("<gv"):with_desc("编辑: 缩进减少"), -- 缩进减少
    ["v|>"] = map_cmd(">gv"):with_desc("编辑: 缩进增加"), -- 缩进增加

    -- 内置: 吸引
    ["n|Y"] = map_cmd("y$"):with_desc("编辑: 复制到行尾"), -- 复制到行尾
    ["n|D"] = map_cmd("d$"):with_desc("编辑: 删除到行尾"), -- 删除到行尾
    ["n|n"] = map_cmd("nzzzv"):with_noremap():with_desc("编辑: 跳转到下一个搜索结果"), -- 跳转到下一个搜索结果
    ["n|N"] = map_cmd("Nzzzv"):with_noremap():with_desc("编辑: 跳转到上一个搜索结果"), -- 跳转到上一个搜索结果
    ["n|J"] = map_cmd("mzJ`z"):with_noremap():with_desc("编辑: 合并下一行"), -- 合并下一行
    ["n|<S-Tab>"] = map_cr("normal za"):with_noremap():with_silent():with_desc("编辑: 切换代码折叠"), -- 切换代码折叠
    ["n|<Esc>"] = map_callback(function()
            _flash_esc_or_noh()
        end)
        :with_noremap()
        :with_silent()
        :with_desc("编辑: 清除搜索高亮"), -- 清除搜索高亮
    ["n|<leader>o"] = map_cr("setlocal spell! spelllang=en_us"):with_desc("编辑: 切换拼写检查"), -- 切换拼写检查
}

bind.nvim_load_mapping(builtin_map) -- 加载内置快捷键映射

-- 插件相关的快捷键映射
local plug_map = {
    -- 插件: persisted.nvim
    ["n|<leader>ss"] = map_cu("SessionSave"):with_noremap():with_silent():with_desc("会话: 保存"), -- 保存会话
    ["n|<leader>sl"] = map_cu("SessionLoad"):with_noremap():with_silent():with_desc("会话: 加载当前"), -- 加载当前会话
    ["n|<leader>sd"] = map_cu("SessionDelete"):with_noremap():with_silent():with_desc("会话: 删除"), -- 删除会话

    -- 插件: comment.nvim
    ["n|gcc"] = map_callback(function()
            return vim.v.count == 0 and et("<Plug>(comment_toggle_linewise_current)")
                or et("<Plug>(comment_toggle_linewise_count)")
        end)
        :with_silent()
        :with_noremap()
        :with_expr()
        :with_desc("编辑: 切换行注释"), -- 切换行注释
    ["n|gbc"] = map_callback(function()
            return vim.v.count == 0 and et("<Plug>(comment_toggle_blockwise_current)")
                or et("<Plug>(comment_toggle_blockwise_count)")
        end)
        :with_silent()
        :with_noremap()
        :with_expr()
        :with_desc("编辑: 切换块注释"), -- 切换块注释
    ["n|gc"] = map_cmd("<Plug>(comment_toggle_linewise)")
        :with_silent()
        :with_noremap()
        :with_desc("编辑: 切换行注释（操作符）"), -- 切换行注释（操作符）
    ["n|gb"] = map_cmd("<Plug>(comment_toggle_blockwise)")
        :with_silent()
        :with_noremap()
        :with_desc("编辑: 切换块注释（操作符）"), -- 切换块注释（操作符）
    ["x|gc"] = map_cmd("<Plug>(comment_toggle_linewise_visual)")
        :with_silent()
        :with_noremap()
        :with_desc("编辑: 切换行注释（可视模式）"), -- 切换行注释（可视模式）
    ["x|gb"] = map_cmd("<Plug>(comment_toggle_blockwise_visual)")
        :with_silent()
        :with_noremap()
        :with_desc("编辑: 切换块注释（可视模式）"), -- 切换块注释（可视模式）

    -- 插件: diffview.nvim
    ["n|<leader>gd"] = map_cr("DiffviewOpen"):with_silent():with_noremap():with_desc("git: 显示差异"), -- 显示差异
    ["n|<leader>gD"] = map_cr("DiffviewClose"):with_silent():with_noremap():with_desc("git: 关闭差异"), -- 关闭差异

    -- 插件: hop.nvim
    ["nv|<leader>w"] = map_cmd("<Cmd>HopWordMW<CR>"):with_noremap():with_desc("跳转: 跳转到单词"), -- 跳转到单词
    ["nv|<leader>j"] = map_cmd("<Cmd>HopLineMW<CR>"):with_noremap():with_desc("跳转: 跳转到行"), -- 跳转到行
    ["nv|<leader>k"] = map_cmd("<Cmd>HopLineMW<CR>"):with_noremap():with_desc("跳转: 跳转到行"), -- 跳转到行
    ["nv|<leader>c"] = map_cmd("<Cmd>HopChar1MW<CR>"):with_noremap():with_desc("跳转: 跳转到一个字符"), -- 跳转到一个字符
    ["nv|<leader>C"] = map_cmd("<Cmd>HopChar2MW<CR>"):with_noremap():with_desc("跳转: 跳转到两个字符"), -- 跳转到两个字符

    -- 插件: nvim-spectre
    ["n|<leader>Ss"] = map_callback(function()
            require("spectre").toggle()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("编辑: 切换搜索和替换面板"), -- 切换搜索和替换面板
    ["n|<leader>Sp"] = map_callback(function()
            require("spectre").open_visual({ select_word = true })
        end)
        :with_silent()
        :with_noremap()
        :with_desc("编辑: 搜索并替换当前单词（项目）"), -- 搜索并替换当前单词（项目）
    ["v|<leader>Sp"] = map_callback(function()
            require("spectre").open_visual()
        end)
        :with_silent()
        :with_noremap()
        :with_desc("编辑: 搜索并替换当前单词（项目）"), -- 搜索并替换当前单词（项目）
    ["n|<leader>Sf"] = map_callback(function()
            require("spectre").open_file_search({ select_word = true })
        end)
        :with_silent()
        :with_noremap()
        :with_desc("编辑: 搜索并替换当前单词（文件）"), -- 搜索并替换当前单词（文件）

    -- 插件: nvim-treehopper
    ["o|m"] = map_cu("lua require('tsht').nodes()"):with_silent():with_desc("跳转: 跨语法树操作"), -- 跨语法树操作

    -- 插件: suda.vim
    ["n|<A-s>"] = map_cu("SudaWrite"):with_silent():with_noremap():with_desc("编辑: 使用 sudo 保存文件"), -- 使用 sudo 保存文件
}

bind.nvim_load_mapping(plug_map) -- 加载插件相关的快捷键映射