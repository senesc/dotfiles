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
		dap.adapters.gdb = {
			type = "executable",
			command = "gdb",
			args = { "-i", "dap" }
		}
		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = "/opt/codelldb/extension/adapter/codelldb",
				args = { "--port", "${port}" },
			},
		}
		dap.configurations.c = {
			{
				name = "Launch",
				type = "gdb",
				request = "launch",
				program = function()
					return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
				end,
				cwd = "${workspaceFolder}",
				stopAtBeginningOfMainSubprogram = false,
			},
		}
		vim.api.nvim_command('highlight default BreakpointRed ctermfg=Red')
		vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'BreakpointRed', linehl = '', numhl = '' })

		-- no need to call setup
	end,
}
