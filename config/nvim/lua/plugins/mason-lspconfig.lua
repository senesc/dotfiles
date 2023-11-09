return {
	"williamboman/mason-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
	},
	opts = {
		ensure_installed = { "lua_ls", "clangd" },
	},
	config = function(_, opts)
		require("mason-lspconfig").setup(opts)
	end,
}
