local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
	s({
		name = "if [ condition ]",
		trig = "if",
		desc = "if to check numbers with test",
	}, {
		t("if [ "),
		i(1),
		t({ " ]", "then", "" }),
		i(0),
		t({ "", "fi" }),
	}),
	s({
		name = "if [[ condition ]]",
		trig = "if",
		desc = "if to check for string equality",
	}, {
		t("if [[ "),
		i(1),
		t({ " ]]", "then", "\t" }),
		i(0),
		t({ "", "fi" }),
	}),
	s({
		name = "while",
		trig = "while",
		-- desc = ''
	}, {
		t("while "),
		i(1),
		t({ "", "do", "\t" }),
		i(0),
		t({ "", "done" }),
	}),
	s({
		name = "for",
		trig = "for",
		-- desc = ''
	}, {
		t("for "),
		i(1),
		t(" in "),
		i(2),
		t({ "", "do", "\t" }),
		i(0),
		t({ "", "done" }),
	}),
}
