return {
	"nvim-telescope/telescope-dap.nvim",
	dependencies = { "nvim-dap", "telescope", "nvim-treesitter" },
	cmd = {
		"Telescope dap commands",
		"Telescope dap configurations",
		"Telescope dap list_breakpoints",
		"Telescope dap variables",
		"Telescope dap frames",
	},
	config = function(_, opts)
		require("telescope").load_extension("dap")
	end,
}
