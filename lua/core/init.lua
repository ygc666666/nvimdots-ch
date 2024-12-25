local settings = require("core.settings") -- 引入核心设置模块
local global = require("core.global") -- 引入全局变量模块

-- 创建缓存目录和数据目录的函数
local createdir = function()
    local data_dirs = {
        global.cache_dir .. "/backup", -- 备份目录
        global.cache_dir .. "/session", -- 会话目录
        global.cache_dir .. "/swap", -- 交换文件目录
        global.cache_dir .. "/tags", -- 标签目录
        global.cache_dir .. "/undo", -- 撤销目录
    }
    -- 仅检查缓存目录是否存在，这就足够了
    if vim.fn.isdirectory(global.cache_dir) == 0 then
        ---@diagnostic disable-next-line: param-type-mismatch
        vim.fn.mkdir(global.cache_dir, "p") -- 创建缓存目录
        for _, dir in pairs(data_dirs) do
            if vim.fn.isdirectory(dir) == 0 then
                vim.fn.mkdir(dir, "p") -- 创建数据目录
            end
        end
    end
end

-- 设置领导键的函数
local leader_map = function()
    vim.g.mapleader = " " -- 设置领导键为空格
    -- 注意:
    --  > 如果你使用的是 <Space> 以外的 <leader>，并且希望在普通/可视模式下按 <Space> 不会前进一个字符，请取消注释以下内容。
    -- vim.api.nvim_set_keymap("n", " ", "", { noremap = true })
    -- vim.api.nvim_set_keymap("x", " ", "", { noremap = true })
end

-- 配置 GUI 的函数
local gui_config = function()
    if next(settings.gui_config) then
        vim.api.nvim_set_option_value(
            "guifont",
            settings.gui_config.font_name .. ":h" .. settings.gui_config.font_size,
            {}
        ) -- 设置 GUI 字体
    end
end

-- 配置 Neovide 的函数
local neovide_config = function()
    for name, config in pairs(settings.neovide_config) do
        vim.g["neovide_" .. name] = config -- 设置 Neovide 配置
    end
end

-- 配置剪贴板的函数
local clipboard_config = function()
    if global.is_mac then
        vim.g.clipboard = {
            name = "macOS-clipboard",
            copy = { ["+"] = "pbcopy", ["*"] = "pbcopy" },
            paste = { ["+"] = "pbpaste", ["*"] = "pbpaste" },
            cache_enabled = 0,
        } -- 配置 macOS 剪贴板
    elseif global.is_wsl then
        vim.g.clipboard = {
            name = "win32yank-wsl",
            copy = {
                ["+"] = "win32yank.exe -i --crlf",
                ["*"] = "win32yank.exe -i --crlf",
            },
            paste = {
                ["+"] = "win32yank.exe -o --lf",
                ["*"] = "win32yank.exe -o --lf",
            },
            cache_enabled = 0,
        } -- 配置 WSL 剪贴板
    else
        vim.g.clipboard = {
            name = "xclip",
            copy = {
                ["+"] = "xclip -selection clipboard",
                ["*"] = "xclip -selection primary",
            },
            paste = {
                ["+"] = "xclip -selection clipboard -o",
                ["*"] = "xclip -selection primary -o",
            },
            cache_enabled = 0,
        }
    end
end

-- 配置 shell 的函数
local shell_config = function()
    if global.is_windows then
        if not (vim.fn.executable("pwsh") == 1 or vim.fn.executable("powershell") == 1) then
            vim.notify(
                [[
Failed to setup terminal config

PowerShell is either not installed, missing from PATH, or not executable;
cmd.exe will be used instead for `:!` (shell bang) and toggleterm.nvim.

You're recommended to install PowerShell for better experience.]],
                vim.log.levels.WARN,
                { title = "[core] Runtime Warning" }
            ) -- 提示 PowerShell 未安装或不可执行，建议安装 PowerShell
            return
        end

        local basecmd = "-NoLogo -MTA -ExecutionPolicy RemoteSigned"
        local ctrlcmd = "-Command [console]::InputEncoding = [console]::OutputEncoding = [System.Text.Encoding]::UTF8"
        local set_opts = vim.api.nvim_set_option_value
        set_opts("shell", vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell", {})
        set_opts("shellcmdflag", string.format("%s %s;", basecmd, ctrlcmd), {})
        set_opts("shellredir", "-RedirectStandardOutput %s -NoNewWindow -Wait", {})
        set_opts("shellpipe", "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode", {})
        set_opts("shellquote", "", {})
        set_opts("shellxquote", "", {})
    end
end

-- 加载核心配置的函数
local load_core = function()
    createdir() -- 创建目录
    leader_map() -- 设置领导键

    gui_config() -- 配置 GUI
    neovide_config() -- 配置 Neovide
    clipboard_config() -- 配置剪贴板
    shell_config() -- 配置 shell

    require("core.options") -- 加载核心选项
    require("core.event") -- 加载核心事件
    require("core.pack") -- 加载核心包管理
    require("keymap") -- 加载键映射

    vim.api.nvim_set_option_value("background", settings.background, {}) -- 设置背景
    vim.cmd.colorscheme(settings.colorscheme) -- 设置配色方案
end

load_core() -- 加载核心配置