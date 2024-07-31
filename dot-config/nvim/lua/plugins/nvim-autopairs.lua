return {
	"windwp/nvim-autopairs",
	opts = {
		fast_wrap = {},
		disable_filetype = { "TelescopePrompt", "vim" },
	},
	config = function(_, opts)
		require("nvim-autopairs").setup(opts)

		-- setup cmp for autopairs
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		---@diagnostic disable-next-line: undefined-field
		require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
		local npairs = require("nvim-autopairs")
		local cond = require("nvim-autopairs.conds")
		local Rule = require("nvim-autopairs.rule")
		npairs.add_rule(Rule("'", "'"):with_pair(cond.not_filetypes({ "tex" })))
	end,
}
