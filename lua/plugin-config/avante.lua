require("avante_lib").load()
require("avante").setup({
	build = vim.fn.has("win32") ~= 0
		and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
		or "make",

	instructions_file = "CLAUDE.md",

	-- 👇 不要包在 opts 里面，直接写
	provider = "moonshot",
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
			timeout = 30000, -- Timeout in milliseconds
			extra_request_body = {
				temperature = 0.75,
				max_tokens = 32768,
			},
		},
	},
})
