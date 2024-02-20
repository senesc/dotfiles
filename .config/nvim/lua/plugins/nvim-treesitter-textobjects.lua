return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	lazy = true,
	config = function()
		require("nvim-treesitter.configs").setup({
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = { query = "@function.outer", desc = "function" },
						["if"] = { query = "@function.inner", desc = "function" },

						["ac"] = { query = "@class.outer", desc = "class" },
						["ic"] = { query = "@class.inner", desc = "class" },

						-- TODO: do these work?
						["ql"] = { query = "@assignment.lhs", desc = "left-hand side of assignment" },
						["qr"] = { query = "@assignment.rhs", desc = "right-hand side of assignment" },

						["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
						["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

						["ai"] = { query = "@conditional.outer", desc = "conditional" },
						["ii"] = { query = "@conditional.inner", desc = "conditional" },

						["al"] = { query = "@loop.outer", desc = "loop" },
						["il"] = { query = "@loop.inner", desc = "loop" },
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>a"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>A"] = "@parameter.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]m"] = "@function.outer",
						["]M"] = "@class.outer",
					},
					goto_next_end = {
						["]n"] = "@function.outer",
						["]N"] = "@class.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[M"] = "@class.outer",
					},
					goto_previous_end = {
						["[n"] = "@function.outer",
						["[N"] = "@class.outer",
					},
				},
			},
		})
	end,
}
