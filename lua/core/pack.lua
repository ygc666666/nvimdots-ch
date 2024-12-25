-- 获取 Vim 的函数和 API
local fn, api = vim.fn, vim.api

-- 引入全局配置模块
local global = require("core.global")
local is_mac = global.is_mac -- 判断是否为 Mac 系统
local vim_path = global.vim_path -- 获取 Vim 的路径
local data_dir = global.data_dir -- 获取数据目录
local lazy_path = data_dir .. "lazy/lazy.nvim" -- lazy.nvim 插件的路径
local modules_dir = vim_path .. "/lua/modules" -- 模块目录
local user_config_dir = vim_path .. "/lua/user" -- 用户配置目录

-- 引入设置模块
local settings = require("core.settings")
local use_ssh = settings.use_ssh -- 是否使用 SSH 来克隆插件

-- 图标配置
local icons = {
    kind = require("modules.utils.icons").get("kind"),
    documents = require("modules.utils.icons").get("documents"),
    ui = require("modules.utils.icons").get("ui"),
    ui_sep = require("modules.utils.icons").get("ui", true),
    misc = require("modules.utils.icons").get("misc"),
}

-- 定义 Lazy 表
local Lazy = {}

-- 加载插件的函数
function Lazy:load_plugins()
    self.modules = {}

    -- 添加本地运行时路径
    local append_nativertp = function()
        package.path = package.path
            .. string.format(
                ";%s;%s;%s",
                modules_dir .. "/configs/?.lua",
                modules_dir .. "/configs/?/init.lua",
                user_config_dir .. "/?.lua"
            )
    end

    -- 获取插件列表的函数
    local get_plugins_list = function()
        local list = {}
        -- 获取模块目录和用户配置目录下的插件列表
        local plugins_list = vim.split(fn.glob(modules_dir .. "/plugins/*.lua"), "\n")
        local user_plugins_list = vim.split(fn.glob(user_config_dir .. "/plugins/*.lua"), "\n", { trimempty = true })
        vim.list_extend(plugins_list, user_plugins_list)
        for _, f in ipairs(plugins_list) do
            -- 将 `/plugins/*.lua` 和 `/user/plugins/*.lua` 中的插件聚合到一个插件列表中，以便后续 `require` 操作。
            -- 当前字段包含：completion, editor, lang, tool, ui
            list[#list + 1] = f:find(modules_dir) and f:sub(#modules_dir - 6, -1) or f:sub(#user_config_dir - 3, -1)
        end
        return list
    end

    append_nativertp()

    for _, m in ipairs(get_plugins_list()) do
        -- 引入 `get_plugins_list()` 函数返回的模块
        local modules = require(m:sub(0, #m - 4))
        if type(modules) == "table" then
            for name, conf in pairs(modules) do
                self.modules[#self.modules + 1] = vim.tbl_extend("force", { name }, conf)
            end
        end
    end
    for _, name in ipairs(settings.disabled_plugins) do
        self.modules[#self.modules + 1] = { name, enabled = false }
    end
end

-- 加载 lazy.nvim 的函数
function Lazy:load_lazy()
    if not vim.uv.fs_stat(lazy_path) then
        -- 如果 lazy.nvim 插件不存在，则克隆它
        local lazy_repo = use_ssh and "git@github.com:folke/lazy.nvim.git " or "https://github.com/folke/lazy.nvim.git "
        api.nvim_command("!git clone --filter=blob:none --branch=stable " .. lazy_repo .. lazy_path)
    end
    self:load_plugins()

    -- 配置 lazy.nvim 的设置
    local clone_prefix = use_ssh and "git@github.com:%s.git" or "https://github.com/%s.git"
    local lazy_settings = {
        root = data_dir .. "lazy", -- 插件安装的目录
        git = {
            timeout = 300, -- Git 操作的超时时间
            url_format = clone_prefix, -- 克隆插件的 URL 格式
        },
        install = {
            missing = true, -- 启动时安装缺失的插件
            colorscheme = { settings.colorscheme }, -- 配色方案
        },
        ui = {
            size = { width = 0.88, height = 0.8 }, -- UI 窗口的大小
            wrap = true, -- 在 UI 中换行
            border = "rounded", -- UI 窗口的边框样式
            icons = {
                cmd = icons.misc.Code,
                config = icons.ui.Gear,
                event = icons.kind.Event,
                ft = icons.documents.Files,
                init = icons.misc.ManUp,
                import = icons.documents.Import,
                keys = icons.ui.Keyboard,
                loaded = icons.ui.Check,
                not_loaded = icons.misc.Ghost,
                plugin = icons.ui.Package,
                runtime = icons.misc.Vim,
                source = icons.kind.StaticMethod,
                start = icons.ui.Play,
                list = {
                    icons.ui_sep.BigCircle,
                    icons.ui_sep.BigUnfilledCircle,
                    icons.ui_sep.Square,
                    icons.ui_sep.ChevronRight,
                },
            },
        },
        performance = {
            cache = {
                enabled = true, -- 启用缓存
                path = vim.fn.stdpath("cache") .. "/lazy/cache", -- 缓存路径
                disable_events = { "UIEnter", "BufReadPre" }, -- 触发这些事件时禁用缓存
                ttl = 3600 * 24 * 2, -- 缓存的有效期为 2 天
            },
            reset_packpath = true, -- 重置包路径以提高启动时间
            rtp = {
                reset = true, -- 重置运行时路径到 $VIMRUNTIME 和配置目录
                paths = {}, -- 添加自定义路径
                disabled_plugins = {
                    "editorconfig", -- 禁用 editorconfig 插件
                    "spellfile", -- 禁用拼写文件插件
                    "matchit", -- 禁用 matchit 插件
                    "matchparen", -- 禁用 matchparen 插件
                    "tohtml", -- 禁用 tohtml 插件
                    "gzip", -- 禁用 gzip 插件
                    "tarPlugin", -- 禁用 tarPlugin 插件
                    "zipPlugin", -- 禁用 zipPlugin 插件
                },
            },
        },
    }
    if is_mac then
        lazy_settings.concurrency = 20 -- 如果是 Mac 系统，设置并发数为 20
    end

    vim.opt.rtp:prepend(lazy_path) -- 将 lazy.nvim 插件路径添加到运行时路径中
    require("lazy").setup(self.modules, lazy_settings) -- 设置 lazy.nvim
end

Lazy:load_lazy() -- 加载 lazy.nvim