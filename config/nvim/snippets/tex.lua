local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
-- local events = require("luasnip.util.events")
-- local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
-- local l = extras.lambda
-- local rep = extras.rep
-- local p = extras.partial
-- local m = extras.match
-- local n = extras.nonempty
-- local dl = extras.dynamic_lambda
-- local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
-- local postfix = require("luasnip.extras.postfix").postfix
-- local types = require("luasnip.util.types")
-- local parse = require("luasnip.util.parser").parse_snippet
-- local ms = ls.multi_snippet

local in_math = function()
	return (vim.api.nvim_eval("vimtex#syntax#in_mathzone()") == 1)
end
local not_in_math = function()
	return not in_math()
end

local function gen_match(no)
	return function(args, parent, user_args)
		return parent.captures[no]
	end
end
local function visual_cbrace_spaceoptional(_, parent)
	return sn(nil, { i(1, parent.env.TM_SELECTED_TEXT), t(next(parent.env.TM_SELECTED_TEXT) and "}" or "} ") })
end
local function input_visual(_, parent)
	return sn(nil, { i(1, parent.env.TM_SELECTED_TEXT) })
end

-- List of functions that are gonna be preceded by a backslash that require no parenthesis if the argument is simple enough
-- local prepend_notmath = "()"
local prepend_inmath =
	"(deg|sum|mis|ell|star|perp|max|min|inf|sup|arcsin|sin|arccos|arctan|cos|arccot|arccsc|arcsec|ln|tan|log|exp|cot|csc|ldots|cdots|vdots|ddots|Hom|End|Aut|rk|tr|sgn|det)"
local sup_sub_inside_match = "[a-zA-Z0-9\\*\\\\\\^\\_\\-\\+]*?"

-- Rules for creating templates:
-- - do not disrupt spacebar typing (do not add spaces randomly) (generally add them if i press tab to move)
-- - make spacing nice
-- - avoid at all cost conflict with things typed frequently
-- - don't trigger when manually correcting an already expanded snippet (e.g., \circ shouldn't trigger as circ)

