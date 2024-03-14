return {
	"nvim-treesitter/nvim-treesitter",
	cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
	build = ":TSUpdate",
	event = "BufEnter",
	dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
	opts = {
		ensure_installed = { "lua" },
		auto_install = true,
		highlight = {
			enable = true,
			use_languagetree = true,
			disable = { "latex" },
		},
		indent = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<M-o>",
				node_incremental = "<M-o>",
				-- scope_incremental = "<M-s>", don't really know what this does
				node_decremental = "<M-i>",
			},
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
	end,
}
