local function InsertScreenshot()
	local fname = vim.fn.input("Filename (no extension): ")
	os.execute('grim -g "$(slurp)" ' .. vim.fn.expand("%:h") .. "/assets/" .. fname .. ".jpg")
	local ls = require("luasnip")
	local s = ls.snippet
	local t = ls.text_node
	local i = ls.insert_node
	require("luasnip").snip_expand(s({ trig = "" }, {
		t({ "\\begin{figure}[H]", "\t\\centering", "\t\\includegraphics[width=" }),
		i(1, "0.5"),
		t({ "\\textwidth]{" .. fname .. "}", "\t\\label{fig:" .. fname .. "}", "\\end{figure}" }),
	}))
	vim.print(vim.fn.expand("%:h") .. "/assets/" .. fname .. ".jpg")
end

vim.api.nvim_buf_create_user_command(0, "InsertScreenshot", InsertScreenshot, {})

vim.wo.spell = true
