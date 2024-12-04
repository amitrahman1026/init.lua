return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	config = function()
		-- Neotree settings
		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					hide_dotfiles = false, -- Show dotfiles
					hide_gitignored = false, -- Show Git-ignored files
					hide_hidden_count = false, -- Show count of hidden items
				},
				hijack_netrw_behavior = "disabled",
			},
		})

		-- Set leader key mappings for Neotree
		local map = vim.api.nvim_set_keymap
		local opts = { noremap = true, silent = true }

		-- Toggle Neotree
		map("n", "<leader>e", ":Neotree toggle<CR>", opts)

		-- Open file in vertical split
		map("n", "<leader>vs", ":Neotree focus<CR>:vsplit<CR>", opts)

		-- Open file in horizontal split
		map("n", "<leader>hs", ":Neotree focus<CR>:split<CR>", opts)

		-- Buffer navigation
		map("n", "<leader>bb", ":b#<CR>", opts) -- Jump to previous buffer
		map("n", "<leader>bn", ":bnext<CR>", opts) -- Next buffer
		map("n", "<leader>bp", ":bprevious<CR>", opts) -- Previous buffer
	end,
}
