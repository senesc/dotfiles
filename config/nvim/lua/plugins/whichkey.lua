return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		require("mappings").load_mappings("whichkey")
	end,
	opts = {
		window = {
			border = "double", -- none/single/double/shadow
			margin = { 3, 4, 3, 4 }, -- top/right/bottom/left
		},
	},
}
