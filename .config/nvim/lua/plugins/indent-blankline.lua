return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	init = function()
		local mappings = require("mappings")
		mappings.load_maps(mappings.maps.blankline)
	end,
	opts = {
		indent = {
			char = "┊",
		},
	},
}
