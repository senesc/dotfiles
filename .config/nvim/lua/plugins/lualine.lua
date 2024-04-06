return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = {
		"AndreM222/copilot-lualine",
	},
	-- TODO: further configuration
	opts = {
		options = {
			icons_enabled = true,
			theme = "auto",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				statusline = {},
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = false,
			globalstatus = false,
			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
			},
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "diff", "diagnostics" },
			lualine_c = { {
				"filename",
			} },
			lualine_x = {
				{
					"copilot",
					symbols = {
						status = {
							icons = {
								enabled = "",
								disabled = "",
								warning = "",
								unknown = "",
							},
							hl = {
								enabled = "#50FA7B",
								disabled = "#6272A4",
								warning = "#FFB86C",
								unknown = "#6272A4",
							},
						},
						-- spinners set below
						-- spinner_color = "#6272A4",
					},
					show_colors = true,
					show_loading = true,
				},
				-- "encoding",
				"filetype",
			},
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { {
				"filename",
				path = 1
			} },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {
			lualine_a = { "branch" },
			lualine_b = {
				{
					"tabs",
					tab_max_length = 60,
					mode = 2,
					path = 0,
					symbols = {
						modified = ''
					},
					fmt = function (name, context)
						local buflist = vim.fn.tabpagebuflist(context.tabnr)
						local winnr = vim.fn.tabpagewinnr(context.tabnr)
						local bufnr = buflist[winnr]
						local mod = vim.fn.getbufvar(bufnr, '&mod')

						return name .. (mod == 1 and ' ●' or '')
					end,
				}
			},
			-- lualine_x = {"windows"},
			lualine_z = {"hostname"}
		},
		winbar = {},
		inactive_winbar = {},
		extensions = { "nvim-tree", "nvim-dap-ui" },
	},
	config = function(_, opts)
		opts.sections.lualine_x[1].symbols.spinners = require("copilot-lualine.spinners").dots_pulse
		require("lualine").setup(opts)
	end,
}
