return {
	"jose-elias-alvarez/null-ls.nvim",
	enabled = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function(_, _)
		local null_ls = require("null-ls")
		local opts = {}
		opts.sources = {
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.clang_format,
			null_ls.builtins.diagnostics.pyproject_flake8,
		}
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		opts.on_attach = function(client, bufnr)
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({ async = false })
					end,
				})
			end
		end
		null_ls.setup(opts)
	end,
}
