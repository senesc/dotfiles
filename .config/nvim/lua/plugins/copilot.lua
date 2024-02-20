return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	build = ":Copilot auth",
	opts = {
		suggestion = { enabled = false },
		panel = { enabled = true, auto_refresh = true, layout = { position = "right" } },
		-- filetypes = {
		-- 	markdown = true,
		-- 	help = false,
		-- 	c = true,
		-- },
	},
}
