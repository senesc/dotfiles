return {
	"echasnovski/mini.sessions",
	opts = {
		autoread = false,
		autowrite = true,
		file = "",
		directory = vim.g.sessionpath,
	},
	config = function(_, opts)
		require("mini.sessions").setup(opts)
		require("mappings").load_mappings("minisessions")
	end,
	lazy = false,
}
