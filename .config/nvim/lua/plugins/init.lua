--[[local plugins = {

  -- load luasnips + cmp related in insert mode only

  {
    "numToStr/Comment.nvim",
    -- keys = { "gc", "gb" },
    init = function()
      require("core.utils").load_mappings "comment"
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("plugins.configs.others").luasnip(opts)
        end,
    end,
    config = function()
      require("Comment").setup()
    end,
  },
--]]

-- Enabled plugins
local plugin_files = {
	"aerial",
	"catppuccin",
	"cmp",
	"codewindow",
	"comment",
	"copilot",
	"copilot-cmp",
	"copilot-lualine",
	"gitsigns",
	"indent-blankline",
	"linediff-vim",
	"lspconfig",
	"lualine",
	"luasnip",
	"mason",
	"mason-lspconfig",
	"mini-sessions",
	"mini-statusline",
	"neodev",
	"nerdy",
	"null-ls",
	"nvim-autopairs",
	"nvim-dap",
	"nvim-dap-ui",
	"nvim-dap-virtual-text",
	"nvim-surround",
	"nvim-tree",
	"nvim-treesitter",
	"nvim-web-devicons",
	"nvterm",
	"plenary",
	"tabby",
	"telescope",
	"telescope-dap",
	"tmux",
	"todo-comments",
	"tokyonight",
	"vim-matlab",
	"vimtex",
	"whichkey",
}

-- Extract plugins

local plugins = {}
for i = 1, #plugin_files do
	table.insert(plugins, require("plugins." .. plugin_files[i]))
end

-- Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazy_config = require("plugins.lazy_nvim").config

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:append(lazypath)

require("lazy").setup(plugins, lazy_config)
