return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function(_, opts)
		require("tokyonight").setup(opts)
		-- if vim.g.lighttheme then
		-- 	vim.cmd[[colorscheme tokyonight-day]]
		-- else
		-- 	vim.cmd[[colorscheme tokyonight]]
		-- end
		-- vim.api.nvim_create_user_command('ToggleLight', function(args)
		-- 	vim.g.lighttheme = not vim.g.lighttheme
		-- 	if vim.g.lighttheme then
		-- 		vim.cmd[[colorscheme tokyonight-day]]
		-- 	else
		-- 		vim.cmd[[colorscheme tokyonight]]
		-- 	end
		-- end,
		-- {
		-- 	desc = 'Toggle light theme'
		-- })
	end,
}
