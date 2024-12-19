return {
	'Vigemus/iron.nvim',
	cmd = { "IronRepl", "IronRestart", "IronFocus", "IronHide" },
	keys = { "<localleader>rs" },
	init = function()
		local maps = require("mappings")
		maps.load_maps(maps.maps.iron)
	end,
	opts = function()
		fts = require('iron.fts')

		-- to make venvs work
		local python = fts.python
		if vim.fn.executable("./venv/bin/python") then
			for k, _ in pairs(python) do
				python[k].command[1] = "./venv/bin/" .. python[k].command[1]
			end
		end

		return {
			config = {
				close_window_on_exit = true,
				scratch_repl = true,
				highlight_last = "IronLastSent",
				repl_definition = {
					sh = fts.sh,
					python = python.ipython,
					lua = fts.lua
				},
				repl_open_cmd = require('iron.view').split.vertical.botright(60, {
					number = false,
					relativenumber = false
				}),
			},
			keymaps = {}, -- keymaps in maps.lua
			highlight = {
				italic = true
			},
			ignore_blank_lines = true
		}
	end,
	config = function(_, opts)
		require("iron.core").setup(opts)
	end
}
