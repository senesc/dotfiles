-- All plugins have lazy=true by default,to load a plugin on startup just lazy=false
-- List of all default plugins & their definitions
--[[local plugins = {

  -- nvchad plugins
  { "NvChad/extensions", branch = "v2.0" },

  {
    "NvChad/base46",
    branch = "v2.0",
    build = function()
      require("base46").load_all_highlights()
    end,
  },

  {
    "NvChad/ui",
    branch = "v2.0",
    lazy = false,
    config = function()
      require "nvchad_ui"
    end,
  },

  {
    "NvChad/nvim-colorizer.lua",
    init = function()
      require("core.utils").lazy_load "nvim-colorizer.lua"
    end,
    config = function(_, opts)
      require("colorizer").setup(opts)

      -- execute colorizer as soon as possible
      vim.defer_fn(function()
        require("colorizer").attach_to_buffer(0)
      end, 0)
    end,
  },


  -- git stuff
  {
    "lewis6991/gitsigns.nvim",
    ft = "gitcommit",
    init = function()
      -- load gitsigns only when a git file is opened
      vim.api.nvim_create_autocmd({ "BufRead" }, {
        group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
        callback = function()
          vim.fn.system("git -C " .. '"' .. vim.fn.expand "%:p:h" .. '"' .. " rev-parse")
          if vim.v.shell_error == 0 then
            vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
            vim.schedule(function()
              require("lazy").load { plugins = { "gitsigns.nvim" } }
            end)
          end
        end,
      })
    end,
    opts = function()
      return require("plugins.configs.others").gitsigns
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "git")
      require("gitsigns").setup(opts)
    end,
  },

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
	"mason",
	"nvim-tree",
	"nvim-treesitter",
	"nvim-web-devicons",
	"nvterm",
	"plenary",
	"telescope",
	"tokyonight",
	"whichkey",
	"comment",
	"luasnip",
	"lspconfig",
	"nvim-autopairs",
	"indent-blankline",
	"vimtex",
	"cmp",
	"mini-sessions",
	"mini-statusline",
	"tmux",
	"mason-lspconfig",
	"null-ls",
	"nvim-surround",
	"tabby",
	"codewindow",
	"aerial",
	"linediff-vim",
	"nvim-dap",
	"nvim-dap-ui",
	"nvim-dap-virtual-text",
	"telescope-dap",
	"neodev",
	"todo-comments",
	"copilot",
	"vim-matlab",
	"catppuccin",
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
