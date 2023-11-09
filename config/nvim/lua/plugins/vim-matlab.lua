return {
	"daeyun/vim-matlab",
	lazy = true,
	config = function(_)
		vim.g.matlab_auto_mappings = 0
		vim.g.matlab_server_launcher = "tmux"
	end,
}
