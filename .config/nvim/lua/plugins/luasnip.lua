return {
	-- snippet plugin
	"L3MON4D3/LuaSnip",
	dependencies = "rafamadriz/friendly-snippets",
	-- build = "make install_jsregexp", it would break my patched library
	init = function()
		require("core.utils").lazy_load("LuaSnip")
		local mappings = require("mappings")
		mappings.load_maps(mappings.maps.luasnip)
	end,
	opts = {
		history = true,
		updateevents = "TextChanged,TextChangedI",
		enable_autosnippets = true,
		store_selection_keys = "<Tab>",
	},
	config = function(_, opts)
		require("luasnip").config.set_config(opts)

		-- loading snippets
		require("luasnip.loaders.from_lua").load()
		require("luasnip.loaders.from_lua").lazy_load({ paths = vim.g.lua_snippets_path or "" })

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
	end,
}
