return {
	"raddari/last-color.nvim",
	lazy = false,
	priority = 999,
	config = function (_, opts)
		require("last-color").setup()
		local theme = require('last-color').recall() or 'catppuccin'
		vim.cmd.colorscheme(theme)
	end
}
