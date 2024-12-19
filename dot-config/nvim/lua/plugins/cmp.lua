return {
	"hrsh7th/nvim-cmp",
	event = { "BufEnter", "InsertEnter" },
	-- init = function()
	-- require("core.utils").lazy_load("nvim-cmp")
	-- end,
	dependencies = {
		"L3MON4D3/LuaSnip",
		"windwp/nvim-autopairs",

		-- cmp sources plugins
		{
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-omni",
			"copilot-cmp",
		},
	},
	opts = function()
		local cmp = require("cmp")

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
				completeopt = "menu,menuone,noinsert",
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
					max_width = 80,
				},
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},

			formatting = {
				-- default fields order i.e completion word + item.kind + item.kind icons
				fields = { "kind", "abbr", "menu" },
				expandable_indicator = true,

				format = function(_, item)
					local icons = require("core.icons").lspkind
					local icon = icons[item.kind] or ""

					-- icon = " " .. icon .. " "
					item.menu = "   (" .. item.kind .. ")"
					item.kind = icon

					return item
				end,
			},

			mapping = {
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-u>"] = cmp.mapping.scroll_docs(-6),
				["<C-d>"] = cmp.mapping.scroll_docs(6),
				["<C-Space>"] = cmp.mapping.complete(),
				["<Esc>"] = cmp.mapping.close(),
				["<S-CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
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
				-- { name = "nvim_lsp", option = { markdown_oxide = { keyword_pattern = [[\(\k\| \|\/\|#\)\+]]}} },
				{ name = "nvim_lsp" },
				{ name = "copilot" },
				{ name = "luasnip" },
				{ name = "nvim_lua" },
				{ name = "path" },
				{ name = "nvim_lsp_signature_help" },
				{ name = "buffer", max_item_count = 5 },
			},
			view = {
				docs = {
					auto_open = true,
				},
			},
		}

		return options
	end,
	config = function(_, opts)
		require("cmp").setup(opts)
	end,
}
