return function()
	require("modules.utils").load_plugin("git-conflict", {
		default_mappings = true, -- 使用默认的键映射
		disable_diagnostics = false, -- 禁用冲突文件的诊断
		highlights = { -- 高亮配置
			incoming = "DiffAdd", -- 传入更改的高亮组
			current = "DiffText", -- 当前更改的高亮组
		},
	})
end
