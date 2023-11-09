return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	init = function()
		require("core.utils").lazy_load("nvim-cmp")
	end,
	dependencies = {
		require("plugins.luasnip"),
		require("plugins.nvim-autopairs"),

		-- cmp sources plugins
		{
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-omni",
		},
	},

	opts = function()
		local cmp = require("cmp")

		local cmp_ui = {
			icons = true,
			lspkind_text = true,
			style = "atom_colored", -- default/flat_light/flat_dark/atom/atom_colored
			border_color = "grey_fg", -- only applicable for "default" style, use color names from base30 variables
			selected_item_bg = "simple", -- colored / simple
		}
		local cmp_style = cmp_ui.style

		local field_arrangement = {
			atom = { "kind", "abbr", "menu" },
			atom_colored = { "kind", "abbr", "menu" },
		}

		local formatting_style = {
			-- default fields order i.e completion word + item.kind + item.kind icons
			fields = field_arrangement[cmp_style] or { "abbr", "kind", "menu" },

			format = function(_, item)
				local icons = require("core.icons").lspkind
				local icon = (cmp_ui.icons and icons[item.kind]) or ""

				if cmp_style == "atom" or cmp_style == "atom_colored" then
					icon = " " .. icon .. " "
					item.menu = cmp_ui.lspkind_text and "   (" .. item.kind .. ")" or ""
					item.kind = icon
				else
					icon = cmp_ui.lspkind_text and (" " .. icon .. " ") or icon
					item.kind = string.format("%s %s", icon, cmp_ui.lspkind_text and item.kind or "")
				end

				return item
			end,
		}

		local function border(hl_name)
			return {
				{ "╭", hl_name },
				{ "─", hl_name },
				{ "╮", hl_name },
				{ "│", hl_name },
				{ "╯", hl_name },
				{ "─", hl_name },
				{ "╰", hl_name },
				{ "│", hl_name },
			}
		end

		local options = {
			completion = {
				completeopt = "menu,menuone",
			},

			window = {
				completion = cmp.config.window.bordered(),
				-- completion = {
				--   side_padding = (cmp_style ~= "atom" and cmp_style ~= "atom_colored") and 1 or 0,
				--   winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel",
				--   scrollbar = false,
				-- },
				documentation = {
					border = border("CmpDocBorder"),
					winhighlight = "Normal:CmpDoc",
					max_width = 40,
				},
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},

			formatting = formatting_style,

			mapping = {
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-d>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<Esc>"] = cmp.mapping.close(),
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				}),
				["<Tab>"] = cmp.mapping(function(fallback)
					if require("luasnip").expand_or_jumpable() then
						vim.fn.feedkeys(
							vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
							""
						)
					elseif cmp.visible() then
						cmp.select_next_item()
					else
						fallback()
					end
				end, {
					"i",
					"s",
				}),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if require("luasnip").jumpable(-1) then
						vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
					elseif cmp.visible() then
						cmp.select_prev_item()
					else
						fallback()
					end
				end, {
					"i",
					"s",
				}),
			},
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "nvim_lua" },
				{ name = "path" },
			},
		}

		if cmp_style ~= "atom" and cmp_style ~= "atom_colored" then
			options.window.completion.border = border("CmpBorder")
		end

		return options
	end,
	config = function(_, opts)
		require("cmp").setup(opts)
	end,
}
