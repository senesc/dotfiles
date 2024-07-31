return {
	"zbirenbaum/copilot-cmp",
	-- As I don't want Copilot to be enabled by default.
	-- It can still be loaded with :Copilot enable.
	-- dependencies = "copilot.lua",
	config = function(_, opts)
		require("copilot_cmp").setup(opts)
	end,
}
