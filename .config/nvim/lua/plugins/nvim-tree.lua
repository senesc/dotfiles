return {
	"nvim-tree/nvim-tree.lua",
	cmd = { "NvimTreeToggle", "NvimTreeFocus" },
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"stevearc/dressing.nvim",
	},
	init = function()
		local mappings = require("mappings")
		mappings.load_maps(mappings.maps.nvimtree)

		-- to avoid blank windows when restoring a session
		vim.api.nvim_create_autocmd({ "BufEnter" }, {
			pattern = "NvimTree*",
			callback = function()
				local api = require("nvim-tree.api")
				local view = require("nvim-tree.view")

				if not view.is_visible() then
					api.tree.open()
				end
			end,
		})
	end,
	opts = {
		disable_netrw = true,
		hijack_netrw = true,
		hijack_cursor = true,
		hijack_unnamed_buffer_when_opening = true,
		sync_root_with_cwd = true,
		actions = {
			open_file = {
				resize_window = true,
			},
			change_dir = {
				enable = false,
			}
		},
		diagnostics = {
			enable = true,
			show_on_dirs = true,
		},
		filesystem_watchers = {
			enable = true,
		},
		filters = {
			dotfiles = false,
			--exclude = { vim.fn.stdpath "config" .. "/lua/custom" },
		},
		git = {
			enable = true,
		},
		modified = {
			enable = true,
		},
		on_attach = function(bufnr)
			local mappings = require("mappings")
			mappings.load_maps(mappings.maps.nvimtree_onattach, {buffer = bufnr, noremap = true, silent = true, nowait = true})
		end,
		renderer = {
			add_trailing = true,
			group_empty = true,

			highlight_git = "none",
			highlight_diagnostics = "none",
			highlight_opened_files = "name",
			highlight_modified = "none",

			indent_markers = {
				enable = true,
			},

			icons = {
				git_placement = "after",
				diagnostics_placement = "signcolumn",
				show = {
					file = true,
					folder = true,
					folder_arrow = false,
					git = true,
				},

				glyphs = {
					default = "",
					symlink = "",
					bookmark = "",
					folder = {
						default = "",
						empty = "",
						empty_open = "",
						open = "",
						symlink = "",
						symlink_open = "",
						arrow_open = "",
						arrow_closed = "",
					},
					git = {
						unstaged = "",
						staged = "",
						unmerged = "",
						renamed = "",
						untracked = "",
						deleted = "",
						ignored = "",
					},
				},
				padding = "  ",
			},
		},
		update_focused_file = {
			enable = true,
			update_root = false,
		},
		view = {
			adaptive_size = true,
			centralize_selection = false,
			signcolumn = "yes",
			side = "left",
			width = 30,
			preserve_window_proportions = true,
			float = {
				enable = false,
				open_win_config = {
					relative = "editor",
					border = "rounded",
					width = 30,
					height = 30,
					row = 2,
					col = 2,
				},
			},
		},
	},
}