-- Actual snippets
return {

	-- Document structure

	s({
		name = "Latex base template",
		trig = "template",
		snippetType = "snippet",
		condition = not in_math,
		show_condition = not in_math,
	}, {
		t({
			"\\documentclass[12pt, a4paper]{article}",
			"\\input{../.config/preamble.tex}",
			"\\title{",
		}),
		i(1),
		t({ "}", "", "" }),
		t({
			"\\begin{document}",
			"\\maketitle",
			"\\listoftheorems[title=Indice, ignoreall, numwidth=4em, show={theorem,corollary,lemma,prop,definition}]",
			"",
			"",
		}),
		i(0),
		t({ "", "", "\\end{document}", "% refcounter=1", "% vim: set ft=tex" }),
	}),
	s({ name = "begin{}/end{}", trig = "beg", snippetType = "autosnippet", condition = conds.line_begin }, {
		t("\\begin{"),
		i(1),
		t("}"),
		extras.nonempty(2, "[", ""),
		i(2),
		extras.nonempty(2, "]", ""),
		t({ "", "\t" }),
		d(3, input_visual),
		t({ "", "\\end{" }),
		extras.rep(1),
		t({ "}", "" }),
		i(0),
	}),
	s({ name = "proof", trig = "proof", snippetType = "autosnippet", condition = conds.line_begin }, {
		t({ "\\begin{proof} ", "" }),
		c(1, {
			sn(nil, { t("\t"), r(1, "first_part") }),
			sn(nil, {
				t({ "\t\\begin{itemize}", "\t\t\\item[$ \\implies $] " }),
				r(1, "first_part"),
				t({ "", "\t\t\\item[$ \\impliedby $] " }),
				r(2, "second_part"),
				t({ "", "\t\\end{itemize}" }),
			}),
			sn(nil, {
				t({ "\t\\begin{itemize}", "\t\t\\item[$ \\subseteq $] " }),
				r(1, "first_part"),
				t({ "", "\t\t\\item[$ \\supseteq $] " }),
				r(2, "second_part"),
				t({ "", "\t\\end{itemize}" }),
			}),
			sn(nil, {
				t({ "\t\\begin{itemize}", "\t\t\\item[$ 1.\\!\\Rightarrow\\! 2. $] " }),
				r(1, "first_part"),
				t({ "", "\t\t\\item[$ 2.\\!\\Rightarrow\\! 3. $] " }),
				r(2, "second_part"),
				t({ "", "\t\t\\item[$ 3.\\!\\Rightarrow\\! 1. $] " }),
				r(3, "third_part"),
				t({ "", "\t\\end{itemize}" }),
			}),
		}),
		t({ "", "\\end{proof} " }),
	}, { stored = { ["first_part"] = i(1), ["second_part"] = i(1), ["third_part"] = i(1) } }),
	s({ name = "ldots", trig = "...", snippetType = "autosnippet" }, { t("\\ldots") }),
	s({ name = "\\item", trig = "\titm", snippetType = "autosnippet" }, {
		t("\\item"),
	}), --TODO make it work only with condition inside env enumerate/itemize
	s({ name = "section", trig = "^%s*sect", trigEngine = "pattern", snippetType = "autosnippet" }, {
		t("\\section{"),
		i(1),
		t({ "}", "" }),
		i(0),
	}),
	s({ name = "subsection", trig = "^%s*ssect", trigEngine = "pattern", snippetType = "autosnippet" }, {
		t("\\subsection{"),
		i(1),
		t({ "}", "" }),
		i(0),
	}),
	s({ name = "subsubsection", trig = "^%s*sssect", trigEngine = "pattern", snippetType = "autosnippet" }, {
		t("\\subsubsection{"),
		i(1),
		t({ "}", "" }),
		i(0),
	}),
	s({ name = "itemize", trig = "item", snippetType = "autosnippet", condition = conds.line_begin }, {
		t({ "\\begin{itemize}", "\t\\item " }),
		i(1),
		t({ "", "\\end{itemize}" }),
	}),
	s({ name = "enumerate", trig = "enum", snippetType = "autosnippet", condition = conds.line_begin }, {
		t({ "\\begin{enumerate}", "\t\\item " }),
		i(1),
		t({ "", "\\end{enumerate}" }),
	}),
	s({ name = "\\quad", trig = "spc", wordTrig = true, condition = in_math, snippetType = "autosnippet" }, {
		t("\\quad"),
	}),
	s({ name = "\\qquad", trig = "sspc", wordTrig = true, condition = in_math, snippetType = "autosnippet" }, {
		t("\\qquad"),
	}),
	s(
		{ name = "\\( \\)", trig = "mk", snippetType = "autosnippet", condition = not_in_math },
		{ t("\\( "), i(1), t(" \\)") }
	),
	s(
		{ name = "display math", trig = "dm", wordTrig = true, snippetType = "autosnippet", condition = not_in_math },
		{ t({ "", "\\[ " }), i(1), t(" \\]") }
	),
	s(
		{ name = "gather*", trig = "gath", trigEngine = "pattern", snippetType = "autosnippet" },
		{ t({ "\\begin{gather*}", "\t" }), i(1), t({ "", "\\end{gather*}", "" }), i(0) }
	),
	s(
		{ name = "align*", trig = "(?<=^\\s*)ali", trigEngine = "ecma", snippetType = "autosnippet" },
		{ t({ "\\begin{align*}", "\t" }), i(1), t({ "", "\\end{align*}", "" }), i(0) }
	),
	s({ name = "cases", trig = "case", trigEngine = "pattern", condition = in_math, snippetType = "autosnippet" }, {
		t("\\begin{cases} "),
		d(1, function(_, parent)
			return sn(nil, { i(1, parent.env.TM_SELECTED_TEXT) })
		end),
		t(" \\end{cases}"),
		i(0),
	}),
	s({ name = "text", trig = "tx", snippetType = "autosnippet", condition = in_math }, {
		t("\\text{"),
		d(1, visual_cbrace_spaceoptional),
		i(0),
	}),
	s({
		name = "short intertext",
		trig = "^(%s*)shit",
		trigEngine = "pattern",
		condition = in_math,
		snippetType = "autosnippet",
	}, {
		f(function(_, snip)
			return snip.captures[1]
		end),
		t("\\shortintertext{"),
		i(1),
		t({ "}", "" }),
		f(gen_match(1)),
		i(0),
	}),

	s({
		name = "bold text",
		trig = "**",
		snippetType = "autosnippet",
		wordTrig = true,
		condition = function()
			return not in_math()
		end,
	}, {
		t("\\textbf{"),
		d(1, visual_cbrace_spaceoptional),
		i(0),
	}),
	s({ name = "tag", trig = "tag", condition = in_math, wordTrig = true, snippetType = "autosnippet" }, {
		d(1, function(args, parent, old_state, user_args)
			local lineno = vim.fn.search("^% refcounter=\\d\\+", "nw")
			if lineno == 0 then
				print("No refcounter string! Adding one at top")
				vim.fn.append(1, "% refcounter=1")
				lineno = 2
			end
			local line = vim.fn.getline(lineno)
			local curref = tonumber(line:match("%d+"))
			vim.fn.setline(lineno, { line:gsub("%d+", tostring(curref + 1)) })
			vim.fn.setreg(vim.v.register, "\\autoref{" .. tostring(curref) .. "}")
			print("Autoref saved to register " .. vim.v.register)
			return sn(nil, { t("\\label{" .. tostring(curref) .. "} \\tag{"), i(1, tostring(curref)), t("}") })
		end),
	}),

	-- Maths parenthesis
	s({
		name = "left-right round",
		trig = "lrr",
		wordTrig = false,
		condition = in_math,
		snippetType = "autosnippet",
	}, { t("\\left( "), d(1, input_visual), t(" \\right)"), i(0) }),
	s({
		name = "left-right square",
		trig = "lrs",
		wordTrig = false,
		condition = in_math,
		snippetType = "autosnippet",
	}, { t("\\left[ "), d(1, input_visual), t(" \\right]"), i(0) }),
	s({
		name = "left-right braces",
		trig = "lrb",
		wordTrig = false,
		condition = in_math,
		snippetType = "autosnippet",
	}, { t("\\left\\{ "), d(1, input_visual), t(" \\right\\}"), i(0) }),
	s({
		name = "left-right pipe",
		trig = "lrp",
		wordTrig = true,
		condition = in_math,
		snippetType = "autosnippet",
	}, { t("\\left| "), d(1, input_visual), t(" \\right|"), i(0) }),
	s({
		name = "left-right angular",
		trig = "lra",
		wordTrig = false,
		condition = in_math,
		snippetType = "autosnippet",
	}, { t("\\left< "), d(1, input_visual), t(" \\right>"), i(0) }),
	s({
		name = "left-right norm",
		trig = "lrn",
		wordTrig = false,
		condition = in_math,
		snippetType = "autosnippet",
	}, { t("\\left\\Vert "), d(1, input_visual), t(" \\right\\Vert"), i(0) }),

	s({
		name = "ceiling",
		trig = "ceil",
		condition = in_math,
		show_condition = in_math,
		wordTrig = true,
	}, {
		t("\\left\\lceil "),
		i(1),
		t("\\right\\rceil "),
		i(0),
	}),
	s({
		name = "floor",
		trig = "floor",
		condition = in_math,
		show_condition = in_math,
		wordTrig = true,
	}, {
		t("\\left\\lfloor "),
		i(1),
		t("\\right\\rfloor "),
		i(0),
	}),

	-- Decorators
	s({
		name = "superscript",
		trig = "%s*td",
		trigEngine = "pattern",
		condition = in_math,
		snippetType = "autosnippet",
		wordTrig = false,
	}, { t("^{"), i(1), t("} "), i(0) }),
	s({ --TODO is this good enough?
		name = "subscript",
		trig = "%s*con",
		trigEngine = "pattern",
		condition = in_math,
		snippetType = "autosnippet",
		wordTrig = false,
	}, { t("_{"), i(1), t("}"), i(0) }),
	s({
		name = "subscript",
		trig = "__",
		trigEngine = "pattern",
		condition = in_math,
		snippetType = "autosnippet",
		wordTrig = false,
	}, { t("_{"), i(1), t("}"), i(0) }),
	s( -- TODO consider changing this to sstack
		{ name = "substack", trig = "sst", condition = in_math, snippetType = "autosnippet", wordTrig = true },
		{ t("\\substack{ "), d(1, input_visual), t(" }"), i(0) }
	),
	s({
		name = "repetition subscript command (w/ arg only)",
		trig = "(\\\\[a-zA-Z]+(?:{[a-zA-Z0-9]+})?)([a-z])\\3", --TODO consider adding ^{td} option, and without argument flavor
		trigEngine = "ecma",
		condition = in_math,
		snippetType = "autosnippet",
		priority = 999,
	}, { f(gen_match(1)), t("_{"), f(gen_match(2)), t("}") }),
	s({
		name = "repetition subscript single letter",
		trig = "([a-zA-Z01](?: ?\\^{" .. sup_sub_inside_match .. "})?)([a-zA-Z])\\2",
		trigEngine = "ecma",
		condition = in_math,
		snippetType = "autosnippet",
		priority = 999,
	}, { f(gen_match(1)), t("_{"), f(gen_match(2)), t("}") }),
	s({
		name = "number subscript",
		trig = "((?:\\\\[a-zA-Z]*(?:{"
			.. sup_sub_inside_match
			.. "})?|[a-zA-Z])(?: ?\\^{"
			.. sup_sub_inside_match
			.. "})?)([0-9])",
		trigEngine = "ecma",
		condition = in_math,
		snippetType = "autosnippet",
		wordTrig = false,
	}, { f(gen_match(1)), t("_{"), f(gen_match(2)), t("}") }),
	s({
		name = "Xbar",
		trig = "(%a)bar",
		trigEngine = "pattern",
		condition = in_math,
		snippetType = "autosnippet",
	}, { t("\\overline{"), f(gen_match(1)), t("}") }),
	s(
		{ name = "bar", trig = "bar", wordTrig = true, condition = in_math, snippetType = "autosnippet" },
		{ t("\\overline{"), d(1, visual_cbrace_spaceoptional) }
	),
	s({
		name = "Xtilde",
		trig = "(\\\\[a-zA-Z]*(?:{[a-zA-Z0-9\\*\\\\\\^\\_\\-\\+]*})? ?|[a-zA-Z0-9])tld",
		trigEngine = "ecma",
		condition = in_math,
		snippetType = "autosnippet",
	}, { t("\\widetilde{"), f(gen_match(1)), t("}") }),
	s(
		{ name = "tld", trig = "tld", wordTrig = true, condition = in_math, snippetType = "autosnippet" },
		{ t("\\widetilde{"), d(1, visual_cbrace_spaceoptional) }
	),
	s({ --TODO consider adding command capturing, e.g. \udl{\sin}
		name = "Xunderlined",
		trig = "(%a)udl",
		trigEngine = "pattern",
		condition = in_math,
		snippetType = "autosnippet",
	}, { t("\\underline{"), f(gen_match(1)), t("}") }),
	s(
		{ name = "udl", trig = "udl", wordTrig = true, condition = in_math, snippetType = "autosnippet" },
		{ t("\\underline{"), d(1, visual_cbrace_spaceoptional) }
	),
	s({
		name = "Xcal",
		trig = "(%a)cal",
		trigEngine = "pattern",
		condition = in_math,
		snippetType = "autosnippet",
	}, { t("\\mathcal{"), f(gen_match(1)), t("}") }),
	s(
		{ name = "cal", trig = "cal", wordTrig = true, condition = in_math, snippetType = "autosnippet" },
		{ t("\\mathcal{"), d(1, visual_cbrace_spaceoptional) }
	),
	s({
		name = "mathbb inline",
		trig = "([A-Z])\\1",
		trigEngine = "ecma",
		wordTrig = true,
		snippetType = "autosnippet",
		condition = in_math,
		priority = 998,
	}, { t("\\mathbb{"), f(gen_match(1)), t("}") }),
	s({
		name = "Xfrk",
		trig = "(%a)frk",
		trigEngine = "pattern",
		condition = in_math,
		snippetType = "autosnippet",
	}, { t("\\mathfrak{"), f(gen_match(1)), t("}") }),
	s(
		{ name = "frk", trig = "frk", wordTrig = true, condition = in_math, snippetType = "autosnippet" },
		{ t("\\mathfrak{"), d(1, visual_cbrace_spaceoptional) }
	),
	s({
		name = "\\circ",
		trig = "(?<!\\\\)circ",
		trigEngine = "ecma",
		condition = in_math,
		snippetType = "autosnippet",
	}, { t("\\circ") }),
	s({ name = "eval", trig = "eval", wordTrig = false, snippetType = "autosnippet", condition = in_math }, {
		t("\\Big|"),
		t("_{"),
		i(1, "-\\infty"),
		t("}"),
		extras.nonempty(2, "^{", ""),
		i(2, "+\\infty"),
		extras.nonempty(2, "}", ""),
	}),
	s({ name = "bold math", trig = "**", wordTrig = true, snippetType = "autosnippet", condition = in_math }, {
		t("\\bm{"),
		d(1, visual_cbrace_spaceoptional),
	}),
	s({
		name = "bold math inline",
		trig = "(\\\\[a-zA-Z]+(?:{[a-zA-Z]*})?|[a-zA-Z])\\*\\*",
		trigEngine = "ecma",
		wordTrig = false,
		snippetType = "autosnippet",
		condition = in_math,
	}, {
		t("\\bm{"),
		f(gen_match(1)),
		t("}"),
	}),

	-- Quantificatori
	s(
		{ name = "∀", trig = "AA", wordTrig = true, condition = in_math, snippetType = "autosnippet" },
		{ t("\\forall") }
	),
	s(
		{ name = "∃", trig = "EE", wordTrig = true, condition = in_math, snippetType = "autosnippet" },
		{ t("\\exists") }
	),

	-- Connettivi logici
	s(
		{ name = "or", trig = "jor", wordTrig = true, condition = in_math, snippetType = "autosnippet" },
		{ t("\\vee"), snippetType = "autosnippet" }
	),
	s(
		{ name = "and", trig = "jand", wordTrig = true, condition = in_math, snippetType = "autosnippet" },
		{ t("\\wedge") }
	),
	s({
		name = "=>",
		trig = "(?<!\\\\)impl",
		trigEngine = "ecma",
		wordTrig = true,
		condition = in_math,
		snippetType = "autosnippet",
	}, { t("\\implies") }),
	s({
		name = "therefore",
		trig = "thf",
		wordTrig = true,
		condition = in_math,
		snippetType = "autosnippet",
	}, { t("\\therefore") }),
	s({
		name = "(?<!\\\\)iff",
		trig = "iff",
		trigEngine = "ecma",
		wordTrig = true,
		condition = in_math,
		snippetType = "autosnippet",
	}, { t("\\iff") }),

	-- Relations
	s({ name = "=", trig = ";eq", snippetType = "autosnippet", condition = in_math }, { t("=") }),
	s({ name = "=", trig = "e;q", snippetType = "autosnippet", condition = in_math }, { t("=") }),
	s({ name = ">", trig = ";gt", snippetType = "autosnippet", condition = in_math }, { t(">") }),
	s({ name = "<", trig = ";lt", snippetType = "autosnippet", condition = in_math }, { t("<") }),
	s({ name = "<=", trig = ";le", snippetType = "autosnippet", condition = in_math }, { t("\\leq") }),
	s({ name = ">=", trig = ";ge", snippetType = "autosnippet", condition = in_math }, { t("\\geq") }),
	s(
		{ name = "triangle left equal", trig = ";tle", snippetType = "autosnippet", condition = in_math },
		{ t("\\trianglelefteq") }
	),
	s(
		{ name = "triangle right equal", trig = ";tge", snippetType = "autosnippet", condition = in_math },
		{ t("\\trianglerighteq") }
	),
	s({ name = ">>", trig = ";gg", snippetType = "autosnippet", condition = in_math }, { t("\\gg") }),
	s({ name = "<<", trig = ";ll", snippetType = "autosnippet", condition = in_math }, { t("\\ll") }),
	s({ name = ":=", trig = ":=", snippetType = "autosnippet", condition = in_math }, { t("\\coloneqq") }),
	s({ name = "=:", trig = "=:", snippetType = "autosnippet", condition = in_math }, { t("\\eqqcolon") }),
	s({ name = "≠", trig = ";neq", snippetType = "autosnippet", condition = in_math }, { t("\\neq") }),
	s({
		name = "≅",
		trig = "iso",
		condition = in_math,
		snippetType = "autosnippet",
	}, { t("\\cong") }),
	s({
		name = "≡",
		trig = "(?<!\\\\)equiv",
		trigEngine = "ecma",
		condition = in_math,
		snippetType = "autosnippet",
	}, { t("\\equiv") }),
	s(
		{ name = "subset or equal", trig = ";se", wordTrig = true, snippetType = "autosnippet", condition = in_math },
		{ t("\\subseteq") }
	),
	s(
		{ name = "subset", trig = ";ss", wordTrig = true, snippetType = "autosnippet", condition = in_math },
		{ t("\\subset") }
	),
	s(
		{ name = "superset or equal", trig = ";Se", wordTrig = true, snippetType = "autosnippet", condition = in_math },
		{ t("\\supseteq") }
	),
	s(
		{ name = "superset", trig = ";Ss", wordTrig = true, snippetType = "autosnippet", condition = in_math },
		{ t("\\supset") }
	),
	s({ name = "∈", trig = "inn", condition = in_math, wordTrig = true, snippetType = "autosnippet" }, { t("\\in") }),
	s({ name = "∋", trig = "nii", condition = in_math, wordTrig = true, snippetType = "autosnippet" }, { t("\\ni") }),
	s({
		name = "∉",
		trig = "(?<!\\\\)notin",
		trigEngine = "ecma",
		condition = in_math,
		wordTrig = true,
		snippetType = "autosnippet",
	}, { t("\\notin") }),
	s({
		name = "similar, ~",
		trig = "(?<!\\\\)sim",
		trigEngine = "ecma",
		condition = in_math,
		wordTrig = true,
		snippetType = "autosnippet",
	}, { t("\\sim") }),
	s({ name = "overbrace", trig = "ovb", condition = in_math, wordTrig = true, snippetType = "autosnippet" }, {
		c(1, {
			d(nil, function(_, parent)
				return sn(nil, {
					t("\\overbrace{ "),
					r(1, "first_arg"),
					t(" }^{ "),
					r(2, "note_arg"),
					t(not next(parent.env.TM_SELECTED_TEXT) and " }" or " } "),
				})
			end),
			d(nil, function(_, parent)
				return sn(nil, {
					t("\\overbrace{ "),
					r(1, "first_arg"),
					t(" }^{\\text{"),
					r(2, "note_arg"),
					t(not next(parent.env.TM_SELECTED_TEXT) and "}}" or "}} "),
				})
			end),
		}),
	}, { stored = { ["first_arg"] = i(1, "math stuff..."), ["note_arg"] = i(1, "note") } }),
	-- TODO: add VISUAL
	s({ name = "overset", trig = "ovs", wordTrig = true, condition = in_math, snippetType = "autosnippet" }, {
		t("\\overset{\\text{"),
		i(1, "over"),
		t("}}{"),
		i(2),
		t("} "),
		i(0),
	}),
	s({ name = "underbrace", trig = "udb", condition = in_math, wordTrig = true, snippetType = "autosnippet" }, {
		c(1, {
			d(nil, function(_, parent)
				return sn(nil, {
					t("\\underbrace{ "),
					r(1, "first_arg"),
					t(" }_{ "),
					r(2, "note_arg"),
					t(not next(parent.env.TM_SELECTED_TEXT) and " }" or " } "),
				})
			end),
			d(nil, function(_, parent)
				return sn(nil, {
					t("\\underbrace{ "),
					r(1, "first_arg"),
					t(" }_{\\text{"),
					r(2, "note_arg"),
					t(not next(parent.env.TM_SELECTED_TEXT) and "}}" or "}} "),
				})
			end),
		}),
	}, { stored = { ["first_arg"] = i(1, "math stuff..."), ["note_arg"] = i(1, "note") } }),

	-- Altro
	s(
		{ name = "->", trig = "jot", wordTrig = true, condition = in_math, snippetType = "autosnippet" },
		{ t("\\to"), snippetType = "autosnippet" }
	),
	s(
		{ name = "double ->", trig = "jdra", wordTrig = true, condition = in_math, snippetType = "autosnippet" },
		{ t("\\rightrightarrows"), snippetType = "autosnippet" }
	),
	s(
		{ name = "|->", trig = "jmps", wordTrig = true, condition = in_math, snippetType = "autosnippet" },
		{ t("\\mapsto"), snippetType = "autosnippet" }
	),

	-- Operazioni
	s({ name = "*", trig = "jt", condition = in_math, snippetType = "autosnippet" }, { t("\\cdot") }),
	s({
		name = "squared",
		trig = "%s*sr",
		trigEngine = "pattern",
		condition = in_math,
		snippetType = "autosnippet",
		wordTrig = false,
	}, { t("^{2}") }),
	s({
		name = "starred",
		trig = "%s*str",
		trigEngine = "pattern",
		condition = in_math,
		snippetType = "autosnippet",
		wordTrig = false,
	}, { t("^{*}") }),
	s({
		name = "cubed",
		trig = "%s*cb",
		trigEngine = "pattern",
		condition = in_math,
		snippetType = "autosnippet",
		wordTrig = false,
	}, { t("^{3}") }),
	s(
		{ name = "square root", trig = "sqrt", condition = in_math, snippetType = "autosnippet", wordTrig = true },
		{ t("\\sqrt{ "), i(1), t(" } "), i(0) }
	),
	s(
		{ name = "nth root", trig = "nrt", condition = in_math, snippetType = "autosnippet", wordTrig = true },
		{ t("\\sqrt["), i(1), t("]{ "), i(2), t(" } "), i(0) }
	),
	s({
		name = "inverse",
		trig = "%s*inv",
		trigEngine = "pattern",
		condition = in_math,
		snippetType = "autosnippet",
		wordTrig = false,
	}, { t("^{-1}") }),
	s(
		{ name = "x times", trig = "xx", condition = in_math, snippetType = "autosnippet", wordTrig = true },
		{ t("\\times") }
	),
	s(
		{ name = "fraction", trig = "//", condition = in_math, snippetType = "autosnippet" },
		{ t("\\frac{ "), d(1, input_visual), t(" }{ "), i(2), t(" } "), i(0) }
	),
	s(
		{ name = "fraction", trig = "//", trigEngine = "ecma", condition = in_math, snippetType = "autosnippet" },
		{ t("\\frac{ "), d(1, input_visual), t(" }{ "), i(2), t(" } "), i(0) }
	),
	s(
		{ name = "fraction inverse visual", trig = "/\\", condition = in_math, snippetType = "autosnippet" },
		{ t("\\frac{ "), i(1), t(" }{ "), d(2, input_visual), t(" } "), i(0) }
	),
	s({ name = "cUp", trig = "Uu", wordTrig = true, snippetType = "autosnippet", condition = in_math }, { t("\\cup") }),
	s({ name = "cAp", trig = "Nn", wordTrig = true, snippetType = "autosnippet", condition = in_math }, { t("\\cap") }),
	s(
		{ name = "big cAp", trig = "nnn", wordTrig = true, condition = in_math, snippetType = "autosnippet" },
		{ t("\\bigcap_{"), i(1, "i \\in I"), t("} ") }
	),
	s( --TODO cycle between normal and substack
		{ name = "big cUp", trig = "uuu", wordTrig = true, condition = in_math, snippetType = "autosnippet" },
		{ t("\\bigcup_{"), i(1, "i \\in I"), t("} ") }
	),
	s(
		{ name = "set minus", trig = ";sm", wordTrig = true, snippetType = "autosnippet", condition = in_math },
		{ t("\\smallsetminus") }
	),
	s({ name = "complement", trig = ".cp", wordTrig = false, snippetType = "autosnippet", condition = in_math }, {
		t("^{\\complement}"),
	}),
	s({
		name = "transpose",
		trig = ".tr",
		wordTrig = false,
		priority = 1001,
		snippetType = "autosnippet",
		condition = in_math,
	}, {
		t("^{\\intercal}"),
	}),
	s({ name = "O plus operator", trig = "jop", wordTrig = true, snippetType = "autosnippet", condition = in_math }, {
		t("\\oplus"),
	}),
	s({ name = "O times operator", trig = "jox", wordTrig = true, snippetType = "autosnippet", condition = in_math }, {
		t("\\otimes"),
	}),
	s({ name = "nabla", trig = "nbl", wordTrig = true, snippetType = "autosnippet", condition = in_math }, {
		t("\\nabla"),
	}),
	s({ name = "plus or minus", trig = "jpm", wordTrig = true, snippetType = "autosnippet", condition = in_math }, {
		t("\\pm"),
	}),

	-- Funzioni
	s({
		name = "function manual expand",
		trig = "(\\\\[a-zA-Z]+(?:{[a-zA-Z]*})?'?|[a-zA-Z]'?) ?([\\^_]{"
			.. sup_sub_inside_match
			.. "})? ?([\\^_]{"
			.. sup_sub_inside_match
			.. "})?('*)F",
		trigEngine = "ecma",
		wordTrig = true,
		condition = in_math,
	}, {
		f(gen_match(1)),
		f(gen_match(2)),
		f(gen_match(3)),
		f(gen_match(4)),
		t("\\left( "),
		i(1),
		t(" \\right) "),
		i(0),
	}),
	s({
		name = "function auto expand",
		trig = "(\\\\[a-zA-Z]+(?:{[a-zA-Z]*})?'?|[a-zA-Z]'?) ?([\\^_]{"
			.. sup_sub_inside_match
			.. "})? ?([\\^_]{"
			.. sup_sub_inside_match
			.. "})?('*)F([a-zA-Z0-9])",
		trigEngine = "ecma",
		snippetType = "autosnippet",
		wordTrig = true,
		condition = in_math,
		show_condition = in_math,
	}, {
		f(gen_match(1)),
		f(gen_match(2)),
		f(gen_match(3)),
		f(gen_match(4)),
		t("\\left( "),
		f(gen_match(5)),
		t(" \\right) "),
		i(0),
	}),
	s({
		name = "prepend slash in_math",
		trig = "(?<!\\\\)" .. prepend_inmath,
		snippetType = "autosnippet",
		trigEngine = "ecma",
		condition = in_math,
		priority = 1001,
	}, {
		t("\\"),
		f(gen_match(1)),
	}),
	-- s({
	-- 	name = "prepend slash not in_math",
	-- 	trig = "(?<!\\\\)" .. prepend_notmath,
	-- 	snippetType = "autosnippet",
	-- 	trigEngine = "ecma",
	-- }, {
	-- 	t("\\"),
	-- 	f(gen_match(1)),
	-- }),

	-- Calculus
	s(
		{ name = "limit", trig = "lim", condition = in_math, wordTrig = true },
		{ t("\\lim_{"), i(1, "x \\to x_{0}"), t("} "), i(0) }
	),
	s({
		name = "integral",
		trig = "(lu|d?)(i{1,3}nt)",
		trigEngine = "ecma",
		docstring = "(definite) single/double/triple integral",
		condition = in_math,
		snippetType = "autosnippet",
		wordTrig = true,
	}, {
		t("\\"),
		f(gen_match(2)),
		d(1, function(args, parent)
			local nodes = { t("") }
			if parent.captures[1] == "lu" then
				nodes = {
					t("_{ "),
					i(1, "-\\infty"),
					t(" }^{ "),
					i(2, "+\\infty"),
					t(" }"),
				}
			elseif parent.captures[1] == "d" then
				nodes = {
					t("_{ "),
					i(1, "\\Omega"),
					t(" }"),
				}
			end
			return sn(nil, nodes)
		end),
		t(" "),
	}),
	-- s({trig = 'd([a-zA-Z])/', priority = 1001, trigEngine = 'ecma', wordTrig = true, }),
	s(
		{ trig = "odv", snippetType = "autosnippet", wordTrig = true, condition = in_math },
		{ t("\\odv{ "), i(1), t(" }{ "), i(2), t(" }") }
	),
	s(
		{ trig = "pdv", snippetType = "autosnippet", wordTrig = true, condition = in_math },
		{ t("\\pdv{ "), i(1), t(" }{ "), i(2), t(" }") }
	),

	s({
		name = "n,nmat",
		trig = "(%d+),(%d+)([pbBvV])mat",
		trigEngine = "pattern",
		snippetType = "autosnippet",
		condition = in_math,
		wordTrig = true,
	}, {
		d(1, function(_, parent)
			local nodes = {}
			table.insert(nodes, t({ "\\begin{" .. parent.captures[3] .. "matrix}" }))

			local height = tonumber(parent.captures[1])
			local width = tonumber(parent.captures[2])
			for k = 1, height do
				table.insert(nodes, t({ "", "\t" }))
				for j = 1, width do
					table.insert(nodes, i(j + (k - 1) * width))
					table.insert(nodes, t(" & "))
				end
				table.remove(nodes)
				table.insert(nodes, t(" \\\\"))
			end

			table.insert(nodes, t({ "", "\\end{" .. parent.captures[3] .. "matrix}" }))
			return sn(1, nodes)
		end),
	}),

	-- Loops
	-- TODO add visual to the following two
	s(
		{ name = "Sum from i to n", trig = "ssum", priority = 1001, condition = in_math, snippetType = "autosnippet" },
		{ t("\\sum_{"), i(1, "i = 1"), t("}^{"), i(2, "n"), t("} "), i(0) }
	),
	s(
		{ name = "Prod from i to n", trig = "pprod", condition = in_math, snippetType = "autosnippet" },
		{ t("\\prod_{"), i(1, "i = 1"), t("}^{"), i(2, "n"), t("} "), i(0) }
	),
	s(
		{ name = "bigcAp", trig = "nnn", wordTrig = true, condition = in_math, snippetType = "autosnippet" },
		{ t("\\bigcap_{ "), i(1, "i \\in I"), t(" } "), i(0) }
	), --TODO add choice_node with different models
	s(
		{ name = "bigcUp", trig = "uuu", wordTrig = true, condition = in_math, snippetType = "autosnippet" },
		{ t("\\bigcup_{ "), i(1, "i \\in I"), t(" } "), i(0) }
	), --TODO add choice_node with different models

	-- Symbols
	s(
		{ name = "infinity symbol", trig = "unl", snippetType = "autosnippet", condition = in_math, wordTrig = true },
		{ t("\\infty") }
	),
	s({
		name = "empty set",
		trig = "OO",
		snippetType = "autosnippet",
		condition = in_math,
		wordTrig = true,
	}, { t("\\O") }),
	s(
		{ name = "parallel", trig = "parall", wordTrig = true, snippetType = "autosnippet", condition = in_math },
		{ t("\\parallel") }
	),

	-- Greek alphabet
	s(
		{ name = "alpha", trig = "alp", snippetType = "autosnippet", condition = in_math, wordTrig = true },
		{ t("\\alpha") }
	),
	s(
		{ name = "beta", trig = "bet", snippetType = "autosnippet", condition = in_math, wordTrig = true },
		{ t("\\beta") }
	),
	s(
		{ name = "chi", trig = "chi", snippetType = "autosnippet", condition = in_math, wordTrig = true },
		{ t("\\chi") }
	),
	s(
		{ name = "delta", trig = "dlt", snippetType = "autosnippet", condition = in_math, wordTrig = true },
		{ t("\\delta") }
	),
	s(
		{ name = "epsilon", trig = "eps", snippetType = "autosnippet", condition = in_math, wordTrig = true },
		{ t("\\epsilon") }
	),
	s(
		{ name = "eta", trig = "eta", snippetType = "autosnippet", condition = in_math, wordTrig = true },
		{ t("\\eta") }
	),
	s(
		{ name = "gamma", trig = "gma", snippetType = "autosnippet", condition = in_math, wordTrig = true },
		{ t("\\gamma") }
	),
	-- s({ name = "iota", trig = "iot", snippetType = "autosnippet", condition = in_math }, { t("\\iota") , wordTrig = true}),
	s(
		{ name = "kappa", trig = "kpa", snippetType = "autosnippet", condition = in_math, wordTrig = true },
		{ t("\\kappa") }
	),
	s(
		{ name = "lambda", trig = "lam", snippetType = "autosnippet", condition = in_math, wordTrig = true },
		{ t("\\lambda") }
	),
	s({ name = "mu", trig = "mmu", snippetType = "autosnippet", condition = in_math, wordTrig = true }, { t("\\mu") }),
	s({ name = "nu", trig = "nnu", snippetType = "autosnippet", condition = in_math, wordTrig = true }, { t("\\nu") }),
	s(
		{ name = "omega", trig = "omg", snippetType = "autosnippet", condition = in_math, wordTrig = true },
		{ t("\\omega") }
	),
	s({ name = "pi", trig = "ppi", snippetType = "autosnippet", condition = in_math, wordTrig = true }, { t("\\pi") }),
	s(
		{ name = "psi", trig = "psi", snippetType = "autosnippet", condition = in_math, wordTrig = true },
		{ t("\\psi") }
	),
	s(
		{ name = "rho", trig = "rho", snippetType = "autosnippet", condition = in_math, wordTrig = true },
		{ t("\\rho") }
	),
	s(
		{ name = "sigma", trig = "sgm", snippetType = "autosnippet", condition = in_math, wordTrig = true },
		{ t("\\sigma") }
	),
	s(
		{ name = "tau", trig = "tau", snippetType = "autosnippet", condition = in_math, wordTrig = true },
		{ t("\\tau") }
	),
	s(
		{ name = "theta", trig = "tht", snippetType = "autosnippet", condition = in_math, wordTrig = true },
		{ t("\\theta") }
	),
	s(
		{ name = "upsilon", trig = "ups", snippetType = "autosnippet", condition = in_math, wordTrig = true },
		{ t("\\upsilon") }
	),
	s({ name = "xi", trig = "xxi", snippetType = "autosnippet", condition = in_math, wordTrig = true }, { t("\\xi") }),
	s(
		{ name = "zeta", trig = "zta", snippetType = "autosnippet", condition = in_math, wordTrig = true },
		{ t("\\zeta") }
	),
	s(
		{ name = "phi", trig = "phi", snippetType = "autosnippet", condition = in_math, wordTrig = true },
		{ t("\\phi") }
	),

	s(
		{ name = "Delta", trig = "Dlt", snippetType = "autosnippet", condition = in_math, wordTrig = true },
		{ t("\\Delta") }
	),
	s(
		{ name = "Gamma", trig = "Gma", snippetType = "autosnippet", condition = in_math, wordTrig = true },
		{ t("\\Gamma") }
	),
	s(
		{ name = "Lambda", trig = "Lam", snippetType = "autosnippet", condition = in_math, wordTrig = true },
		{ t("\\Lambda") }
	),
	s(
		{ name = "Omega", trig = "Omg", snippetType = "autosnippet", condition = in_math, wordTrig = true },
		{ t("\\Omega") }
	),
	s({ name = "Pi", trig = "Ppi", snippetType = "autosnippet", condition = in_math, wordTrig = true }, { t("\\Pi") }),
	s(
		{ name = "Psi", trig = "Psi", snippetType = "autosnippet", condition = in_math, wordTrig = true },
		{ t("\\Psi") }
	),
	s(
		{ name = "Phi", trig = "Phi", snippetType = "autosnippet", condition = in_math, wordTrig = true },
		{ t("\\Phi") }
	),
	s(
		{ name = "Sigma", trig = "Sgm", snippetType = "autosnippet", condition = in_math, wordTrig = true },
		{ t("\\Sigma") }
	),
	s(
		{ name = "Theta", trig = "Tht", snippetType = "autosnippet", condition = in_math, wordTrig = true },
		{ t("\\Theta") }
	),
	s(
		{ name = "Upsilon", trig = "Ups", snippetType = "autosnippet", condition = in_math, wordTrig = true },
		{ t("\\Upsilon") }
	),
	s({ name = "Xi", trig = "Xxi", snippetType = "autosnippet", condition = in_math, wordTrig = true }, { t("\\Xi") }),

	-- Abbrev
	s({
		trig = "eq.",
		wordTrig = true,
		condition = not_in_math,
		snippetType = "autosnippet",
	}, { t("equazione") }),
	s({
		trig = "eqq.",
		wordTrig = true,
		condition = not_in_math,
		snippetType = "autosnippet",
	}, { t("equazioni") }),
	s({
		trig = "p.to",
		wordTrig = true,
		condition = not_in_math,
		snippetType = "autosnippet",
	}, { t("punto") }),
	s({
		trig = "p.ti",
		wordTrig = true,
		condition = not_in_math,
		snippetType = "autosnippet",
	}, { t("punti") }),
	s({
		trig = "acc.",
		wordTrig = true,
		condition = not_in_math,
		snippetType = "autosnippet",
	}, { t("accumulazione") }),

	--Testing
	s({ trig = "xz", condition = in_math, snippetType = "autosnippet", wordTrig = true }, { t("x^{0}") }),
	s(
		{ trig = "(?<!\\\\)bm", trigEngine = "ecma", condition = in_math, snippetType = "autosnippet", wordTrig = true },
		{
			t("\\bm{"),
			d(1, visual_cbrace_spaceoptional),
		}
	),
	s(
		{ trig = ".dvd", condition = in_math, snippetType = "autosnippet", wordTrig = true },
		{ t("\\frac{f( \\bm{x^{0}} + t \\bm{v}) - f( \\bm{x^{0}} )}{t}") }
	),
	s({ name = "Rn", trig = "Rn", condition = in_math, snippetType = "autosnippet", wordTrig = true }, {
		t("\\mathbb{R}^{n} "),
	}),
}
