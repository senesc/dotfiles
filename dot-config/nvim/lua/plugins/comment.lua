return {
	"numToStr/Comment.nvim",
	keys = { "gc", "gcc" },
	init = function()
		local mappings = require('mappings')
		mappings.load_maps(mappings.maps.comment)
	end,
	config = function()
		require("Comment").setup()
	end,
}
