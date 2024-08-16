return {
	"https://gitlab.com/code-stats/code-stats-vim.git",
	lazy = false,
	config = function()
		-- Code stats API key ... Yes, I know it's public, sue me. This has no use for you.
		vim.g.codestats_api_key =
			"SFMyNTY.WVcxcGRISmhhRzFoYmpFd01qWT0jI01qSTVNamM9.a2xb3GC9EjYiceQM1NnoTKf8zljqCQtJe4yrEBydFxg"
	end,
}
