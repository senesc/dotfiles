return {
	'epwalsh/obsidian.nvim',
	version = '*',
	lazy = true,
	ft = "markdown",
	-- optionally:
	-- event = {
	--    "BufReadPre path/to/vault/**.md"
	--    "BufNewFile path/to/vault/**.md"
	-- }
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"hrsh7th/nvim-cmp"
	},
	opts = {
		workspaces = {
			{ name = "obs", path = "~/docs/obs", strict = true }
		},
		daily_notes = {
			folder = "journal/dailies",
			template = "daily.md"
		},
		templates = {
			subdir = "utils/templates"
		},
		completion = {
			nvim_cmp = true,
			min_chars = 3
		},
		mappings = {},
		new_notes_location = "current_dir",

		picker = {
			name = "telescope.nvim"
		}

	}
}
