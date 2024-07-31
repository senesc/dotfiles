return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		local mappings = require("mappings")
		mappings.load_maps(mappings.maps.whichkey)
	end,
}
