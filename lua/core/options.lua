-- 引入全局配置模块
local global = require("core.global")

-- 定义加载选项的函数
local function load_options()
    -- 定义全局和本地的配置选项
    local global_local = {
        -- 备份目录
        -- backupdir = global.cache_dir .. "/backup/",
        -- 交换文件目录
        -- directory = global.cache_dir .. "/swap/",
        -- 拼写文件
        -- spellfile = global.cache_dir .. "/spell/en.uft-8.add",
        -- 视图目录
        -- viewdir = global.cache_dir .. "/view/",
        autoindent = true, -- 自动缩进
        autoread = true, -- 文件在外部修改后自动读取
        autowrite = true, -- 在切换缓冲区或退出时自动保存
        backspace = "indent,eol,start", -- 允许在缩进、行尾和行首使用退格键
        backup = false, -- 禁用备份文件
        backupskip = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim", -- 不创建备份文件的路径
        breakat = [[\ \	;:,!?]], -- 断行符号
        breakindentopt = "shift:2,min:20", -- 断行缩进选项
        clipboard = "unnamedplus", -- 使用系统剪贴板
        cmdheight = 1, -- 命令行高度
        cmdwinheight = 5, -- 命令窗口高度
        complete = ".,w,b,k,kspell", -- 自动补全选项
        completeopt = "menuone,noselect,popup", -- 自动补全菜单选项
        concealcursor = "niv", -- 隐藏光标
        conceallevel = 0, -- 隐藏级别
        cursorcolumn = true, -- 高亮当前列
        cursorline = true, -- 高亮当前行
        diffopt = "filler,iwhite,internal,linematch:60,algorithm:patience", -- 差异选项
        display = "lastline", -- 显示最后一行
        encoding = "utf-8", -- 文件编码
        equalalways = false, -- 禁用窗口自动均分
        errorbells = true, -- 启用错误铃声
        fileformats = "unix,mac,dos", -- 文件格式
        foldenable = true, -- 启用代码折叠
        foldlevelstart = 99, -- 初始折叠级别
        formatoptions = "1jcroql", -- 格式化选项
        grepformat = "%f:%l:%c:%m", -- grep 格式
        grepprg = "rg --hidden --vimgrep --smart-case --", -- grep 程序
        helpheight = 12, -- 帮助窗口高度
        hidden = true, -- 允许隐藏未保存的缓冲区
        history = 2000, -- 命令历史记录数
        ignorecase = true, -- 忽略大小写
        inccommand = "nosplit", -- 实时显示命令效果
        incsearch = true, -- 增量搜索
        infercase = true, -- 智能大小写
        jumpoptions = "stack", -- 跳转选项
        laststatus = 3, -- 显示最后一个状态栏
        linebreak = true, -- 自动换行
        list = true, -- 显示不可见字符
		listchars = "space: ,tab:»·,nbsp:+,trail:·,extends:→,precedes:←", -- 不可见字符显示方式，空格用点表示，制表符用箭头表示，不间断空格用加号表示，行尾空格用点表示，行尾空格用点表示，行尾空格用点表示
        magic = true, -- 启用魔法字符
        mousescroll = "ver:3,hor:6", -- 鼠标滚动选项
        number = true, -- 显示行号
        previewheight = 12, -- 预览窗口高度
        pumblend = 0, -- 弹出菜单透明度
        pumheight = 15, -- 弹出菜单高度
        redrawtime = 1500, -- 重绘时间
        relativenumber = true, -- 显示相对行号
        ruler = true, -- 显示标尺
        scrolloff = 2, -- 滚动偏移
        sessionoptions = "buffers,curdir,folds,help,tabpages,winpos,winsize", -- 会话选项
        shada = "!,'500,<50,@100,s10,h", -- shada 选项
        shiftround = true, -- 缩进对齐
        shiftwidth = 4, -- 缩进宽度
        shortmess = "aoOTIcF", -- 短消息选项
        showbreak = "↳  ", -- 换行符号
        showcmd = false, -- 不显示命令
        showmode = false, -- 不显示模式
        showtabline = 2, -- 显示标签栏
        sidescrolloff = 5, -- 侧滚偏移
        signcolumn = "yes", -- 显示标记列
        smartcase = true, -- 智能大小写
        smarttab = true, -- 智能缩进
        smoothscroll = true, -- 平滑滚动
        splitbelow = true, -- 新窗口在下方
        splitkeep = "screen", -- 保持屏幕位置
        splitright = true, -- 新窗口在右侧
        startofline = false, -- 不移动到行首
        swapfile = false, -- 禁用交换文件
        switchbuf = "usetab,uselast", -- 切换缓冲区选项
        synmaxcol = 2500, -- 语法高亮最大列数
        tabstop = 4, -- 制表符宽度
        termguicolors = true, -- 启用终端真彩色
        timeout = true, -- 启用超时
        timeoutlen = 300, -- 超时时间
        ttimeout = true, -- 启用终端超时
        ttimeoutlen = 0, -- 终端超时时间
        undodir = global.cache_dir .. "/undo/", -- 撤销目录
        undofile = true, -- 启用撤销文件
        updatetime = 200, -- 更新时间
        viewoptions = "folds,cursor,curdir,slash,unix", -- 视图选项
        virtualedit = "block", -- 虚拟编辑
        visualbell = true, -- 启用视觉铃声
        whichwrap = "h,l,<,>,[,],~", -- 包裹光标移动
        wildignore = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**", -- 忽略文件
        wildignorecase = true, -- 忽略大小写
        winblend = 0, -- 窗口透明度
        winminwidth = 10, -- 窗口最小宽度
        winwidth = 30, -- 窗口宽度
        wrap = false, -- 禁用自动换行
        wrapscan = true, -- 启用搜索换行
        writebackup = false, -- 禁用写入备份
    }

    -- 定义一个检查字符串是否为空的函数
    local function isempty(s)
        return s == nil or s == ""
    end

    -- 定义一个使用已定义值或回退值的函数
    local function use_if_defined(val, fallback)
        return val ~= nil and val or fallback
    end

    -- 自定义 Python 提供程序
    local conda_prefix = os.getenv("CONDA_PREFIX")
    if not isempty(conda_prefix) then
        vim.g.python_host_prog = use_if_defined(vim.g.python_host_prog, conda_prefix .. "/bin/python")
        vim.g.python3_host_prog = use_if_defined(vim.g.python3_host_prog, conda_prefix .. "/bin/python")
    else
        vim.g.python_host_prog = use_if_defined(vim.g.python_host_prog, "python")
        vim.g.python3_host_prog = use_if_defined(vim.g.python3_host_prog, "python3")
    end

    -- 加载并设置配置选项
    for name, value in pairs(require("modules.utils").extend_config(global_local, "user.options")) do
        vim.api.nvim_set_option_value(name, value, {})
    end
end

-- 设置 netrw 的列表样式
vim.g.netrw_liststyle = 3

-- 加载选项
load_options()