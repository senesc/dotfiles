local ls = require("luasnip")
local s = ls.snippet
-- local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local events = require("luasnip.util.events")
-- local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
-- local l = extras.lambda
local rep = extras.rep
-- local p = extras.partial
-- local m = extras.match
-- local n = extras.nonempty
-- local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
-- local postfix = require("luasnip.extras.postfix").postfix
-- local types = require("luasnip.util.types")
-- local parse = require("luasnip.util.parser").parse_snippet
-- local ms = ls.multi_snippet

local in_math = function()
	return (vim.api.nvim_eval("vimtex#syntax#in_mathzone()") == 1)
end

return {
	s({
		name = "Spazi(o) topologici/o",
		trig = [[sp\. ?t(t|o?p?)\.]],
		-- accepts (with or without space) "sp. t.", "sp.tt." (for plural), "sp.top.", "sp. tp.".
		trigEngine = "ecma",
		condition = not in_math,
		snippetType = "autosnippet",
	}, {
		f(function(args, snip)
			local plural = (snip.captures[1] == "t")
			return "spazi" .. (plural and "" or "o") .. " topologic" .. (plural and "i" or "o")
		end),
	}),
}
