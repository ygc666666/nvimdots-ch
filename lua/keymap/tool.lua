-- 快捷键说明：
-- gps 推送代码到远程仓库
-- gpl 从远程仓库拉取代码
-- <leader>gG 打开 git-fugitive
-- <C-n> 切换文件树
-- <leader>nf 定位文件
-- <leader>nr 刷新文件树
-- <leader>r 运行代码（文件范围）
-- <leader>r 运行代码（选中范围）
-- <Esc><Esc> 终端模式切换到普通模式
-- <C-\> 切换水平终端
-- <A-\> 切换垂直终端
-- <F5> 切换垂直终端
-- <A-d> 切换浮动终端
-- <leader>gg 切换 lazygit
-- gt 切换诊断列表
-- <leader>lw 显示工作区诊断
-- <leader>lp 显示项目诊断
-- <leader>ld 显示文档诊断
-- <C-p> 打开命令面板
-- <leader>fc 打开 Telescope 集合
-- <leader>ff 查找文件
-- <leader>fp 查找模式
-- <leader>fs 查找光标下的单词
-- <leader>fg 定位 Git 对象
-- <leader>fd 检索档案
-- <leader>fm 杂项
-- <F6> 运行/继续调试
-- <F7> 停止调试
-- <F8> 切换断点
-- <F9> 进入下一步
-- <F10> 跳出
-- <F11> 跳过
-- <leader>db 设置条件断点
-- <leader>dc 运行到光标处
-- <leader>dl 运行上一次调试
-- <leader>do 打开 REPL

local bind = require("keymap.bind")
local map_cr = bind.map_cr -- 创建带 <CR> 的命令映射
local map_cu = bind.map_cu -- 创建带 <C-u> 和 <CR> 的命令映射
local map_cmd = bind.map_cmd -- 创建命令映射
local map_callback = bind.map_callback -- 创建回调函数映射
require("keymap.helpers")

