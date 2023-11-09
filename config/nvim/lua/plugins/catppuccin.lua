return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	opts = {
		flavour = "frappe",
		background = {
			light = "latte",
			dark = "frappe",
		},
		integrations = {
			cmp = true,
			nvimtree = true,
			treesitter = true,
		},
	},
	config = function(_, opts)
		require("catppuccin").setup(opts)
		vim.cmd("colorscheme catppuccin")
	end,
}
