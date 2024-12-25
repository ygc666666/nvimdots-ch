local settings = {}

-- 如果你想使用 https 来更新插件和 treesitter 解析器，请将其设置为 false。
---@type boolean
settings["use_ssh"] = true

-- 如果你不使用 copilot，请将其设置为 false。
---@type boolean
settings["use_copilot"] = true

-- 如果不需要在保存时自动格式化，请将其设置为 false。
---@type boolean
settings["format_on_save"] = true

-- 设置格式化超时时间（以毫秒为单位）。
---@type number
settings["format_timeout"] = 1000

-- 如果格式化后的通知让你感到烦扰，请将其设置为 false。
---@type boolean
settings["format_notify"] = true

-- 如果你更喜欢仅格式化版本控制系统定义的*更改行*，请将其设置为 true。
-- 注意：此选项仅在以下情况下生效：
--  > 要格式化的缓冲区在版本控制（Git 或 Mercurial）下；
--  > 任何附加到该缓冲区的服务器支持 |DocumentRangeFormattingProvider| 服务器功能。
-- 否则，Neovim 将回退到格式化整个缓冲区，并发出警告。
---@type boolean
settings["format_modifications_only"] = false

-- 在此处设置禁用格式化的目录，这些目录下的文件在保存时不会被格式化。
-- 注意：目录可以包含正则表达式（语法：vim）。|regexp|
-- 注意：目录会自动规范化。|vim.fs.normalize()|
---@type string[]
settings["format_disabled_dirs"] = {
    -- 示例
    "~/format_disabled_dir",
}

-- 此列表中的文件类型将跳过 lsp 格式化，如果右侧值为 true。
---@type table<string, boolean>
settings["formatter_block_list"] = {
    lua = false, -- 示例
}

-- 此列表中的服务器将跳过设置格式化功能，如果右侧值为 true。
---@type table<string, boolean>
settings["server_formatting_block_list"] = {
    clangd = true,
    lua_ls = true,
    ts_ls = true,
}

-- 如果你想关闭 LSP 内联提示，请将其设置为 false。
---@type boolean
settings["lsp_inlayhints"] = false

-- 如果诊断虚拟文本让你感到烦扰，请将其设置为 false。
-- 如果禁用，你可以使用 trouble.nvim 浏览 lsp 诊断（按 `gt` 切换）。
---@type boolean
settings["diagnostics_virtual_text"] = true

-- 如果你想更改 lsp 诊断的可见严重级别，请将其设置为以下值之一。
-- 优先级：`Error` > `Warning` > `Information` > `Hint`。
--  > 例如，如果你将此选项设置为 `Warning`，则只会显示 lsp 警告和错误。
-- 注意：此选项仅在 `diagnostics_virtual_text` 为 true 时生效。
---@type "ERROR"|"WARN"|"INFO"|"HINT"
settings["diagnostics_level"] = "HINT"

-- 在此处设置要禁用的插件。
-- 示例："Some-User/A-Repo"
---@type string[]
settings["disabled_plugins"] = {}

-- 如果你不使用 nvim 打开大文件，请将其设置为 false。
---@type boolean
settings["load_big_files_faster"] = true

-- 在此处更改全局调色板的颜色。
-- 设置将在初始化时完成替换。
-- 参数将在你输入时自动完成。
-- 示例：{ sky = "#04A5E5" }
---@type palette[]
settings["palette_overwrite"] = {}

-- 在此处设置要使用的配色方案。
-- 可用值有：`catppuccin`、`catppuccin-latte`、`catppuccin-mocha`、`catppuccin-frappe`、`catppuccin-macchiato`。
---@type string
settings["colorscheme"] = "catppuccino"

-- 如果你的终端有透明背景，请将其设置为 true。
---@type boolean
settings["transparent_background"] = false

