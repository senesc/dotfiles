return {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = {
  filters = {
    dotfiles = false,
    --exclude = { vim.fn.stdpath "config" .. "/lua/custom" },
  },
  disable_netrw = true,
  hijack_netrw = true,
  hijack_cursor = true,
  hijack_unnamed_buffer_when_opening = true,
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  view = {
    adaptive_size = true,
	centralize_selection = true,
	signcolumn = 'auto',
    side = "left",
    width = 30,
    preserve_window_proportions = true,
	float = {
		enable = false,
		open_win_config = {
			relative = 'editor',
			border = 'rounded',
			width = 30,
			height = 30,
			row = 2,
			col = 2
		},
	},
  },
  git = {
    enable = false,
    ignore = true,
  },
  filesystem_watchers = {
    enable = true,
  },
  on_attach = function (bufnr)
    local api = require("nvim-tree.api")
api.config.mappings.default_on_attach(bufnr)
	  vim.keymap.set('n', '?', api.tree.toggle_help, { desc = 'Help',  buffer = bufnr, noremap = true, silent = true, nowait = true })
	  vim.keymap.set('n', '<Esc>', api.tree.close, { desc = 'Close',  buffer = bufnr, noremap = true, silent = true, nowait = true })
  end,
  actions = {
    open_file = {
      resize_window = true,
    },
  },
  renderer = {
    highlight_git = false,
    highlight_opened_files = "name",

	highlight_modified = 'icon',

	--root_folder_label

    indent_markers = {
      enable = false,
    },

    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = false,
      },

      glyphs = {
        default = "",
        symlink = "",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
          symlink_open = "",
          arrow_open = "",
          arrow_closed = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
},
	init = function()
      require('mappings').load_mappings("nvimtree")
    end,
    config = function(_, opts)
      require("nvim-tree").setup(opts)
    end,
--[[
      dofile(vim.g.base46_cache .. "nvimtree")
      vim.g.nvimtree_side = opts.view.side
	--]]
}
