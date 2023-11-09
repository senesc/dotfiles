return {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    opts = {
		ensure_installed = { "lua-language-server" }, -- not an option from mason.nvim

		PATH = "append",
		ui = {
			icons = {
				package_pending = " ",
				package_installed = " ",
				package_uninstalled = " ﮊ",
			},
			keymaps = {
				toggle_server_expand = "<CR>",
			    install_server = "i",
				update_server = "u",
				check_server_version = "c",
				update_all_servers = "U",
				check_outdated_servers = "C",
				uninstall_server = "X",
				cancel_installation = "<C-c>",
			},
		},

		max_concurrent_installers = 10,
	},
    config = function(_, opts)
  --    dofile(vim.g.base46_cache .. "mason")
      require("mason").setup(opts)
      vim.g.mason_binaries_list = opts.ensure_installed
    end,
	build = ':MasonUpdate',
}
