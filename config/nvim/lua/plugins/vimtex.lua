return {
	"lervag/vimtex",
	lazy = false,
	config = function(_, _)
		vim.g.vimtex_enabled = true
		vim.g.vimtex_fold_enabled = true
		vim.g.vimtex_compiler_method = "latexmk"
		vim.g.vimtex_compiler_latexmk = {
			build_dir = vim.fn.expand("$HOME") .. "/.local/share/latexmk/build/",
			aux_dir = vim.fn.expand("$HOME") .. "/.local/share/latexmk/aux/",
			out_dir = ".",
			callback = 1,
			continuous = 1,
			executable = "latexmk",
			hooks = {},
			options = {
				"-verbose",
				"-file-line-error",
				"-interaction=nonstopmode",
				"-dvi-",
				"-synctex=1",
			},
		}
		vim.g.vimtex_view_method = "zathura_simple"
		vim.g.vimtex_quickfix_open_on_warning = 0
		vim.g.vimtex_imaps_enabled = 0
		vim.g.vimtex_matchparen_enabled = 0

		local search_id = vim.api.nvim_create_augroup("FW_BW search", { clear = true })
		vim.api.nvim_create_autocmd("User", {
			pattern = "VimtexEventView",
			command = "silent exec '!hyprctl dispatch focuswindow org.pwmt.zathura'",
			group = search_id,
		})
		vim.api.nvim_create_autocmd("User", {
			pattern = "VimtexEventViewReverse",
			command = "silent exec '!hyprctl dispatch focuswindow nvim-qt'",
			group = search_id,
		})
	end,
}