-- 在此处设置要使用的背景颜色。
-- 如果你想使用具有浅色和深色变体的配色方案（如 `edge`），此选项很有用。
-- 有效值为：`dark`、`light`。
---@type "dark"|"light"
settings["background"] = "dark"

-- 在此处设置处理外部 URL 的命令。可执行文件必须在你的 $PATH 中可用。
-- 此选项在 Windows 和 macOS 上被忽略，这些系统有内置的默认处理程序。
---@type string
settings["external_browser"] = "chrome-cli open"

-- 在此处设置在引导期间将安装的语言服务器。
-- 查看以下链接以获取所有支持的 LSP：
-- https://github.com/neovim/nvim-lspconfig/tree/master/lua/lspconfig/server_configurations
---@type string[]
settings["lsp_deps"] = {
    "bashls",
    "clangd",
    "html",
    "jsonls",
    "lua_ls",
    "pylsp",
    "gopls",
}

-- 在此处设置在引导期间将安装的通用服务器。
-- 查看以下链接以获取所有支持的源。
-- 在 `code_actions`、`completion`、`diagnostics`、`formatting`、`hover` 文件夹中：
-- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins
---@type string[]
settings["null_ls_deps"] = {
    "clang_format",
    "gofumpt",
    "goimports",
    "prettier",
    "shfmt",
    "stylua",
    "vint",
}

-- 在此处设置在引导期间将安装和配置的调试适配器协议（DAP）客户端。
-- 查看以下链接以获取所有支持的 DAP：
-- https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
---@type string[]
settings["dap_deps"] = {
    "codelldb", -- C 家族
    "delve", -- Go
    "python", -- Python (debugpy)
}

-- 在此处设置在引导期间将安装的 Treesitter 解析器。
-- 查看以下链接以获取所有支持的语言：
-- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
---@type string[]
settings["treesitter_deps"] = {
    "bash",
    "c",
    "cpp",
    "css",
    "go",
    "gomod",
    "html",
    "javascript",
    "json",
    "jsonc",
    "latex",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "python",
    "rust",
    "typescript",
    "vimdoc",
    "vue",
    "yaml",
}

-- 在此处设置 neovim 的 GUI 客户端（如 `neovide` 和 `neovim-qt`）的选项。
-- 注意：目前，仅支持以下与 GUI 相关的选项。其他条目将被忽略。
---@type { font_name: string, font_size: number }
settings["gui_config"] = {
    font_name = "JetBrainsMono Nerd Font",
    font_size = 12,
}

-- 在此处设置特定于 `neovide` 的选项。
-- 注意：你应该删除所有条目中的 `neovide_` 前缀（包括尾随下划线）。
-- 查看以下链接以获取所有支持的条目：
-- https://neovide.dev/configuration.html
---@type table<string, boolean|number|string>
settings["neovide_config"] = {
    no_idle = true,
    refresh_rate = 120,
    cursor_vfx_mode = "railgun",
    cursor_vfx_opacity = 200.0,
    cursor_antialiasing = true,
    cursor_trail_length = 0.05,
    cursor_animation_length = 0.03,
    cursor_vfx_particle_speed = 20.0,
    cursor_vfx_particle_density = 5.0,
    cursor_vfx_particle_lifetime = 1.2,
}

