return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		local mappings = require("mappings")
		mappings.load_maps(mappings.maps.whichkey)
	end,
	opts = {
		window = {
			border = "single", -- none/single/double/shadow
			margin = { 3, 4, 3, 4 }, -- top/right/bottom/left
			winblend = 30,
		},
	},
}
