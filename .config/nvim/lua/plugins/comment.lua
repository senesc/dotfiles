return {
	"numToStr/Comment.nvim",
	keys = { "gc", "gcc" },
	init = function()
		require("core.mappings").load_mappings("comment")
	end,
	config = function()
		require("Comment").setup()
	end,
}