-- 在此处设置启动仪表板的启动图像
-- 你可以使用以下工具生成 ascii 图像：https://github.com/TheZoraiz/ascii-image-converter
-- 更多信息：https://github.com/ayamir/nvimdots/wiki/Issues#change-dashboard-startup-image
---@type string[]
settings["dashboard_image"] = {
    [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
    [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⣠⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
    [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣡⣾⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⣿⣟⠻⣿⣿⣿⣿⣿⣿⣿⣿]],
    [[⣿⣿⣿⣿⣿⣿⣿⣿⡿⢫⣷⣿⣿⣿⣿⣿⣿⣿⣾⣯⣿⡿⢧⡚⢷⣌⣽⣿⣿⣿⣿⣿⣶⡌⣿⣿⣿⣿⣿⣿]],
    [[⣿⣿⣿⣿⣿⣿⣿⣿⠇⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣮⣇⣘⠿⢹⣿⣿⣿⣿⣿⣻⢿⣿⣿⣿⣿⣿]],
    [[⣿⣿⣿⣿⣿⣿⣿⣿⠀⢸⣿⣿⡇⣿⣿⣿⣿⣿⣿⣿⣿⡟⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣻⣿⣿⣿⣿]],
    [[⣿⣿⣿⣿⣿⣿⣿⡇⠀⣬⠏⣿⡇⢻⣿⣿⣿⣿⣿⣿⣿⣷⣼⣿⣿⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⢻⣿⣿⣿⣿]],
    [[⣿⣿⣿⣿⣿⣿⣿⠀⠈⠁⠀⣿⡇⠘⡟⣿⣿⣿⣿⣿⣿⣿⣿⡏⠿⣿⣟⣿⣿⣿⣿⣿⣿⣿⣿⣇⣿⣿⣿⣿]],
    [[⣿⣿⣿⣿⣿⣿⡏⠀⠀⠐⠀⢻⣇⠀⠀⠹⣿⣿⣿⣿⣿⣿⣩⡶⠼⠟⠻⠞⣿⡈⠻⣟⢻⣿⣿⣿⣿⣿⣿⣿]],
    [[⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⢿⠀⡆⠀⠘⢿⢻⡿⣿⣧⣷⢣⣶⡃⢀⣾⡆⡋⣧⠙⢿⣿⣿⣟⣿⣿⣿⣿]],
    [[⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⡥⠂⡐⠀⠁⠑⣾⣿⣿⣾⣿⣿⣿⡿⣷⣷⣿⣧⣾⣿⣿⣿⣿⣿⣿⣿]],
    [[⣿⣿⡿⣿⣍⡴⠆⠀⠀⠀⠀⠀⠀⠀⠀⣼⣄⣀⣷⡄⣙⢿⣿⣿⣿⣿⣯⣶⣿⣿⢟⣾⣿⣿⢡⣿⣿⣿⣿⣿]],
    [[⣿⡏⣾⣿⣿⣿⣷⣦⠀⠀⠀⢀⡀⠀⠀⠠⣭⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⣡⣾⣿⣿⢏⣾⣿⣿⣿⣿⣿⣿]],
    [[⣿⣿⣿⣿⣿⣿⣿⣿⡴⠀⠀⠀⠀⠀⠠⠀⠰⣿⣿⣿⣷⣿⠿⠿⣿⣿⣭⡶⣫⠔⢻⢿⢇⣾⣿⣿⣿⣿⣿⣿]],
    [[⣿⣿⣿⡿⢫⣽⠟⣋⠀⠀⠀⠀⣶⣦⠀⠀⠀⠈⠻⣿⣿⣿⣾⣿⣿⣿⣿⡿⣣⣿⣿⢸⣾⣿⣿⣿⣿⣿⣿⣿]],
    [[⡿⠛⣹⣶⣶⣶⣾⣿⣷⣦⣤⣤⣀⣀⠀⠀⠀⠀⠀⠀⠉⠛⠻⢿⣿⡿⠫⠾⠿⠋⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
    [[⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣀⡆⣠⢀⣴⣏⡀⠀⠀⠀⠉⠀⠀⢀⣠⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
    [[⠿⠛⠛⠛⠛⠛⠛⠻⢿⣿⣿⣿⣿⣯⣟⠷⢷⣿⡿⠋⠀⠀⠀⠀⣵⡀⢠⡿⠋⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⢿⣿⣿⠂⠀⠀⠀⠀⠀⢀⣽⣿⣿⣿⣿⣿⣿⣿⣍⠛⠿⣿⣿⣿⣿⣿⣿]],
}

return require("modules.utils").extend_config(settings, "user.settings")