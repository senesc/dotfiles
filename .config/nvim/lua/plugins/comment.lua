return {
	"numToStr/Comment.nvim",
	keys = { "gc" },
	init = function()
		require("mappings").load_mappings("comment")
	end,
	config = function()
		require("Comment").setup()
	end,
}
