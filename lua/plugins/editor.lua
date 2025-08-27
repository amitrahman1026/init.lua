return {
	{
		"MagicDuck/grug-far.nvim",
		opts = { headerMaxWidth = 80 },
		cmd = "GrugFar",
		keys = {
			{
				"<leader>sr",
				function()
					local grug = require("grug-far")
					local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
					grug.open({
						transient = true,
						prefills = {
							filesFilter = ext and ext ~= "" and "*." .. ext or nil,
						},
					})
				end,
				mode = { "n", "v" },
				desc = "Search and Replace",
			},
		},
	},

	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			signs_staged = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
			},
			on_attach = function(buffer)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
				end

				map("n", "]h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gs.nav_hunk("next")
					end
				end, "Next Hunk")
				map("n", "[h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gs.nav_hunk("prev")
					end
				end, "Prev Hunk")
				map("n", "]H", function()
					gs.nav_hunk("last")
				end, "Last Hunk")
				map("n", "[H", function()
					gs.nav_hunk("first")
				end, "First Hunk")
				map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
				map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
				map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
				map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
				map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
				map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
				map("n", "<leader>ghb", function()
					gs.blame_line({ full = true })
				end, "Blame Line")
				map("n", "<leader>ghB", function()
					gs.blame()
				end, "Blame Buffer")
				map("n", "<leader>ghd", gs.diffthis, "Diff This")
				map("n", "<leader>ghD", function()
					gs.diffthis("~")
				end, "Diff This ~")
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
			end,
		},
	},

	{
		"folke/trouble.nvim",
		cmd = { "Trouble" },
		opts = {
			modes = {
				lsp = {
					win = { position = "right" },
				},
			},
		},
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
			{ "<leader>cs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
			{ "<leader>cS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/... (Trouble)" },
			{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
			{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
			{
				"[q",
				function()
					if require("trouble").is_open() then
						require("trouble").prev({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cprev)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Previous Trouble/Quickfix Item",
			},
			{
				"]q",
				function()
					if require("trouble").is_open() then
						require("trouble").next({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cnext)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Next Trouble/Quickfix Item",
			},
		},
	},

	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"]t",
				function()
					require("todo-comments").jump_next()
				end,
				desc = "Next Todo Comment",
			},
			{
				"[t",
				function()
					require("todo-comments").jump_prev()
				end,
				desc = "Previous Todo Comment",
			},
			{ "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
			{
				"<leader>xT",
				"<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>",
				desc = "Todo/Fix/Fixme (Trouble)",
			},
			{ "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
			{ "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
		},
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "modern",
			delay = 350,
			plugins = {
				marks = true,
				registers = true,
				spelling = {
					enabled = true,
					suggestions = 20,
				},
				presets = {
					operators = true,
					motions = true,
					text_objects = true,
					windows = true,
					nav = true,
					z = true,
					g = true,
				},
			},
			win = {
				border = "rounded",
				padding = { 2, 2 },
				title = true,
				title_pos = "center",
			},
			layoutb = {
				spacing = 3,
			},
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)

			wk.add({
				{ "<leader>p", group = "project/find" },
				{ "<leader>pf", desc = "Find files" },
				{ "<leader>ps", desc = "Live grep search" },
				{ "<leader>pv", desc = "Open file explorer" },
				{ "<C-p>", desc = "Find files in git repo" },

				{ "<leader>v", group = "vim/help/lsp" },
				{ "<leader>vh", desc = "Search help tags" },
				{ "<leader>vws", desc = "Workspace symbol", mode = "n" },
				{ "<leader>vd", desc = "Open diagnostic float", mode = "n" },
				{ "<leader>vca", desc = "Code action", mode = "n" },
				{ "<leader>vrr", desc = "Show references", mode = "n" },
				{ "<leader>vrn", desc = "Rename symbol", mode = "n" },

				{ "<leader>g", group = "git" },
				{ "<leader>gs", desc = "Git status (Fugitive)" },
				{ "<leader>gh", group = "git hunks" },
				{ "<leader>ghs", desc = "Stage Hunk", mode = { "n", "v" } },
				{ "<leader>ghr", desc = "Reset Hunk", mode = { "n", "v" } },
				{ "<leader>ghS", desc = "Stage Buffer" },
				{ "<leader>ghu", desc = "Undo Stage Hunk" },
				{ "<leader>ghR", desc = "Reset Buffer" },
				{ "<leader>ghp", desc = "Preview Hunk Inline" },
				{ "<leader>ghb", desc = "Blame Line" },
				{ "<leader>ghB", desc = "Blame Buffer" },
				{ "<leader>ghd", desc = "Diff This" },
				{ "<leader>ghD", desc = "Diff This ~" },

				{ "<leader>a", desc = "Add file to Harpoon" },
				{ "<C-e>", desc = "Toggle Harpoon quick menu" },
				{ "<C-h>", desc = "Navigate to Harpoon file 1" },
				{ "<C-t>", desc = "Navigate to Harpoon file 2" },
				{ "<C-n>", desc = "Navigate to Harpoon file 3" },
				{ "<C-s>", desc = "Navigate to Harpoon file 4" },

				{ "<leader>u", desc = "Toggle Undotree" },
				{ "<leader>f", desc = "Format code" },

				{ "<leader>x", group = "diagnostics/quickfix" },
				{ "<leader>xx", desc = "Diagnostics (Trouble)" },
				{ "<leader>xX", desc = "Buffer Diagnostics (Trouble)" },
				{ "<leader>xL", desc = "Location List (Trouble)" },
				{ "<leader>xQ", desc = "Quickfix List (Trouble)" },
				{ "<leader>xt", desc = "Todo (Trouble)" },
				{ "<leader>xT", desc = "Todo/Fix/Fixme (Trouble)" },

				{ "<leader>c", group = "code/lsp" },
				{ "<leader>cs", desc = "Symbols (Trouble)" },
				{ "<leader>cS", desc = "LSP references/definitions/... (Trouble)" },

				{ "<leader>s", group = "search" },
				{ "<leader>sr", desc = "Search and Replace", mode = { "n", "v" } },
				{ "<leader>st", desc = "Todo" },
				{ "<leader>vs", desc = "Open file in vertical split" },
				{ "<leader>hs", desc = "Open file in horizontal split" },

				{ "<leader>b", group = "buffer" },
				{ "<leader>bb", desc = "Jump to previous buffer" },
				{ "<leader>bn", desc = "Next buffer" },
				{ "<leader>bp", desc = "Previous buffer" },

				{ "<leader>e", desc = "Toggle Neotree" },

				{ "gd", desc = "Go to definition", mode = "n" },
				{ "K", desc = "Hover documentation", mode = "n" },
				{ "[d", desc = "Next diagnostic", mode = "n" },
				{ "]d", desc = "Previous diagnostic", mode = "n" },
				{ "[h", desc = "Prev Hunk" },
				{ "]h", desc = "Next Hunk" },
				{ "[H", desc = "First Hunk" },
				{ "]H", desc = "Last Hunk" },
				{ "[t", desc = "Previous Todo Comment" },
				{ "]t", desc = "Next Todo Comment" },
				{ "[q", desc = "Previous Trouble/Quickfix Item" },
				{ "]q", desc = "Next Trouble/Quickfix Item" },

				{ "J", desc = "Join lines and keep cursor in place", mode = "n" },
				{ "J", desc = "Move selected lines down", mode = "v" },
				{ "K", desc = "Move selected lines up", mode = "v" },
				{ "<C-d>", desc = "Scroll down half page and center", mode = "n" },
				{ "<C-u>", desc = "Scroll up half page and center", mode = "n" },
				{ "n", desc = "Next search result (centered)", mode = "n" },
				{ "N", desc = "Previous search result (centered)", mode = "n" },

				{ "<leader>p", desc = "Paste without yanking replaced text", mode = "x" },

				{ "<C-c>", desc = "Exit insert mode", mode = "i" },
				{ "<C-h>", desc = "Signature help", mode = "i" },

				{ "ih", desc = "GitSigns Select Hunk", mode = { "o", "x" } },
			})
		end,
	},
}
