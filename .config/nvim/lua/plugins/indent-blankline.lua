return {
	"lukas-reineke/indent-blankline.nvim",
	init = function()
		require("core.utils").lazy_load("indent-blankline.nvim")
	end,
	opts = {
		enabled = true,
		indent = {
			char = "║",
		},
		exclude = {
			filetypes = {
				"help",
				"man",
				"TelescopePrompt",
				"TelescopeResults",
				"lazy",
				"lspinfo",
				"mason",
				"nvdash",
				"nvcheatsheet",
			},
			buftypes = {
				"terminal",
				"quickfix",
				"nofile",
				"prompt",
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
		require("core.mappings").load_mappings("blankline")
		require("ibl").setup(opts)
	end,
}
