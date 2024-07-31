return {
	"NvChad/nvterm",
	opts = {
		terminals = {
			shell = vim.o.shell,
			list = {},
			type_opts = {
				float = {
					relative = "editor",
					row = 0.1,
					col = 0.1,
					width = 0.8,
					height = 0.8,
					border = "single",
				},
				horizontal = { location = "rightbelow", split_ratio = 0.3 },
				vertical = { location = "rightbelow", split_ratio = 0.5 },
			},
		},
		behavior = {
			autoclose_on_quit = {
				enabled = false,
				confirm = true,
			},
			close_on_exit = true,
			auto_insert = true,
		},
	},
	init = function()
		local mappings = require("mappings")
		mappings.load_maps(mappings.maps.nvterm)
	end,
	config = function(_, opts)
		--require "base46.term"
		require("nvterm").setup(opts)
	end,
}
