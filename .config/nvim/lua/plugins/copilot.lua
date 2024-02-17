return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	build = ":Copilot auth",
	opts = {
		suggestion = { enabled = false },
		panel = { enabled = false },
		-- filetypes = {
		-- 	markdown = true,
		-- 	help = false,
		-- 	c = true,
		-- },
	},
	-- TODO: when should this start? important thing is i know when it is running and when it isn't. Abt, this, go configure lualine.
}
