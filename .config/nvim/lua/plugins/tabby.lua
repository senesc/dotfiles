return {
	"nanozuki/tabby.nvim",
	lazy = false,
	init = function(_)
		require("mappings").load_mappings("tabby")
	end,
	opts = {},
	config = function(_, opts)
		require("tabby").setup(opts)
		local theme = {
			fill = "TabLineFill",
			head = "TabLine",
			current_tab = "TabLineSel",
			tab = "TabLine",
			win = "TabLineSel",
			tail = "TabLine",
		}
		require("tabby.tabline").set(function(line)
			return {
				{
					{ "  ", hl = theme.head },
					line.sep("", theme.head, theme.fill),
				},
				line.tabs().foreach(function(tab)
					local hl = tab.is_current() and theme.current_tab or theme.tab
					return {
						line.sep("", hl, theme.fill),
						tab.is_current() and "" or "󰆣",
						tab.number(),
						tab.name(),
						line.sep("", hl, theme.fill),
						hl = hl,
						margin = " ",
					}
				end),
			}
		end)
	end,
}
