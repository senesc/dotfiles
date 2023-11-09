return {
	"github/copilot.vim",
	event = "VeryLazy",
	config = function()
		vim.g.copilot_filetypes = {
			["xml"] = false,
			["tex"] = false,
		}
	end,
}
