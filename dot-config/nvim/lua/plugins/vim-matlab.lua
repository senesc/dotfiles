return {
	-- FIXME: something to do with plugin registration, commands are not available
	"daeyun/vim-matlab",
	ft = "matlab",
	config = function(_)
		vim.g.matlab_auto_mappings = 0
		vim.g.matlab_server_launcher = "tmux"
	end,
}
