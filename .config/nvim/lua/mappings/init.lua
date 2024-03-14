local M = {}
local default_opts = { noremap = true }

M.maps = require("mappings.maps")

M.load_maps = function(map, mapping_opt)
	vim.schedule(function()
		local function set_section_map(section_values)
			for mode, mode_values in pairs(section_values) do
				for keybind, mapping_info in pairs(mode_values) do
					local opts = vim.tbl_deep_extend("force", default_opts, mapping_info.opts or {})
					opts = vim.tbl_deep_extend("force", opts, mapping_opt or {})

					mapping_info.opts, opts.mode = nil, nil
					opts.desc = mapping_info[2]

					vim.keymap.set(mode, keybind, mapping_info[1], opts)
				end
			end
		end

		set_section_map(map)
	end)
end

return M
