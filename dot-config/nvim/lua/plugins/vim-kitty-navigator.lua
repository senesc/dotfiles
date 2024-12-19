return {
	"knubie/vim-kitty-navigator",
	lazy = false,
	init = function ()
		vim.g.kitty_navigator_password = "7bf9ca85-5ba1-43a1-9b21-ef6efbfdac01"
		vim.g.kitty_navigator_no_mappings = 1
		local mappings = require("mappings")
		if os.getenv("TERM") == "xterm-kitty" then
			mappings.load_maps(mappings.maps.kitty)
		elseif os.getenv("TERM") == nil then
			mappings.load_maps(mappings.maps.navigation_vanilla)
		end
	end,
}
