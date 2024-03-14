return {
	"mfussenegger/nvim-dap",
	init = function(_)
		local mappings = require("mappings")
		mappings.load_maps(mappings.maps.dap)
	end,
	lazy = true,
	-- TODO: when should this and ui,virtualtext be loaded?
	config = function()
		local dap = require("dap")
		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = "/opt/codelldb/extension/adapter/codelldb",
				args = { "--port", "${port}" },
			},
		}
		-- no need to call setup
	end,
}
