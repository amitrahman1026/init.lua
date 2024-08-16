return {
	"mrjones2014/legendary.nvim",
	priority = 10000,
	lazy = false,
	config = function()
		require("legendary").setup({
			include_builtin = true,
			include_legendary_cmds = true,
			extensions = {
				lazy_nvim = true,
			},
		})
	end,
}
