local M = {}
local default_opts = { noremap = true }

M.global = {
	n = {
		["<Esc>"] = { ":noh <CR>", "clear highlights", opts = { silent = true } },
		["<tab>"] = { "<cmd> tabnext <CR>", "next buffer", opts = { silent = true } },
		["<S-tab>"] = { "<cmd> tabprevious <CR>", "next buffer", opts = { silent = true } },

		["<M-h>"] = { "<cmd> lua require('tmux').move_left() <CR>", "window left" },
		["<M-l>"] = { "<cmd> lua require('tmux').move_right() <CR>", "window right" },
		["<M-j>"] = { "<cmd> lua require('tmux').move_bottom() <CR>", "window down" },
		["<M-k>"] = { "<cmd> lua require('tmux').move_top() <CR>", "window up" },

		["<M-H>"] = { "<cmd> lua require('tmux').resize_left() <CR>", "window left" },
		["<M-L>"] = { "<cmd> lua require('tmux').resize_right() <CR>", "window right" },
		["<M-J>"] = { "<cmd> lua require('tmux').resize_bottom() <CR>", "window down" },
		["<M-K>"] = { "<cmd> lua require('tmux').resize_top() <CR>", "window up" },

		["<leader>b"] = { "<cmd> enew <CR>", "new buffer" },
		["<leader>w"] = { "<cmd> write <CR>", "save buffer" },
		["<leader>tn"] = { "<cmd> tabnew <CR>", "new tab" },
		["<leader>tc"] = { "<cmd> tabclose <CR>", "close tab" },
		["<leader>z"] = { "<C-w>|<C-w>_", "maximize pane" },

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

M.minisessions = {
	-- n = {
	-- ["<leader>sl"] = {
	-- 	function()
	-- 		require("mini.sessions").get_latest()
	-- 	end,
	-- 	"latest session",
	-- },
	-- 	["<leader>ss"] = {
	-- 		function()
	-- 			require("mini.sessions").select()
	-- 		end,
	-- 		"select session",
	-- 	},
	-- },
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

		["cn"] = {
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
		-- find
		["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "find files" },
		["<leader>ft"] = { "<cmd> Telescope file_browser <CR>", "telescope-file-browser" },
		["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "find all" },
		["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "live grep" },
		["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "find buffers" },
		["<M-tab>"] = { "<cmd> Telescope buffers <CR>", "find buffers" },
		["<leader>fr"] = { "<cmd> Telescope registers <CR>", "find registers" },
		["<leader>fk"] = { "<cmd> Telescope keymaps <CR>", "find keymap" },
		["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "find help page" },
		["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "find oldfiles" },
		["<leader>fz"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "fuzzy find in current buffer" },
		["<leader>fs"] = { "<cmd> Telescope sessions_picker <CR>", "find session" },
		["<leader>fd"] = { "<cmd> Telescope lsp_workspace_diagnostics <CR>", "find session" },

		-- ["<localleader>fd"] = { "<cmd> Telescope lsp_document_diagnostics <CR>", "find session" },
		["<localleader>fm"] = { "<cmd> Telescope marks <CR>", "find marks" },
		["<localleader>fs"] = { "<cmd> Telescope treesitter <CR>", "find treesitter symbols" },
		["<localleader>fr"] = { "<cmd> Telescope lsp_references <CR>", "find lsp referencfes" },

		-- git
		["<leader>fgc"] = { "<cmd> Telescope git_commits <CR>", "git commits" },
		["<leader>fgs"] = { "<cmd> Telescope git_status <CR>", "git status" },

		-- pick a hidden term
		["<leader>pt"] = { "<cmd> Telescope terms <CR>", "pick hidden term" },

		--telescope-dap
		["<leader>dB"] = { "<cmd> Telescope dap list_breakpoints <CR>", "list breakpoints" },
		["<leader>dv"] = { "<cmd> Telescope dap variables <CR>", "DAP variables" },
		["<leader>df"] = { "<cmd> Telescope dap frames <CR>", "DAP frames" },
		["<leader>dc"] = { "<cmd> Telescope dap commands <CR>", "DAP commands" },
		["<leader>dC"] = { "<cmd> Telescope dap configurations <CR>", "DAP configurations" },

		-- theme switcher
		-- ["<leader>th"] = { "<cmd> Telescope themes <CR>", "nvchad themes" },
	},
}
-- table structure: mode, keybinding, command, opts
M.nvimtree = {
	n = {
		["<leader>tt"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvim tree" },
		["<leader>tf"] = { "<cmd> NvimTreeFindFile <CR>", "find current file in nvim tree" },
		["<leader>tg"] = { "<cmd> NvimTreeFocus <CR>", "focus nvim tree" },
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
		["<leader>th"] = {
			function()
				require("nvterm.terminal").new("horizontal")
			end,
			"open horizontal nvterm",
		},
		["<leader>tv"] = {
			function()
				require("nvterm.terminal").new("vertical")
			end,
			"open vertical nvterm",
		},

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

M.tabby = {
	n = {
		["<leader>t<F2>"] = { ":RenameTab ", "Rename tab" },
	},
}

M.codewindow = {
	n = {
		["<leader>mm"] = {
			function()
				require("codewindow").toggle_minimap()
			end,
			"toggle minimap",
		},
	},
}

M.aerial = {
	n = {
		["<leader>o"] = {
			"<cmd> AerialToggle <CR>",
			"toggle outline",
		},
		["<leader>O"] = {
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

M.load_mappings = function(mapname, mapping_opt)
	vim.schedule(function()
		local function set_section_map(section_values)
			-- if section_values.plugin then
			--   return
			-- end
			--
			-- section_values.plugin = nil
			for mode, mode_values in pairs(section_values) do
				for keybind, mapping_info in pairs(mode_values) do
					-- merge default + user opts
					local opts = vim.tbl_deep_extend("force", default_opts, mapping_info.opts or {})
					opts = vim.tbl_deep_extend("force", opts, mapping_opt or {})

					mapping_info.opts, opts.mode = nil, nil
					opts.desc = mapping_info[2]

					vim.keymap.set(mode, keybind, mapping_info[1], opts)
				end
			end
		end
		local mappings = M
		if type(mapname) == "string" then
			-- mappings[section]["plugin"] = nil
			mappings = { mappings[mapname] }
		end
		for _, sect in pairs(mappings) do
			set_section_map(sect)
		end
	end)
end

return M
