-- LSP Simplified for Neovim 0.11 native LSP
return {
	-- nvim-cmp for the superior completion experience
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				sources = {
					{ name = "path" },
					{ name = "nvim_lsp" },
					{ name = "buffer", keyword_length = 3 },
				},
				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<Tab>"] = cmp.mapping.confirm({ select = true }),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				completion = {
					completeopt = "menu,menuone,noselect", -- don't auto-select
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			-- diagnostics config
			vim.diagnostic.config({
				virtual_text = true,
                virtual_lines = false,
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})

			-- LSP servers using the new native config in nvim 0.11
			vim.lsp.config.lua_ls = {
				cmd = { "lua-language-server" },
				root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "selene.toml" },
				filetypes = { "lua" },
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						workspace = {
							checkThirdParty = false,
							library = { vim.env.VIMRUNTIME },
						},
					},
				},
			}

			vim.lsp.config.clangd = {
				cmd = { "/opt/homebrew/opt/llvm/bin/clangd", "--clang-tidy" },
				root_markers = { "compile_commands.json", "compile_flags.txt", ".clangd", ".git" },
				filetypes = { "c", "cpp", "objc", "objcpp" },
			}

			vim.lsp.config.ocamllsp = {
				cmd = { "opam", "exec", "--", "ocamllsp" },
				root_markers = { "*.opam", "esy.json", "package.json", ".git", "dune-project", "dune-workspace" },
				filetypes = { "ocaml", "ocaml.menhir", "ocaml.interface", "ocaml.ocamllex", "reason", "dune" },
			}

			vim.lsp.config.rust_analyzer = {
				cmd = { "rust-analyzer" },
				root_markers = { "Cargo.toml", "rust-project.json" },
				filetypes = { "rust" },
			}

			-- enable lsp servers here
			vim.lsp.enable({ "lua_ls", "clangd", "ocamllsp", "rust_analyzer" })

			-- DON'T enable native completion since we're using nvim-cmp
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(ev)
					-- custom keymaps
					local opts = { buffer = ev.buf, remap = false }

					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
					vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
					vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
					vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
					vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
					vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
				end,
			})

            -- TODO: anything else?
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- set window borders
			vim.o.winborder = "rounded"
		end,
	},
}
