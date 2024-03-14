local M = {}

M.init = {
	n = {
		["<Esc>"] = { ":noh <CR>", "clear highlights", opts = { silent = true } },
		["<tab>"] = { "<cmd> tabnext <CR>", "next buffer", opts = { silent = true } },
		["<S-tab>"] = { "<cmd> tabprevious <CR>", "next buffer", opts = { silent = true } },

		["<leader>w"] = { "<cmd> write <CR>", "save buffer" },
		["<leader>tn"] = { "<cmd> tabnew <CR>", "new tab" },
		-- ["<leader>c"] = { "<cmd> tabnew <CR>", "new tab" },
		["<leader>tc"] = { "<cmd> tabclose <CR>", "close tab" },
		["<C-w>z"] = { "<C-w>|<C-w>_", "maximize pane" },

		["<M-g>"] = { "[szg``", "mark last misspelling as good" },
		["<M-c>"] = { "[s1z=`]", "auto correct last misspelling" },
	},
	c = {
		["<C-a>"] = { "<Home>", "goto beginnning" },
		["<C-e>"] = { "<End>", "goto beginnning" },
		["<M-b>"] = { "<C-Left>", "goto beginnning" },
		["<M-f>"] = { "<C-Right>", "goto beginnning" },
		["<M-Left>"] = { "<C-Left>", "goto beginnning" },
		["<M-Right>"] = { "<C-Right>", "goto beginnning" },
	},
	i = {
		-- Bash-like movements
		["<C-a>"] = { "<ESC>^i", "beginning of line" },
		["<C-e>"] = { "<End>", "end of line" },
		["<M-b>"] = { "<S-Left>", "one word backwards" },
		["<M-f>"] = { "<S-Right>", "one word forward" },
		["<M-tab>"] = { "<Esc> <cmd> tabnext <CR>", "next tab" },

		["<M-h>"] = { "<Esc> <cmd> TmuxNavigateLeft <CR>", "window left" },
		["<M-l>"] = { "<Esc> <cmd> TmuxNavigateRight <CR>", "window right" },
		["<M-j>"] = { "<Esc> <cmd> TmuxNavigateDown <CR>", "window down" },
		["<M-k>"] = { "<Esc> <cmd> TmuxNavigateUp <CR>", "window up" },

		["<M-g>"] = { "<Esc>[szg`]a", "mark last misspelling as good" },
		["<M-c>"] = { "<Esc>[s1z=`]a", "auto correct last misspelling" },
	},
	v = {},
	t = {
		["<C-x>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "escape terminal mode" },
		["<M-h>"] = { "<C-\\><C-n><C-w>h", "window left" },
		["<M-l>"] = { "<C-\\><C-n><C-w>l", "window right" },
		["<M-j>"] = { "<C-\\><C-n><C-w>j", "window down" },
		["<M-k>"] = { "<C-\\><C-n><C-w>k", "window up" },
	},
	x = {
		["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "dont copy replaced text", opts = { silent = true } },
	},
}

M.blankline = {
	n = {
		["<leader>cc"] = {
			function()
				local ok, start = require("indent_blankline.utils").get_current_context(
					vim.g.indent_blankline_context_patterns,
					vim.g.indent_blankline_use_treesitter_scope
				)

				if ok then
					vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
					vim.cmd([[normal! _]])
				end
			end,

			"Jump to current_context",
		},
	},
}

M.lspconfig = {
	-- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

	n = {
		["gD"] = {
			function()
				vim.lsp.buf.declaration()
			end,
			"lsp declaration",
		},

		["gd"] = {
			function()
				vim.lsp.buf.definition()
			end,
			"lsp definition",
		},

		["K"] = {
			function()
				vim.lsp.buf.hover()
			end,
			"lsp hover",
		},

		["gi"] = {
			function()
				vim.lsp.buf.implementation()
			end,
			"lsp implementation",
		},

		["<leader>ls"] = {
			function()
				vim.lsp.buf.signature_help()
			end,
			"lsp signature_help",
		},

		["<leader>D"] = {
			function()
				vim.lsp.buf.type_definition()
			end,
			"lsp type defintion",
		},

		["<F2>"] = {
			function()
				vim.lsp.buf.rename()
			end,
			"lsp rename symbol",
		},

		["<leader>ca"] = {
			function()
				vim.lsp.buf.code_action()
			end,
			"lsp code_action",
		},

		["gr"] = {
			function()
				vim.lsp.buf.references()
			end,
			"lsp references",
		},

		["<leader>f"] = {
			function()
				vim.diagnostic.open_float({ border = "rounded" })
			end,
			"floating diagnostic",
		},

		["[d"] = {
			function()
				vim.diagnostic.goto_prev()
			end,
			"goto prev",
		},

		["]d"] = {
			function()
				vim.diagnostic.goto_next()
			end,
			"goto_next",
		},

		["<leader>q"] = {
			function()
				vim.diagnostic.setloclist()
			end,
			"diagnostic setloclist",
		},

		["<leader>fm"] = {
			function()
				vim.lsp.buf.format({ async = true })
			end,
			"lsp formatting",
		},

		["<leader>wa"] = {
			function()
				vim.lsp.buf.add_workspace_folder()
			end,
			"add workspace folder",
		},

		["<leader>wr"] = {
			function()
				vim.lsp.buf.remove_workspace_folder()
			end,
			"remove workspace folder",
		},

		["<leader>wl"] = {
			function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end,
			"list workspace folders",
		},
	},
}

M.dap = {
	n = {
		["<F5>"] = {
			function()
				require("dap").continue()
			end,
			"Continue",
		},
		["<F10>"] = {
			function()
				require("dap").step_over()
			end,
			"Step over",
		},
		["<F11>"] = {
			function()
				require("dap").step_into()
			end,
			"Step into",
		},
		["<F12>"] = {
			function()
				require("dap").step_out()
			end,
			"Step out",
		},
		["<leader>db"] = {
			function()
				require("dap").toggle_breakpoint()
			end,
			"Toggle breakpoint",
		},
		["<leader>dl"] = {
			function()
				require("dap").run_last()
			end,
			"Run last",
		},
		["<leader>dr"] = {
			function()
				require("dap").repl.open()
			end,
			"Open REPL",
		},
	},
}

M.dapui = {
	n = {
		["<leader>du"] = {
			function()
				require("dapui").toggle()
			end,
			"Toggle DAP UI",
		},
	},
}

M.telescope = {
	n = {
		["<leader>F"] = { "<cmd> Telescope builtin <CR>", "list telescope functions" },
		-- find
		["<leader>ff"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "find files" },
		["<leader>ft"] = { "<cmd> Telescope file_browser <CR>", "telescope-file-browser" },
		["<leader>fa"] = { "<cmd> Telescope live_grep <CR>", "live grep on all files" },
		["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "find buffers" },
		["<M-tab>"] = { "<cmd> Telescope buffers <CR>", "find buffers" },
		['<leader>f"'] = { "<cmd> Telescope registers <CR>", "find registers" },
		["<leader>f'"] = { "<cmd> Telescope marks <CR>", "find marks" },
		["<leader>fk"] = { "<cmd> Telescope keymaps <CR>", "find keymap" },
		["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "find help page" },
		["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "find oldfiles" },
		["<leader>fs"] = { "<cmd> Telescope sessions_picker <CR>", "find session" },
		["<leader>fd"] = { "<cmd> Telescope lsp_workspace_diagnostics <CR>", "find session" },
		["<leader>fj"] = { "<cmd> Telescope jumplist <CR>", "find latest jumps" },
		["<leader>f/"] = { "<cmd> Telescope search_history <CR>", "find search history" },
		["<leader>b"] = { "<cmd> Telescope buffers <CR>", "new buffer" },

		-- TODO: continue setting up these
		-- Buffer specific
		["<localleader>fz"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "fuzzy find in current buffer" },
		-- LSP stuff
		-- ["<localleader>fd"] = { "<cmd> Telescope lsp_document_diagnostics <CR>", "find session" },
		["<localleader>fs"] = { "<cmd> Telescope treesitter <CR>", "find treesitter symbols" },
		["<localleader>fr"] = { "<cmd> Telescope lsp_references <CR>", "find lsp referencfes" },

		-- git
		["<leader>fgc"] = { "<cmd> Telescope git_commits <CR>", "git commits" },
		["<leader>fgs"] = { "<cmd> Telescope git_status <CR>", "git status" },

		-- pick a hidden term
		-- ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "pick hidden term" },

		--telescope-dap
		["<leader>dB"] = { "<cmd> Telescope dap list_breakpoints <CR>", "list breakpoints" },
		["<leader>dv"] = { "<cmd> Telescope dap variables <CR>", "DAP variables" },
		["<leader>df"] = { "<cmd> Telescope dap frames <CR>", "DAP frames" },
		["<leader>dc"] = { "<cmd> Telescope dap commands <CR>", "DAP commands" },
		["<leader>dC"] = { "<cmd> Telescope dap configurations <CR>", "DAP configurations" },

		-- theme switcher
		["<leader>cs"] = { "<cmd> Telescope colorscheme <CR>", "change colorscheme" },
	},
}

M.nvimtree = {
	-- Mappings for the nvimtree buffer are set in nvim-tree.lua
	n = {
		["<leader>tt"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvim tree" },
		-- ["<leader>tf"] = { "<cmd> NvimTreeFindFile <CR>", "find current file in nvim tree" },
		-- ["<leader>tg"] = { "<cmd> NvimTreeFocus <CR>", "focus nvim tree" },
	},
}

M.whichkey = {
	n = {
		["<leader>wK"] = {
			function()
				vim.cmd("WhichKey")
			end,
			"which-key all keymaps",
		},
		["<leader>wk"] = {
			function()
				local input = vim.fn.input("WhichKey: ")
				vim.cmd("WhichKey " .. input)
			end,
			"which-key query lookup",
		},
	},
}

M.nvterm = {
	n = {
		["<M-b>"] = {
			function()
				require("nvterm.terminal").toggle("horizontal")
			end,
			"toggle horizontal nvterm",
		},
		["<M-v>"] = {
			function()
				require("nvterm.terminal").toggle("vertical")
			end,
			"toggle vertical nvterm",
		},
		["<M-t>"] = {
			function()
				require("nvterm.terminal").toggle("float")
			end,
			"toggle floating terminal",
		},
	},
	t = {
		["<M-b>"] = {
			function()
				require("nvterm.terminal").toggle("horizontal")
			end,
			"toggle horizontal nvterm",
		},
		["<M-v>"] = {
			function()
				require("nvterm.terminal").toggle("vertical")
			end,
			"toggle vertical nvterm",
		},
		["<M-t>"] = {
			function()
				require("nvterm.terminal").toggle("float")
			end,
			"toggle floating terminal",
		},
	},
}

M.comment = {
	n = {
		["gcc"] = {
			function()
				require("Comment.api").toggle.linewise.current()
			end,
			"toggle comment",
		},
	},
	v = {
		["gc"] = {
			"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
			"toggle comment",
		},
	},
}

M.luasnip = {
	i = {
		["<C-n>"] = { "<Plug>luasnip-next-choice", "next choice in ChoiceNode" },
		["<C-p>"] = { "<Plug>luasnip-previous-choice", "previous choice in ChoiceNode" },
	},
	s = {
		["<C-n>"] = { "<Plug>luasnip-next-choice", "next choice in ChoiceNode" },
		["<C-p>"] = { "<Plug>luasnip-previous-choice", "previous choice in ChoiceNode" },
	},
}

M.aerial = {
	n = {
		["<leader>O"] = {
			"<cmd> AerialToggle <CR>",
			"toggle outline",
		},
		["<leader>o"] = {
			"<cmd> AerialNavToggle <CR>",
			"toggle breadcrumbs outline",
		},
	},
}

M.todocomments = {
	n = {
		["]t"] = {
			function()
				require("todo-comments").jump_next()
			end,
			"next TODO comment",
		},
		["[t"] = {
			function()
				require("todo-comments").jump_prev()
			end,
			"previous TODO comment",
		},
	},
}

-- from https://github.com/neovide/neovide/issues/1301#issuecomment-1705046950
-- don't know why but these function much better as commands
M.neovide = {
	n = {
		["<C-=>"] = {
			"<cmd> lua vim.g.neovide_scale_factor = math.min(vim.g.neovide_scale_factor + 0.05,  1.5) <CR>",
			"zoom in",
			opts = {
				silent = true
			}
		},
		["<C-->"] = {
			"<cmd> lua vim.g.neovide_scale_factor = math.max(vim.g.neovide_scale_factor - 0.05,  0.7) <CR>",
			"zoom out",
			opts = {
				silent = true
			}
		},
		["<C-w>0"] = {
			 "<cmd> lua vim.g.neovide_scale_factor = 1.0 <CR>",
			"set scale factor",
			opts = {
				silent = true
			}
		},
	},
}

M.nvimtree_onattach = {
	n = {
		["<CR>"] = {
			function()
				require("nvim-tree.api").node.open.edit()
			end, "Open node",
		},
		["o"] = {
			function()
				require("nvim-tree.api").node.open.edit()
			end, "Open node",
		},
		["<C-]>"] = {
			function()
				require("nvim-tree.api").tree.change_root_to_node()
			end, "Change root to node",
		},
		["<M-Up>"] = {
			function()
				require("nvim-tree.api").tree.change_root_to_parent()
			end, "Move root up",
		},
		["zc"] = {
			function()
				require("nvim-tree.api").node.navigate.parent_close()
			end, "Close node",
		},
		["zO"] = {
			function()
				require("nvim-tree.api").tree.expand_all()
			end, "Expand node recursive",
		},
		["zM"] = {
			function()
				require("nvim-tree.api").tree.collapse_all()
			end, "Collapse tree",
		},
		["zo"] = {
			function()
				require("nvim-tree.api").node.open.edit()
			end, "Open node",
		},
		["g?"] = {
			function()
				require("nvim-tree.api").tree.toggle_help()
			end, "Help",
		},
		["<C-t>"] = {
			function()
				require("nvim-tree.api").node.open.tab()
			end, "Open: New Tab",
		},
		["<C-v>"] = {
			function()
				require("nvim-tree.api").node.open.vertical()
			end, "Open: Vertical Split",
		},
		["<C-x>"] = {
			function()
				require("nvim-tree.api").node.open.horizontal()
			end, "Open: Horizontal Split",
		},
		["]]"] = {
			function()
				require("nvim-tree.api").node.navigate.sibling.next()
			end, "Next Sibling",
		},
		["[["] = {
			function()
				require("nvim-tree.api").node.navigate.sibling.prev()
			end, "Prev Sibling",
		},
		["[g"] = {
			function()
				require("nvim-tree.api").node.navigate.git.prev()
			end, "Prev Git",
		},
		["]g"] = {
			function()
				require("nvim-tree.api").node.navigate.git.next()
			end, "Next Git",
		},
		["[o"] = {
			function()
				require("nvim-tree.api").node.navigate.opened.prev()
			end, "Prev Open",
		},
		["]o"] = {
			function()
				require("nvim-tree.api").node.navigate.opened.next()
			end, "Next Open",
		},
		["]d"] = {
			function()
				require("nvim-tree.api").node.navigate.diagnostics.next()
			end, "Next Diagnostic",
		},
		["[d"] = {
			function()
				require("nvim-tree.api").node.navigate.diagnostics.prev()
			end, "Prev Diagnostic",
		},
		["m"] = {
			function()
				require("nvim-tree.api").marks.toggle()
			end, "Toggle Bookmark",
		},
		["<M-f>m"] = {
			function()
				require("nvim-tree.api").tree.toggle_no_bookmark_filter()
			end, "Toggle Filter: Marked",
		},
		["<M-f>h"] = {
			function()
				require("nvim-tree.api").tree.toggle_hidden_filter()
			end, "Toggle Filter: Dotfiles",
		},
		["<M-f>gi"] = {
			function()
				require("nvim-tree.api").tree.toggle_gitignore_filter()
			end, "Toggle Filter: Git Ignore",
		},
		["<M-f>gc"] = {
			function()
				require("nvim-tree.api").tree.toggle_git_clean_filter()
			end, "Toggle Filter: Git Clean",
		},
		["<M-f>b"] = {
			function()
				require("nvim-tree.api").tree.toggle_no_buffer_filter()
			end, "Toggle Filter: Buffers",
		},
		["I"] = {
			function()
				require("nvim-tree.api").node.show_info_popup()
			end, "Info",
		},
		["i"] = {
			function()
				require("nvim-tree.api").node.open.preview()
			end, "Open Preview",
		},
		["D"] = {
			function()
				require("nvim-tree.api").fs.remove()
			end, "Delete",
		},
		["dd"] = {
			function()
				require("nvim-tree.api").fs.cut()
			end, "Cut",
		},
		["r"] = {
			function()
				require("nvim-tree.api").fs.rename_full()
			end, "Rename: Full Path",
		},
		["a"] = {
			function()
				require("nvim-tree.api").fs.create()
			end, "Create File Or Directory",
		},
		["R"] = {
			function()
				require("nvim-tree.api").fs.rename_basename()
			end, "Rename: Basename",
		},
		["yp"] = {
			function()
				require("nvim-tree.api").fs.copy.absolute_path()
			end, "Copy Absolute Path",
		},
		["yn"] = {
			function()
				require("nvim-tree.api").fs.copy.filename()
			end, "Copy filename",
		},
		["yy"] = {
			function()
				require("nvim-tree.api").fs.copy.node()
			end, "Copy file",
		},
		["p"] = {
			function()
				require("nvim-tree.api").fs.paste()
			end, "Paste",
		},
		["bd"] = {
			function()
				require("nvim-tree.api").marks.bulk.delete()
			end, "Delete Bookmarked",
		},
		["bmv"] = {
			function()
				require("nvim-tree.api").marks.bulk.move()
			end, "Move Bookmarked",
		},
		["x"] = {
			function()
				local buf = require("core.utils").get_bufnr_by_path(require("nvim-tree.api").tree.get_node_under_cursor()
				.absolute_path)
				if buf ~= nil then
					vim.api.nvim_buf_delete(buf, {})
				end
			end, "Close buffer",
		},
		["ga"] = {function ()
			local api = require("nvim-tree.api")
			os.execute("git add ".. api.tree.get_node_under_cursor().absolute_path)
			api.git.reload()
		end}, --TODO: continue after this
	},
}

M.tmux = {
	n = {
		["<M-h>"] = { function ()
			require('tmux').move_left()
		end, "focus window to the left" },
		["<M-j>"] = { function ()
			require('tmux').move_bottom()
		end, "focus window down" },
		["<M-k>"] = { function ()
			require('tmux').move_top()
		end, "focus window up" },
		["<M-l>"] = { function ()
			require('tmux').move_right()
		end, "focus window to the right" },

		["<M-H>"] = { function ()
			require('tmux').resize_left()
		end, "resize window to the left" },
		["<M-J>"] = { function ()
			require('tmux').resize_bottom()
		end, "resize window down" },
		["<M-K>"] = { function ()
			require('tmux').resize_top()
		end, "resize window up" },
		["<M-L>"] = { function ()
			require('tmux').resize_right()
		end, "resize window to the right" },
	}
}

M.gitsigns = {
	n = {
		["]g"] = { function ()
			require("gitsigns").next_hunk()
			require("nvim-tree.api").git.reload()
		end, "Next Git Hunk"},
		["[g"] = { function ()
			require("gitsigns").prev_hunk()
			require("nvim-tree.api").git.reload()
		end, "Next Git Hunk"},
		["<leader>ga"] = {
			function ()
				require("gitsigns").stage_hunk() -- TODO: add ranges
				require("nvim-tree.api").git.reload()
			end, "Stage Git Hunk"
		},
		["<leader>gA"] = {
			function ()
				require("gitsigns").stage_buffer()
				require("nvim-tree.api").git.reload()
			end, "Stage Buffer"
		},
		["<leader>gu"] = {
			function ()
				require("gitsigns").undo_stage_hunk()
				require("nvim-tree.api").git.reload()
			end
		},
		["<leader>gr"] = {
			function ()
				require("gitsigns").reset_hunk()
				require("nvim-tree.api").git.reload()
			end
		},
		["<leader>gR"] = {
			function ()
				require("gitsigns").reset_buffer()
				require("nvim-tree.api").git.reload()
			end
		},
		["<leader>gd"] = {
			function ()
				require("gitsigns").diffthis()
			end
		},
	}
}

return M
