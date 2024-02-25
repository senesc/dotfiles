return {
	'paretje/nvim-man',
	lazy = true,
	cmd = { "Man", "Vman", "Tman", "Sman" },
	config = function ()
		vim.g.nvim_man_default_target = 'vertical'
	end
}
