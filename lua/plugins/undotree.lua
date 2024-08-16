return {
	"mbbill/undotree",
	keys = {
		{ "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle Undotree" },
	},
	config = function()
		-- Keymap for toggling Undotree
		vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle Undotree" })
	end,
}
