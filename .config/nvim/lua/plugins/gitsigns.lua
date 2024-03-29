return {
	"lewis6991/gitsigns.nvim",
	event = "BufRead",
	-- ft = "gitcommit",
	init = function()
		local mappings = require("mappings")
		mappings.load_maps(mappings.maps.gitsigns)
		-- load gitsigns only when a git file is opened FIXME: doesn't work
		-- vim.api.nvim_create_autocmd({ "BufRead" }, {
		-- 	group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
		-- 	callback = function()
		-- 		vim.fn.system("git -C " .. '"' .. vim.fn.expand("%:p:h") .. '"' .. " rev-parse")
		-- 		if vim.v.shell_error == 0 then
		-- 			vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
		-- 			vim.schedule(function()
		-- 				require("lazy").load({ plugins = { "gitsigns.nvim" } })
		-- 			end)
		-- 		end
		-- 	end,
		-- })
	end,
	--TODO: add config opts
	config = function(_, opts)
		require("gitsigns").setup(opts)
	end,
}
