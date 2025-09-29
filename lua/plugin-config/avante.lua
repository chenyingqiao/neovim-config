require("avante_lib").load()
require("avante").setup({
	build = vim.fn.has("win32") ~= 0
		and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
		or "make",

	instructions_file = "CLAUDE.md",

	-- 👇 不要包在 opts 里面，直接写
	provider = "moonshot",
	auto_suggestions_provider = "moonshot",
	providers = {
		gemini = {
			endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
			model = "gemini-1.5-flash-latest",
			api_key_name = "GOOGLE_API_KEY", -- 从环境变量读取
			timeout = 30000,
			extra_request_body = {
				temperature = 0.75,
				max_tokens = 20480,
			},
		},
		moonshot = {
			endpoint = "https://api.moonshot.cn/v1",
			model = "kimi-k2-0905-preview",
			api_key_name = "MOONSHOT_API_KEY", -- 从环境变量读取
			timeout = 30000,          -- Timeout in milliseconds
			extra_request_body = {
				temperature = 0.75,
				max_tokens = 32768,
			},
		},
	},
	acp_providers = {
		["gemini-cli"] = {
			command = "gemini",
			args = { "--experimental-acp" },
			env = {
				NODE_NO_WARNINGS = "1",
				GEMINI_API_KEY = os.getenv("GEMINI_API_KEY"),
			},
		},
		["claude-code"] = {
			command = "npx",
			args = { "@zed-industries/claude-code-acp" },
			env = {
				NODE_NO_WARNINGS = "1",
				ANTHROPIC_API_KEY = os.getenv("ANTHROPIC_AUTH_TOKEN"),
				ANTHROPIC_BASE_URL = os.getenv("ANTHROPIC_BASE_URL"),
			},
		},
	},
	behaviour = {
		auto_suggestions = false,           -- 实验性功能：是否在输入时自动给你补全/建议
		auto_set_highlight_group = true,   -- 是否自动设置高亮分组（不用手动配置 hl group）
		auto_set_keymaps = true,           -- 是否自动设置默认快捷键（禁用的话要自己绑定 keymap）
		auto_apply_diff_after_generation = true, -- AI 生成代码块后，是否自动应用 diff（默认需要手动确认）
		support_paste_from_clipboard = true, -- 是否支持直接从系统剪贴板粘贴内容给 AI
		minimize_diff = true,              -- 在应用代码块时是否自动去掉未变化的行（只保留修改过的 diff）
		enable_token_counting = true,      -- 是否启用 token 计数（通常用于费用/上下文统计）
		auto_approve_tool_permissions = true, -- 工具调用时是否自动批准权限（默认每次都要确认）
		-- 例子：
		-- auto_approve_tool_permissions = true, -- 所有工具直接放行，不弹提示
		-- auto_approve_tool_permissions = {"bash", "replace_in_file"}, -- 只自动批准特定工具
	},
	keymaps = {
		accept_suggestion = "<Tab>",
		reject_suggestion = "<C-]>",
	},
})
