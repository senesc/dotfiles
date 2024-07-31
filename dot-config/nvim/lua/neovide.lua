if vim.g.neovide then
	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0
	vim.g.neovide_floating_shadow = true
	vim.g.neovide_floating_z_height = 50
	vim.g.neovide_light_angle_degrees = 45
	vim.g.neovide_light_radius = 5
	vim.g.neovide_hide_mouse_when_typing = true
	vim.g.neovide_theme = 'auto'
	vim.g.neovide_fullscreen = false
	vim.g.neovide_remember_window_size = false
	vim.g.neovide_cursor_trail_size = 0.5

	local mappings = require("mappings")
	mappings.load_maps(mappings.maps.neovide)
end
