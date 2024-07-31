return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	opts = {
		flavour = "latte",
		background = {
			light = "latte",
			dark = "frappe",
		},
		integrations = {
			cmp = true,
			nvimtree = true,
			treesitter = true,
			gitsigns = true,
			aerial = true,
			mason = true,
			-- TODO: add nvim-dap nvim-lspconfig
		},
		dim_inactive = {
			enabled = true,
			shade = "dark",
			percentage = "0.15",
		},
	},
	config = function(_, opts)
		require("catppuccin").setup(opts)
		vim.cmd.colorscheme("catppuccin")
	end,
}
