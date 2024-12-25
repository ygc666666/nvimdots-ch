---@class map_rhs
---@field cmd string -- 保存命令字符串
---@field options table -- 保存选项的表
---@field options.noremap boolean -- 是否不重新映射
---@field options.silent boolean -- 是否静默执行
---@field options.expr boolean -- 是否是表达式
---@field options.nowait boolean -- 是否不等待
---@field options.callback function -- 回调函数
---@field options.desc string -- 描述
---@field buffer boolean|number -- 是否是缓冲区映射或缓冲区编号
local rhs_options = {}

-- 创建一个新的 rhs_options 实例
function rhs_options:new()
    local instance = {
        cmd = "", -- 初始化命令为空字符串
        options = {
            noremap = false, -- 默认不重新映射
            silent = false, -- 默认不静默执行
            expr = false, -- 默认不是表达式
            nowait = false, -- 默认等待
            callback = nil, -- 默认没有回调函数
            desc = "", -- 默认没有描述
        },
        buffer = false, -- 默认不是缓冲区映射
    }
    setmetatable(instance, self)
    self.__index = self
    return instance
end

-- 设置命令字符串
---@param cmd_string string
---@return map_rhs
function rhs_options:map_cmd(cmd_string)
    self.cmd = cmd_string
    return self
end

-- 设置命令字符串并添加 <CR>（回车）
---@param cmd_string string
---@return map_rhs
function rhs_options:map_cr(cmd_string)
    self.cmd = (":%s<CR>"):format(cmd_string)
    return self
end

-- 设置命令字符串并添加 <Space>（空格）
---@param cmd_string string
---@return map_rhs
function rhs_options:map_args(cmd_string)
    self.cmd = (":%s<Space>"):format(cmd_string)
    return self
end

-- 设置命令字符串并添加 <C-u> 和 <CR>
---@param cmd_string string
---@return map_rhs
function rhs_options:map_cu(cmd_string)
    -- <C-u> 用于在可视模式下消除自动插入的范围
    self.cmd = (":<C-u>%s<CR>"):format(cmd_string)
    return self
end

-- 设置回调函数，当按下键时调用
---@param callback fun():nil
---@return map_rhs
function rhs_options:map_callback(callback)
    self.cmd = "" -- 清空命令字符串
    self.options.callback = callback -- 设置回调函数
    return self
end

-- 设置静默选项
---@return map_rhs
function rhs_options:with_silent()
    self.options.silent = true
    return self
end

-- 设置描述字符串
---@param description_string string
---@return map_rhs
function rhs_options:with_desc(description_string)
    self.options.desc = description_string
    return self
end

-- 设置不重新映射选项
---@return map_rhs
function rhs_options:with_noremap()
    self.options.noremap = true
    return self
end

-- 设置表达式选项
---@return map_rhs
function rhs_options:with_expr()
    self.options.expr = true
    return self
end

-- 设置不等待选项
---@return map_rhs
function rhs_options:with_nowait()
    self.options.nowait = true
    return self
end

-- 设置缓冲区编号
---@param num number
---@return map_rhs
function rhs_options:with_buffer(num)
    self.buffer = num
    return self
end

local bind = {}

-- 创建一个新的 rhs_options 实例并设置命令字符串（带 <CR>）
---@param cmd_string string
---@return map_rhs
function bind.map_cr(cmd_string)
    local ro = rhs_options:new()
    return ro:map_cr(cmd_string)
end

-- 创建一个新的 rhs_options 实例并设置命令字符串
---@param cmd_string string
---@return map_rhs
function bind.map_cmd(cmd_string)
    local ro = rhs_options:new()
    return ro:map_cmd(cmd_string)
end

-- 创建一个新的 rhs_options 实例并设置命令字符串（带 <C-u> 和 <CR>）
---@param cmd_string string
---@return map_rhs
function bind.map_cu(cmd_string)
    local ro = rhs_options:new()
    return ro:map_cu(cmd_string)
end

-- 创建一个新的 rhs_options 实例并设置命令字符串（带 <Space>）
---@param cmd_string string
---@return map_rhs
function bind.map_args(cmd_string)
    local ro = rhs_options:new()
    return ro:map_args(cmd_string)
end

-- 创建一个新的 rhs_options 实例并设置回调函数
---@param callback fun():nil
---@return map_rhs
function bind.map_callback(callback)
    local ro = rhs_options:new()
    return ro:map_callback(callback)
end

-- 转义终端代码
---@param cmd_string string
---@return string escaped_string
function bind.escape_termcode(cmd_string)
    return vim.api.nvim_replace_termcodes(cmd_string, true, true, true)
end

-- 加载键映射
---@param mapping table<string, map_rhs>
function bind.nvim_load_mapping(mapping)
    for key, value in pairs(mapping) do
        local modes, keymap = key:match("([^|]*)|?(.*)")
        if type(value) == "table" then
            for _, mode in ipairs(vim.split(modes, "")) do
                local rhs = value.cmd
                local options = value.options
                local buf = value.buffer
                if buf and type(buf) == "number" then
                    vim.api.nvim_buf_set_keymap(buf, mode, keymap, rhs, options)
                else
                    vim.api.nvim_set_keymap(mode, keymap, rhs, options)
                end
            end
        end
    end
end

return bind