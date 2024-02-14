return {
	"mfussenegger/nvim-dap",
	init = function(_)
		require("mappings").load_mappings("dap")
	end,
	config = function(_, opts)
		local dap = require("dap")
		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = "/opt/codelldb/extension/adapter/codelldb",
				args = { "--port", "${port}" },
			},
		}
	end,
}
