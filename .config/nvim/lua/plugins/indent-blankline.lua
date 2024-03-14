return {
	"lukas-reineke/indent-blankline.nvim",
	init = function()
		local mappings = require("mappings")
		mappings.load_maps(mappings.maps.blankline)
	end,
	main = "ibl",
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
}
