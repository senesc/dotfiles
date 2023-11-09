return {
	'smojonas/snippet-converter.nvim',
	config = function()
		require("snippet_converter").setup {
			templates = { 
				sources = {
					ultisnips = {
          -- Add snippets from (plugin) folders or individual files on your runtimepath...
						"~/nvim1/config/nvim/UltiSnips",
						vim.fn.stdpath("config") .. "/UltiSnips",
					},
				},
				output = {
        -- Specify the output formats and paths
					vscode_luasnip = {
						vim.fn.stdpath("config") .. "/luasnip_snippets",
					},
				},
			},
      -- To change the default settings (see configuration section in the documentation)
      -- settings = {},
		}
	end,
}
