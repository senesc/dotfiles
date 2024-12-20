return {
	"neovim/nvim-lspconfig",
	init = function()
		require("core.utils").lazy_load("nvim-lspconfig")
		require("mappings").load_maps(require('mappings').maps.lspconfig)
	end,
	event = "VeryLazy",
	dependencies = {
		"stevearc/dressing.nvim",

		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig",
		"jose-elias-alvarez/null-ls.nvim",
		"folke/neodev.nvim",
		"hrsh7th/cmp-nvim-lsp", -- TODO: make a separate file for it so that it doesn't have to laod so early; also, improve config
	},
	config = function(_, opts)
		local lspconfig = require("lspconfig")
		local M = {}

		-- export on_attach & capabilities for custom lspconfigs

		M.on_attach = function(client, bufnr)
			local mappings = require("mappings")
			mappings.load_maps(mappings.maps.lspconfig, { buffer = bufnr })
		end

		-- M.capabilities = vim.lsp.protocol.make_client_capabilities()
		M.capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- M.capabilities.textDocument.completion.completionItem = {
		-- 	documentationFormat = { "markdown", "plaintext" },
		-- 	snippetSupport = true,
		-- 	preselectSupport = true,
		-- 	insertReplaceSupport = true,
		-- 	labelDetailsSupport = true,
		-- 	deprecatedSupport = true,
		-- 	commitCharactersSupport = true,
		-- 	tagSupport = { valueSet = { 1 } },
		-- 	resolveSupport = {
		-- 		properties = {
		-- 			"documentation",
		-- 			"detail",
		-- 			"additionalTextEdits",
		-- 		},
		-- 	},
		-- }
		lspconfig.clangd.setup({
			on_attach = M.on_attach,
		})

		lspconfig.lua_ls.setup({
			on_attach = M.on_attach,
			capabilities = M.capabilities,

			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
							-- [vim.fn.stdpath "data" .. "/lazy/extensions/nvchad_types"] = true,
							[vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
							library = vim.api.nvim_get_runtime_file("", true),
						},
						maxPreload = 100000,
						preloadFileSize = 10000,
					},
					telemetry = {
						enable = false,
					},
				},
			},
		})
		lspconfig.pylsp.setup({
			on_attach = M.on_attach,
			capabilities = M.capabilities,
			settings = {
				-- pylsp = {
				-- plugins = {
				-- rope_completion = {
				-- 	enabled = true,
				-- 				eager = true,
				-- },
				-- 			rope_autoimport = {
				-- 				enabled = true,
				-- 				completions = {
				-- 					enabled = true
				-- 				},
				-- 				code_actions = {
				-- 					enabled = true
				-- 				}
				-- 			},
				-- 			pycodestyle = {
				-- 				-- ignore = { "W391" },
				-- 			},
				-- jedi_completion = { fuzzy = true },
				-- },
				-- },
			},
		})
		-- lspconfig.jedi_language_server.setup({
		-- 	on_attach = M.on_attach,
		-- 	capabilities = M.capabilities,
		-- 	settings = {},
		-- 	single_file_support = true,
		-- })

		lspconfig.pyright.setup({
			capabilities = M.capabilities,
			on_attach = M.on_attach,
			filetypes = { "python" },
			single_file_support = true
		})

		lspconfig.matlab_ls.setup({
			on_attach = M.on_attach,
			settings = {
				matlab = {
					telemetry = false,
				},
			},
			single_file_support = true,
		})
		require('lspconfig').bashls.setup {}

		--Those are all from vscode-langservers-extracted npm module, not updated in mason!
		lspconfig.jsonls.setup({
			on_attach = M.on_attach,
		})
		lspconfig.cssls.setup({
			on_attach = M.on_attach,
		})
		lspconfig.eslint.setup({ -- JavaScript
			on_attach = M.on_attach,
		})
		lspconfig.html.setup({
			on_attach = M.on_attach,
		})
		lspconfig.markdown_oxide.setup({
			on_attach = M.on_attach,
			capabilities = M.capabilities,
			root_dir = lspconfig.util.root_pattern('.obsidian', vim.fn.getcwd()),
		})

		lspconfig.cmake.setup {}

		return M
	end,
}
