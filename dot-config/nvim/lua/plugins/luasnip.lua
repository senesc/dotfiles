return {
	-- snippet plugin
	"L3MON4D3/LuaSnip",
	dependencies = "rafamadriz/friendly-snippets",
	-- build = "make install_jsregexp", it would break my patched library
	lazy = true,
	init = function()
		local mappings = require("mappings")
		mappings.load_maps(mappings.maps.luasnip)
		vim.api.nvim_create_user_command("LuaSnipEditSnippets", function()
			--TODO: make it handier with auto selecting current filetype and accepting a different filetype as an argument
			require("luasnip.loaders").edit_snippet_files()
		end, {})
	end,
	opts = {
		history = true,
		updateevents = "TextChanged,TextChangedI",
		enable_autosnippets = true,
		store_selection_keys = "<Tab>",
	},
	config = function(_, opts)
		-- loading snippets
		require("luasnip.loaders.from_lua").lazy_load({ paths = vim.g.lua_snippets_path or "~/.config/nvim/snippets" })
		require("luasnip.loaders.from_vscode").lazy_load()

		vim.api.nvim_create_autocmd("InsertLeave", {
			callback = function()
				if
					require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
					and not require("luasnip").session.jump_active
				then
					require("luasnip").unlink_current()
				end
			end,
		})

		local break_undo_id = vim.api.nvim_create_augroup("FW_BW search", { clear = true })
		vim.api.nvim_create_autocmd("User", {
			pattern = "LuasnipPreExpand",
			command = "let &undolevels = &undolevels",
			group = break_undo_id,
		})
		require("luasnip").setup(opts)
	end,
}
