local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
	s({
		name = "Equal",
		trig = ";eq",
		snippetType = "autosnippet",
		wordTrig = false,
		priority = 1,
	}, {
		t("="),
	}),
	s({
		name = "not equal",
		trig = ";neq",
		snippetType = "autosnippet",
		wordTrig = false,
		priority = 1,
	}, {
		t("!="),
	}),
	s({
		name = "Less than",
		trig = ";lt",
		snippetType = "autosnippet",
		wordTrig = false,
		priority = 1,
	}, {
		t("<"),
	}),
	s({
		name = "Greater than",
		trig = ";gt",
		snippetType = "autosnippet",
		wordTrig = false,
		priority = 1,
	}, {
		t(">"),
	}),
	s({
		name = "Less or equal",
		trig = ";le",
		snippetType = "autosnippet",
		wordTrig = false,
		priority = 1,
	}, {
		t("<="),
	}),
	s({
		name = "Greater or than",
		trig = ";ge",
		snippetType = "autosnippet",
		wordTrig = false,
		priority = 1,
	}, {
		t(">="),
	}),
	s({
		name = "left-right parenthesis",
		trig = "lrr",
		snippetType = "autosnippet",
		priority = 1,
	}, {
		t("("),
		i(1),
		t(")"),
		i(0),
	}),
	s({
		name = "left-right braces",
		trig = "lrb",
		snippetType = "autosnippet",
		priority = 1,
	}, {
		t("{"),
		i(1),
		t("}"),
		i(0),
	}),
}
