return {
	"lukas-reineke/indent-blankline.nvim",
	init = function()
		require("core.utils").lazy_load("indent-blankline.nvim")
	end,
	opts = {
		indentLine_enabled = 1,
		exclude = {
			buftype = {
				"help",
				"terminal",
				"lazy",
				"lspinfo",
				"TelescopePrompt",
				"TelescopeResults",
				"mason",
				"nvdash",
				"nvcheatsheet",
				"",
			},
		},
		scope = {
			enabled = true,
			show_start = true,
			show_end = true,
		},
		-- show_trailing_blankline_indent = false,
		-- show_first_indent_level = false,
	},
	config = function(_, opts)
		require("mappings").load_mappings("blankline")
		require("ibl").setup(opts)
	end,
}
