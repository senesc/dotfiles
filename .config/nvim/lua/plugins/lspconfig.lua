return {
	"neovim/nvim-lspconfig",
	init = function()
		require("core.utils").lazy_load("nvim-lspconfig")
	end,
	event = "VeryLazy",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig",
		"jose-elias-alvarez/null-ls.nvim",
		"folke/neodev.nvim",
		"hrsh7th/cmp-nvim-lsp", -- TODO: make a separate file for it so that it doesn't have to laod so early; and also, better config
	},
	config = function(_, opts)
		local lspconfig = require("lspconfig")
		local M = {}

		-- export on_attach & capabilities for custom lspconfigs

		M.on_attach = function(client, bufnr)
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false

			require("mappings").load_mappings("lspconfig", { buffer = bufnr })

			--if client.server_capabilities.signatureHelpProvider then
			--  require("nvchad_ui.signature").setup(client)
			--end

			--if not utils.load_config().ui.lsp_semantic_tokens then
			--  client.server_capabilities.semanticTokensProvider = nil
			--end
		end

		M.capabilities = vim.lsp.protocol.make_client_capabilities()

		M.capabilities.textDocument.completion.completionItem = {
			documentationFormat = { "markdown", "plaintext" },
			snippetSupport = true,
			preselectSupport = true,
			insertReplaceSupport = true,
			labelDetailsSupport = true,
			deprecatedSupport = true,
			commitCharactersSupport = true,
			tagSupport = { valueSet = { 1 } },
			resolveSupport = {
				properties = {
					"documentation",
					"detail",
					"additionalTextEdits",
				},
			},
		}
		lspconfig.clangd.setup({
			on_attach = M.on_attach,
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
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
		require("lspconfig").pylsp.setup({
			on_attach = M.on_attach,
			settings = {
				pylsp = {
					plugins = {
						pycodestyle = {
							-- ignore = { "W391" },
						},
					},
				},
			},
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

		return M
	end,
}
