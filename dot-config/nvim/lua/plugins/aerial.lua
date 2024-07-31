return {
	"stevearc/aerial.nvim",
	init = function(_)
		local mappings = require('mappings')
		mappings.load_maps(mappings.maps.aerial)
	end,
	event = "BufEnter",
	opts = {
		on_attach = function(bufnr)
			-- Jump forwards/backwards with '{' and '}'
			vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
			vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
		end,
		layout = {
			default_direction = "prefer_left",
			placement = "edge",
			min_width = 20,
			max_width = { 45, 0.25 },
		},
		attach_mode = "global",
		nav = {
			preview = true,
			keymaps = {
				["<Esc>"] = "actions.close"
			}
		}
	},
	-- Optional dependencies
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
}
