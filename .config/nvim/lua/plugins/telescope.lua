return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"JoseConseco/telescope_sessions_picker.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
	},
	cmd = { "Telescope" },
	opts = {
		defaults = {
			mappings = {
				i = {
					["<esc>"] = function(bufnr)
						require("telescope.actions").close(bufnr)
					end,
				},
			},
			vimgrep_arguments = {
				"rg",
				"-L",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
			},
			prompt_prefix = "   ",
			selection_caret = "  ",
			entry_prefix = "  ",
			initial_mode = "insert",
			selection_strategy = "reset",
			sorting_strategy = "ascending",
			layout_strategy = "horizontal",
			layout_config = {
				horizontal = {
					prompt_position = "top",
					preview_width = 0.55,
					results_width = 0.8,
				},
				vertical = {
					mirror = false,
				},
				width = 0.87,
				height = 0.80,
				preview_cutoff = 120,
			},
			file_ignore_patterns = { "node_modules" },
			path_display = { "truncate" },
			winblend = 0,
			border = {},
			borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			color_devicons = true,
			set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		},
		extensions_list = { "themes", "terms" },
		extensions = {
			sessions_picker = {
				sessions_dir = vim.g.sessionpath,
			},
		},
	},
	config = function(_, opts)
		opts.file_previewer = require("telescope.previewers").vim_buffer_cat.new
		opts.generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter
		opts.file_previewer = require("telescope.previewers").vim_buffer_cat.new
		opts.grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new
		opts.qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new
		-- Developer configurations: Not meant for general override
		opts.buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker

		require("telescope").setup(opts)
		require("telescope").load_extension("sessions_picker")
		require("telescope").load_extension("file_browser")
	end,
	init = function()
		require("core.mappings").load_mappings("telescope")
	end,
}
