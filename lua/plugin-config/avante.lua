require('avante_lib').load()
require('avante').setup({
	opts = {
		provider = {
			gemini = {
				endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
				model = "gemini-1.5-flash-latest",
				timeout = 30000, -- Timeout in milliseconds
				temperature = 0,
				max_tokens = 4096,
			},
		}, -- 设置为 Gemini
	}
})
