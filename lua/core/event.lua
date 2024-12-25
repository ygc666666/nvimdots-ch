-- 定义一个自动命令模块
local autocmd = {}

-- 创建自动命令组的函数
function autocmd.nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        -- 为避免名称冲突，在组名前加下划线
        vim.api.nvim_command("augroup _" .. group_name)
        vim.api.nvim_command("autocmd!")
        for _, def in ipairs(definition) do
            -- 将定义的自动命令拼接成字符串
            local command = table.concat(vim.iter({ "autocmd", def }):flatten(math.huge):totable(), " ")
            vim.api.nvim_command(command)
        end
        vim.api.nvim_command("augroup END")
    end
end

-- 在 LSP 附加时配置相关内容
local mapping = require("keymap.completion")
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspKeymapLoader", { clear = true }),
    callback = function(event)
        if not _G._debugging then
            -- 设置 LSP 键映射
            mapping.lsp(event.buf)

            -- 设置 LSP 内联提示
            local inlayhints_enabled = require("core.settings").lsp_inlayhints
            local client = vim.lsp.get_client_by_id(event.data.client_id)
            if client and client.server_capabilities.inlayHintProvider ~= nil then
                vim.lsp.inlay_hint.enable(inlayhints_enabled == true, { bufnr = event.buf })
            end
        end
    end,
})

-- 自动关闭 NvimTree
vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
    pattern = "NvimTree_*",
    callback = function()
        local layout = vim.api.nvim_call_function("winlayout", {})
        if
            layout[1] == "leaf"
            and vim.bo[vim.api.nvim_win_get_buf(layout[2])].filetype == "NvimTree"
            and layout[3] == nil
        then
            vim.api.nvim_command([[confirm quit]])
        end
    end,
})

-- 为某些文件类型设置 <q> 键关闭窗口
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "qf",
        "help",
        "man",
        "notify",
        "nofile",
        "lspinfo",
        "terminal",
        "prompt",
        "toggleterm",
        "copilot",
        "startuptime",
        "tsplayground",
        "PlenaryTestPopup",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.api.nvim_buf_set_keymap(event.buf, "n", "q", "<Cmd>close<CR>", { silent = true })
    end,
})

-- 加载自动命令的函数
function autocmd.load_autocmds()
    local definitions = {
        lazy = {}, -- 懒加载的自动命令
        bufs = {
            -- 自动重新加载 vim 配置
            {
                "BufWritePost",
                [[$VIM_PATH/{*.vim,*.yaml,vimrc} nested source $MYVIMRC | redraw]],
            },
            -- 如果设置了本地 autoread，则自动重新加载 Vim 脚本
            {
                "BufWritePost,FileWritePost",
                "*.vim",
                [[nested if &l:autoread > 0 | source <afile> | echo 'source ' . bufname('%') | endif]],
            },
            { "BufWritePre", "/tmp/*", "setlocal noundofile" }, -- 禁用临时文件的撤销文件
            { "BufWritePre", "COMMIT_EDITMSG", "setlocal noundofile" }, -- 禁用提交消息的撤销文件
            { "BufWritePre", "MERGE_MSG", "setlocal noundofile" }, -- 禁用合并消息的撤销文件
            { "BufWritePre", "*.tmp", "setlocal noundofile" }, -- 禁用临时文件的撤销文件
            { "BufWritePre", "*.bak", "setlocal noundofile" }, -- 禁用备份文件的撤销文件
            -- 自动跳转到上次编辑的位置
            {
                "BufReadPost",
                "*",
                [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif]],
            },
            -- 自动切换 fcitx5 输入法
            -- {"InsertLeave", "* :silent", "!fcitx5-remote -c"},
            -- {"BufCreate", "*", ":silent !fcitx5-remote -c"},
            -- {"BufEnter", "*", ":silent !fcitx5-remote -c "},
            -- {"BufLeave", "*", ":silent !fcitx5-remote -c "}
        },
        wins = {
            -- 仅在当前窗口高亮当前行
            {
                "WinEnter,BufEnter,InsertLeave",
                "*",
                [[if ! &cursorline && &filetype !~# '^\(dashboard\|clap_\)' && ! &pvw | setlocal cursorline | endif]],
            },
            {
                "WinLeave,BufLeave,InsertEnter",
                "*",
                [[if &cursorline && &filetype !~# '^\(dashboard\|clap_\)' && ! &pvw | setlocal nocursorline | endif]],
            },
            -- 离开 nvim 时尝试写入 shada 文件
            {
                "VimLeave",
                "*",
                [[if has('nvim') | wshada | else | wviminfo! | endif]],
            },
            -- 当窗口获得焦点时检查文件是否更改，比 'autoread' 更积极
            { "FocusGained", "* checktime" },
            -- 调整 vim 窗口大小时均分窗口尺寸
            { "VimResized", "*", [[tabdo wincmd =]] },
        },
        ft = {
            { "FileType", "*", "setlocal formatoptions-=cro" }, -- 禁用自动注释
            { "FileType", "alpha", "setlocal showtabline=0" }, -- 在 alpha 文件类型中隐藏标签栏
            { "FileType", "markdown", "setlocal wrap" }, -- 在 markdown 文件类型中启用自动换行
            { "FileType", "dap-repl", "lua require('dap.ext.autocompl').attach()" }, -- 在 dap-repl 文件类型中启用自动补全
            {
                "FileType",
                "c,cpp",
                "nnoremap <leader>h :ClangdSwitchSourceHeaderVSplit<CR>", -- 为 C/C++ 文件类型设置快捷键
            },
        },
        yank = {
            {
                "TextYankPost",
                "*",
                [[silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=300})]], -- 在文本复制后高亮显示
            },
        },
    }
    -- 创建自动命令组
    autocmd.nvim_create_augroups(require("modules.utils").extend_config(definitions, "user.event"))
end

-- 加载自动命令
autocmd.load_autocmds()