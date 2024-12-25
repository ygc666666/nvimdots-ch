-- 快捷键说明：
-- <leader>cp 打开命令面板
-- <leader>tc 打开 Telescope 集合
-- <leader>le 切换闪烁 ESC 或清除高亮
-- <leader>lg 切换 lazygit
-- <leader>ih 切换内联提示
-- <leader>td 切换诊断信息
-- <leader>cd 编译并调试

-- 打开命令面板
_G._command_panel = function()
    require("telescope.builtin").keymaps({
        lhs_filter = function(lhs)
            return not string.find(lhs, "Þ")
        end,
        layout_config = {
            width = 0.6,
            height = 0.6,
            prompt_position = "top",
        },
    })
end

-- 打开 Telescope 集合
_G._telescope_collections = function(picker_type)
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    local conf = require("telescope.config").values
    local finder = require("telescope.finders")
    local pickers = require("telescope.pickers")
    picker_type = picker_type or {}

    local collections = vim.tbl_keys(require("search.tabs").collections)
    pickers
        .new(picker_type, {
            prompt_title = "Telescope 集合",
            finder = finder.new_table({ results = collections }),
            sorter = conf.generic_sorter(picker_type),
            attach_mappings = function(bufnr)
                actions.select_default:replace(function()
                    actions.close(bufnr)
                    local selection = action_state.get_selected_entry()
                    require("search").open({ collection = selection[1] })
                end)

                return true
            end,
        })
        :find()
end

-- 切换闪烁 ESC 或清除高亮
_G._flash_esc_or_noh = function()
    local flash_active, state = pcall(function()
        return require("flash.plugins.char").state
    end)
    if flash_active and state then
        state:hide()
    else
        pcall(vim.cmd.noh)
    end
end

-- 切换 lazygit
local _lazygit = nil
_G._toggle_lazygit = function()
    if vim.fn.executable("lazygit") == 1 then
        if not _lazygit then
            _lazygit = require("toggleterm.terminal").Terminal:new({
                cmd = "lazygit",
                direction = "float",
                close_on_exit = true,
                hidden = true,
            })
        end
        _lazygit:toggle()
    else
        vim.notify("未找到命令 [lazygit]!", vim.log.levels.ERROR, { title = "toggleterm.nvim" })
    end
end

-- 切换内联提示
_G._toggle_inlayhint = function()
    if vim.lsp.inlay_hint.is_enabled() then
        vim.lsp.inlay_hint.enable(false)
        vim.notify("成功禁用内联提示!", vim.log.levels.INFO, { title = "LSP 内联提示" })
    else
        vim.lsp.inlay_hint.enable(true)
        vim.notify("成功启用内联提示!", vim.log.levels.INFO, { title = "LSP 内联提示" })
    end
end

-- 切换诊断信息
local _diagnostic = 1
_G._toggle_diagnostic = function()
    if vim.diagnostic.is_enabled() then
        if _diagnostic == 1 then
            _diagnostic = 0
            vim.diagnostic.hide()
            vim.notify("成功隐藏虚拟文本!", vim.log.levels.INFO, { title = "LSP 诊断" })
        else
            _diagnostic = 1
            vim.diagnostic.show()
            vim.notify("成功显示虚拟文本!", vim.log.levels.INFO, { title = "LSP 诊断" })
        end
    end
end

-- 编译并调试
_G._async_compile_and_debug = function()
    local file_ext = vim.fn.expand("%:e")
    local file_path = vim.fn.expand("%:p")
    local out_name = vim.fn.expand("%:p:h") .. "/" .. vim.fn.expand("%:t:r") .. ".out"
    local compile_cmd
    if file_ext == "cpp" or file_ext == "cc" then
        compile_cmd = string.format("g++ -g %s -o %s", file_path, out_name)
    elseif file_ext == "c" then
        compile_cmd = string.format("gcc -g %s -o %s", file_path, out_name)
    elseif file_ext == "go" then
        compile_cmd = string.format("go build -o %s %s", out_name, file_path)
    else
        require("dap").continue()
        return
    end
    local notify_title = "调试预编译"
    vim.fn.jobstart(compile_cmd, {
        on_exit = function(_, exit_code, _)
            if exit_code == 0 then
                vim.notify(
                    "编译成功! 可执行文件: " .. out_name,
                    vim.log.levels.INFO,
                    { title = notify_title }
                )
                require("dap").continue()
                return
            else
                vim.notify(
                    "编译失败，退出代码: " .. exit_code,
                    vim.log.levels.ERROR,
                    { title = notify_title }
                )
            end
        end,
    })
end