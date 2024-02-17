return {
	"zbirenbaum/copilot-cmp",
	dependencies = "copilot.lua",
	config = function(_, opts)
		local copilot_cmp = require("copilot_cmp")
		copilot_cmp.setup(opts)
	end,
}
