local M = {}

M.is_dir = function(path)
	local stat = vim.loop.fs_stat(path)
	return stat and stat.type == "directory" or false
end

M.remove_disabled_keys = function(chadrc_mappings, default_mappings)
	if not chadrc_mappings then
		return default_mappings
	end

	-- store keys in a array with true value to compare
	local keys_to_disable = {}
	for _, mappings in pairs(chadrc_mappings) do
		for mode, section_keys in pairs(mappings) do
			if not keys_to_disable[mode] then
				keys_to_disable[mode] = {}
			end
			section_keys = (type(section_keys) == "table" and section_keys) or {}
			for k, _ in pairs(section_keys) do
				keys_to_disable[mode][k] = true
			end
		end
	end

	-- make a copy as we need to modify default_mappings
	for section_name, section_mappings in pairs(default_mappings) do
		for mode, mode_mappings in pairs(section_mappings) do
			mode_mappings = (type(mode_mappings) == "table" and mode_mappings) or {}
			for k, _ in pairs(mode_mappings) do
				-- if key if found then remove from default_mappings
				if keys_to_disable[mode] and keys_to_disable[mode][k] then
					default_mappings[section_name][mode][k] = nil
				end
			end
		end
	end

	return default_mappings
end

M.lazy_load = function(plugin)
	vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
		group = vim.api.nvim_create_augroup("BeLazyOnFileOpen" .. plugin, {}),
		callback = function()
			local file = vim.fn.expand("%")
			local condition = file ~= "NvimTree_1" and file ~= "[lazy]" and file ~= ""

			if condition then
				vim.api.nvim_del_augroup_by_name("BeLazyOnFileOpen" .. plugin)

				-- dont defer for treesitter as it will show slow highlighting
				-- This deferring only happens only when we do "nvim filename"
				if plugin ~= "nvim-treesitter" then
					vim.schedule(function()
						require("lazy").load({ plugins = plugin })

						if plugin == "nvim-lspconfig" then
							vim.cmd("silent! do FileType")
						end
					end, 0)
				else
					require("lazy").load({ plugins = plugin })
				end
			end
		end,
	})
end

M.get_bufnr_by_path = function(file_path)
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		local buf_name = vim.api.nvim_buf_get_name(buf)
		if buf_name == file_path then
			return buf
		end
	end
	return nil
end

return M
