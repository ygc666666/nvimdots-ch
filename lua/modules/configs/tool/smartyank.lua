return function()
    require("modules.utils").load_plugin("smartyank", {
        highlight = {
            enabled = true, -- 禁用高亮复制的文本，是否启用高亮功能
            higroup = "IncSearch", -- 高亮组
            timeout = 2000, -- 高亮显示的持续时间
        },
        clipboard = {
            enabled = true, -- 启用系统剪贴板集成
        },
        tmux = {
            enabled = true, -- 启用 Tmux 集成
            cmd = { "tmux", "set-buffer", "-w" }, -- Tmux 命令
        },
        osc52 = {
            enabled = true, -- 启用 OSC52 支持
            escseq = "tmux", -- 使用的转义序列
            ssh_only = true, -- 仅在 SSH 会话中启用
            silent = false, -- 显示复制后字符数的提示
            echo_hl = "Directory", -- 提示消息的高亮组
        },
    })
end