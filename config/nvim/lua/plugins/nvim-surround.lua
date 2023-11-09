return {
	"kylechui/nvim-surround",
	event = "VeryLazy",
	opts = {},
	config = function(_, opts)
		require("nvim-surround").setup(opts)
	end,
}
