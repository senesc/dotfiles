local ls = require("luasnip")
local s = ls.snippet
-- local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
-- local t = ls.text_node
-- local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local events = require("luasnip.util.events")
-- local ai = require("luasnip.nodes.absolute_indexer")
-- local extras = require("luasnip.extras")
-- local l = extras.lambda
-- local rep = extras.rep
-- local p = extras.partial
-- local m = extras.match
-- local n = extras.nonempty
-- local dl = extras.dynamic_lambda
-- local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
-- local conds = require("luasnip.extras.expand_conditions")
-- local postfix = require("luasnip.extras.postfix").postfix
-- local types = require("luasnip.util.types")
-- local parse = require("luasnip.util.parser").parse_snippet
-- local ms = ls.multi_snippet

return {
	s({
		name = "Obsidian frontmatter",
		trig = "obs",
		snippetType = "snippet",
		-- only show on the first line
		-- condition = (vim.api.nvim_win_get_cursor(0)[1] == 1),
		-- showCondition = (vim.api.nvim_win_get_cursor(0)[1] == 1),
	}, {
		t({ "---", "id: " }),
		-- extra () below to only take the first return value from gsub
		i(1, (vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t:r"):gsub(" ", "_"))),
		t({ "", "aliases:" }),
		i(2, " []"),
		t({ "", "tags:" }),
		i(3, " []"),
		t({ "", "---", "", "# " }),
		i(0, vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t:r"))
	}, {

	}),
	s("trigger", {
		t({ "After expanding, the cursor is here ->" }), i(1),
		t({ "", "After jumping forward once, cursor is here ->" }), i(2),
		t({ "", "After jumping once more, the snippet is exited there ->" }), i(0),
	})
}
