return {
	"nvim-tree/nvim-tree.lua",
	cmd = { "NvimTreeToggle", "NvimTreeFocus" },
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
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
			local api = require("nvim-tree.api")
			-- api.config.mappings.default_on_attach(bufnr)
			-- TODO: put this in mappings.lua (being careful to make the maps buffer-local)
			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end
			vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open node"))
			vim.keymap.set("n", "o", api.node.open.edit, opts("Open node"))
			vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
			vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts("Change root to node"))
			vim.keymap.set("n", "<M-Up>", api.tree.change_root_to_parent, opts("Move root up"))
			vim.keymap.set("n", "zc", api.node.navigate.parent_close, opts("Close node"))
			vim.keymap.set("n", "zO", api.tree.expand_all, opts("Expand node recursive"))
			vim.keymap.set("n", "zM", api.tree.collapse_all, opts("Collapse tree"))
			vim.keymap.set("n", "zo", api.node.open.edit, opts("Open node"))
			vim.keymap.set("n", "g?", api.tree.toggle_help, opts("Help"))

			vim.keymap.set("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))
			vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
			vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))

			vim.keymap.set("n", "]]", api.node.navigate.sibling.next, opts("Next Sibling"))
			vim.keymap.set("n", "[[", api.node.navigate.sibling.prev, opts("Prev Sibling"))
			vim.keymap.set("n", "[g", api.node.navigate.git.prev, opts("Prev Git"))
			vim.keymap.set("n", "]g", api.node.navigate.git.next, opts("Next Git"))
			vim.keymap.set("n", "[o", api.node.navigate.opened.prev, opts("Prev Open"))
			vim.keymap.set("n", "]o", api.node.navigate.opened.next, opts("Next Open"))
			vim.keymap.set("n", "]d", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
			vim.keymap.set("n", "[d", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))

			vim.keymap.set("n", "m", api.marks.toggle, opts("Toggle Bookmark"))
			vim.keymap.set("n", "<M-m>", api.tree.toggle_no_bookmark_filter, opts("Toggle Filter: No Bookmark"))
			vim.keymap.set("n", "<M-h>", api.tree.toggle_hidden_filter, opts("Toggle Filter: Dotfiles"))
			vim.keymap.set("n", "<M-g>i", api.tree.toggle_gitignore_filter, opts("Toggle Filter: Git Ignore"))
			vim.keymap.set("n", "<M-g>c", api.tree.toggle_git_clean_filter, opts("Toggle Filter: Git Clean"))
			vim.keymap.set("n", "<M-b>", api.tree.toggle_no_buffer_filter, opts("Toggle Filter: No Buffer"))

			vim.keymap.set("n", "I", api.node.show_info_popup, opts("Info"))
			vim.keymap.set("n", "i", api.node.open.preview, opts("Open Preview"))
			vim.keymap.set("n", "D", api.fs.remove, opts("Delete"))
			vim.keymap.set("n", "dd", api.fs.cut, opts("Delete"))
			vim.keymap.set("n", "r", api.fs.rename_full, opts("Rename: Full Path"))
			vim.keymap.set("n", "a", api.fs.create, opts("Create File Or Directory"))
			vim.keymap.set("n", "R", api.fs.rename_basename, opts("Rename: Basename"))
			vim.keymap.set("n", "yp", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
			vim.keymap.set("n", "yn", api.fs.copy.filename, opts("Copy filename"))
			vim.keymap.set("n", "yy", api.fs.copy.node, opts("Copy file"))
			vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
			vim.keymap.set("n", "bd", api.marks.bulk.delete, opts("Delete Bookmarked"))
			vim.keymap.set("n", "bmv", api.marks.bulk.move, opts("Move Bookmarked"))
			vim.keymap.set("n", "x", function()
				vim.api.nvim_buf_delete(
					require("core.utils").get_bufnr_by_path(api.tree.get_node_under_cursor().absolute_path),
					{}
				)
			end, opts("Close buffer"))
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
			centralize_selection = true,
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
	init = function()
		require("mappings").load_mappings("nvimtree")
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
	config = function(_, opts)
		require("nvim-tree").setup(opts)
	end,
	--[[
      dofile(vim.g.base46_cache .. "nvimtree")
      vim.g.nvimtree_side = opts.view.side
	--]]
}
