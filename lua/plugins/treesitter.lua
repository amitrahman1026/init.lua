return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			-- The main branch has no ensure_installed or highlight options:
			-- install parsers here (needs the tree-sitter CLI) and start highlighting per buffer.
			require("nvim-treesitter").install({ "vimdoc", "javascript", "typescript", "cpp", "c", "lua", "rust", "ocaml" })
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					pcall(vim.treesitter.start, args.buf)
				end,
			})
		end,
	},
	{ "nvim-treesitter/nvim-treesitter-context" },
}