local plug_map = {
    -- 插件: vim-fugitive
    ["n|gps"] = map_cr("G push"):with_noremap():with_silent():with_desc("git: 推送代码到远程仓库"), -- 推送代码到远程仓库
    ["n|gpl"] = map_cr("G pull"):with_noremap():with_silent():with_desc("git: 从远程仓库拉取代码"), -- 从远程仓库拉取代码
    ["n|<leader>gG"] = map_cu("Git"):with_noremap():with_silent():with_desc("git: 打开 git-fugitive"), -- 打开 git-fugitive

    -- 插件: nvim-tree
    ["n|<C-n>"] = map_cr("NvimTreeToggle"):with_noremap():with_silent():with_desc("文件树: 切换"), -- 切换文件树
    ["n|<leader>nf"] = map_cr("NvimTreeFindFile"):with_noremap():with_silent():with_desc("文件树: 定位文件"), -- 定位文件
    ["n|<leader>nr"] = map_cr("NvimTreeRefresh"):with_noremap():with_silent():with_desc("文件树: 刷新"), -- 刷新文件树
    
    


    -- 插件: sniprun
    ["v|<leader>r"] = map_cr("SnipRun"):with_noremap():with_silent():with_desc("工具: 运行代码（选中范围）"), -- 运行代码（选中范围）
    ["n|<leader>r"] = map_cu([[%SnipRun]]):with_noremap():with_silent():with_desc("工具: 运行代码（文件范围）"), -- 运行代码（文件范围）

    -- 插件: toggleterm
    ["t|<Esc><Esc>"] = map_cmd([[<C-\><C-n>]]):with_noremap():with_silent(), -- 终端模式切换到普通模式
    ["n|<C-\\>"] = map_cr("ToggleTerm direction=horizontal")
        :with_noremap()
        :with_silent()
        :with_desc("终端: 切换水平终端"), -- 切换水平终端
    ["i|<C-\\>"] = map_cmd("<Esc><Cmd>ToggleTerm direction=horizontal<CR>")
        :with_noremap()
        :with_silent()
        :with_desc("终端: 切换水平终端"), -- 切换水平终端
    ["t|<C-\\>"] = map_cmd("<Cmd>ToggleTerm<CR>"):with_noremap():with_silent():with_desc("终端: 切换水平终端"), -- 切换水平终端
    ["n|<A-\\>"] = map_cr("ToggleTerm direction=vertical")
        :with_noremap()
        :with_silent()
        :with_desc("终端: 切换垂直终端"), -- 切换垂直终端
    ["i|<A-\\>"] = map_cmd("<Esc><Cmd>ToggleTerm direction=vertical<CR>")
        :with_noremap()
        :with_silent()
        :with_desc("终端: 切换垂直终端"), -- 切换垂直终端
    ["t|<A-\\>"] = map_cmd("<Cmd>ToggleTerm<CR>"):with_noremap():with_silent():with_desc("终端: 切换垂直终端"), -- 切换垂直终端
    ["n|<F5>"] = map_cr("ToggleTerm direction=vertical")
        :with_noremap()
        :with_silent()
        :with_desc("终端: 切换垂直终端"), -- 切换垂直终端
    ["i|<F5>"] = map_cmd("<Esc><Cmd>ToggleTerm direction=vertical<CR>")
        :with_noremap()
        :with_silent()
        :with_desc("终端: 切换垂直终端"), -- 切换垂直终端
    ["t|<F5>"] = map_cmd("<Cmd>ToggleTerm<CR>"):with_noremap():with_silent():with_desc("终端: 切换垂直终端"), -- 切换垂直终端
    ["n|<A-d>"] = map_cr("ToggleTerm direction=float"):with_noremap():with_silent():with_desc("终端: 切换浮动终端"), -- 切换浮动终端
    ["i|<A-d>"] = map_cmd("<Esc><Cmd>ToggleTerm direction=float<CR>")
        :with_noremap()
        :with_silent()
        :with_desc("终端: 切换浮动终端"), -- 切换浮动终端
    ["t|<A-d>"] = map_cmd("<Cmd>ToggleTerm<CR>"):with_noremap():with_silent():with_desc("终端: 切换浮动终端"), -- 切换浮动终端
    ["n|<leader>gg"] = map_callback(function()
            _toggle_lazygit()
        end)
        :with_noremap()
        :with_silent()
        :with_desc("git: 切换 lazygit"), -- 切换 lazygit

    -- 插件: trouble
    ["n|gt"] = map_cr("Trouble diagnostics toggle"):with_noremap():with_silent():with_desc("lsp: 切换诊断列表"), -- 切换诊断列表
    ["n|<leader>lw"] = map_cr("Trouble diagnostics toggle")
        :with_noremap()
        :with_silent()
        :with_desc("lsp: 显示工作区诊断"), -- 显示工作区诊断
    ["n|<leader>lp"] = map_cr("Trouble project_diagnostics toggle")
        :with_noremap()
        :with_silent()
        :with_desc("lsp: 显示项目诊断"), -- 显示项目诊断
    ["n|<leader>ld"] = map_cr("Trouble diagnostics toggle filter.buf=0")
        :with_noremap()
        :with_silent()
        :with_desc("lsp: 显示文档诊断"), -- 显示文档诊断

    -- 插件: telescope
    ["n|<C-p>"] = map_callback(function()
            _command_panel()
        end)
        :with_noremap()
        :with_silent()
        :with_desc("工具: 打开命令面板"), -- 打开命令面板
    ["n|<leader>fc"] = map_callback(function()
            _telescope_collections(require("telescope.themes").get_dropdown())
        end)
        :with_noremap()
        :with_silent()
        :with_desc("工具: 打开 Telescope 集合"), -- 打开 Telescope 集合
    ["n|<leader>ff"] = map_callback(function()
            require("search").open({ collection = "file" })
        end)
        :with_noremap()
        :with_silent()
        :with_desc("工具: 查找文件"), -- 查找文件
    ["n|<leader>fp"] = map_callback(function()
            require("search").open({ collection = "pattern" })
        end)
        :with_noremap()
        :with_silent()
        :with_desc("工具: 查找模式"), -- 查找模式
    ["v|<leader>fs"] = map_cu("Telescope grep_string")
        :with_noremap()
        :with_silent()
        :with_desc("工具: 查找光标下的单词"), -- 查找光标下的单词
    ["n|<leader>fg"] = map_callback(function()
            require("search").open({ collection = "git" })
        end)
        :with_noremap()
        :with_silent()
        :with_desc("工具: 定位 Git 对象"), -- 定位 Git 对象
    ["n|<leader>fd"] = map_callback(function()
            require("search").open({ collection = "dossier" })
        end)
        :with_noremap()
        :with_silent()
        :with_desc("工具: 检索档案"), -- 检索档案
    ["n|<leader>fm"] = map_callback(function()
            require("search").open({ collection = "misc" })
        end)
        :with_noremap()
        :with_silent()
        :with_desc("工具: 杂项"), -- 杂项

    -- 插件: dap
    ["n|<F6>"] = map_callback(function()
            _async_compile_and_debug()
        end)
        :with_noremap()
        :with_silent()
        :with_desc("调试: 运行/继续"), -- 运行/继续调试
    ["n|<F7>"] = map_callback(function()
            require("dap").terminate()
        end)
        :with_noremap()
        :with_silent()
        :with_desc("调试: 停止"), -- 停止调试
    ["n|<F8>"] = map_callback(function()
            require("dap").toggle_breakpoint()
        end)
        :with_noremap()
        :with_silent()
        :with_desc("调试: 切换断点"), -- 切换断点
    ["n|<F9>"] = map_callback(function()
            require("dap").step_into()
        end)
        :with_noremap()
        :with_silent()
        :with_desc("调试: 进入下一步"), -- 进入下一步
    ["n|<F10>"] = map_callback(function()
            require("dap").step_out()
        end)
        :with_noremap()
        :with_silent()
        :with_desc("调试: 跳出"), -- 跳出
    ["n|<F11>"] = map_callback(function()
            require("dap").step_over()
        end)
        :with_noremap()
        :with_silent()
        :with_desc("调试: 跳过"), -- 跳过
    ["n|<leader>db"] = map_callback(function()
            require("dap").set_breakpoint(vim.fn.input("断点条件: "))
        end)
        :with_noremap()
        :with_silent()
        :with_desc("调试: 设置条件断点"), -- 设置条件断点
    ["n|<leader>dc"] = map_callback(function()
            require("dap").run_to_cursor()
        end)
        :with_noremap()
        :with_silent()
        :with_desc("调试: 运行到光标处"), -- 运行到光标处
    ["n|<leader>dl"] = map_callback(function()
            require("dap").run_last()
        end)
        :with_noremap()
        :with_silent()
        :with_desc("调试: 运行上一次调试"), -- 运行上一次调试
    ["n|<leader>do"] = map_callback(function()
            require("dap").repl.open()
        end)
        :with_noremap()
        :with_silent()
        :with_desc("调试: 打开 REPL"), -- 打开 REPL
}

bind.nvim_load_mapping(plug_map) -- 加载插件相关的快捷键映射