return {
	'rcarriga/nvim-notify',
	lazy = false,
	opts = {
		background_colour = "NotifyBackground",
		fps = 60,
		icons = {
			DEBUG = "",
			ERROR = "",
			INFO = "",
			TRACE = "✎",
			WARN = ""
		},
		level = 2,
		minimum_width = 50,
		render = "default",
		stages = "slide",
		time_formats = {
			notification = "%T",
			notification_history = "%FT%T"
		},
		timeout = 5000,
		top_down = false
	},
	config = function(_, opts)
		require("notify").setup(opts)
		vim.notify = require("notify")
	end
}
