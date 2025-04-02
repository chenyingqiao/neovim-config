local conf = {
    -- For customization, refer to Install > Configuration in the Documentation/Readme
	providers={
		googleai = {
			endpoint = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:streamGenerateContent?key={{secret}}",
			secret = os.getenv("GEMINI_API_KEY"),
		},
	}
}
require("gp").setup(conf)
