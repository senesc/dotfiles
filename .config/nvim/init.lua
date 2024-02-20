local utils = require("core.utils")
-------------------------------------- globals ----------------------------------------- g.nvchad_theme = config.ui.theme
--g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
--g.toggle_theme_icon = "   "
--g.transparency = config.ui.transparency
vim.g.mapleader = " "

vim.opt.laststatus = 2
vim.opt.showmode = true

vim.opt.cursorline = true
vim.opt.visualbell = true
vim.opt.termguicolors = true

vim.opt.confirm = true
vim.opt.autoread = true

vim.opt.expandtab = false
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.shiftround = true
vim.opt.linebreak = true
vim.opt.mouse = "a"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = false
vim.opt.scrolloff = 15

vim.opt.foldenable = false

-- disable nvim intro
vim.opt.shortmess:append("I")

vim.opt.signcolumn = "auto"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.timeoutlen = 400
vim.opt.ttimeoutlen = 70

vim.opt.secure = true
vim.opt.exrc = true
vim.api.nvim_create_autocmd("DirChanged", {
	callback = function(_)
		local file = vim.secure.read(".nvim.lua")
		if file then
			load(file)()
		end
	end,
})

vim.g.sessionpath = vim.fn.stdpath("data") .. "/sessions/"
if not utils.is_dir(vim.fn.stdpath("data") .. "/undodir") then
	-- TODO: os.execute not best practice??
	os.execute("mkdir -p " .. vim.fn.stdpath("data") .. "/undodir")
end
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
vim.opt.updatetime = 1000

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
-- vim.opt.whichwrap:append "<>[]hl"

vim.opt.spelllang = "it,en"
vim.opt.spellsuggest = "best,9"
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/custom.utf-8.add"

vim.opt.matchpairs = "(:),{:},[:],<:>"
vim.g.lua_snippets_path = { vim.fn.stdpath("config") .. "/snippets" }

-- vim.g.lighttheme = false

local maps = require("core.mappings")
maps.load_mappings("global")

require("core.lazy")
