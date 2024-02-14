return {
	"nvim-treesitter/nvim-treesitter",
	cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
	build = ":TSUpdate",

	opts = {
		ensure_installed = { "lua" },
		auto_install = true,
		highlight = {
			enable = true,
			use_languagetree = true,
			disable = { "latex" },
		},
		indent = { enable = true },
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
	end,
}
