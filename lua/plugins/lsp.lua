return {
	-- nvim-cmp for the superior completion experience
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
			{ "L3MON4D3/LuaSnip" },
		},
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				sources = {
					{ name = "path" },
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "buffer", keyword_length = 3 },
					{ name = "luasnip", keyword_length = 2 },
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
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
			"hrsh7th/cmp-nvim-lsp", -- for enhanced capabilities
		},
		config = function()
			-- virtual text became disabled by default in nvim 0.11
			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})

			-- set up LSP servers using the new native config
			vim.lsp.config.lua_ls = {
				cmd = { "lua-language-server" },
				root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "selene.toml", ".git" },
				filetypes = { "lua" },
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						workspace = {
							checkThirdParty = false,
							library = { vim.env.VIMRUNTIME },
						},
						telemetry = { enable = false },
					},
				},
			}

			vim.lsp.config.clangd = {
				cmd = { "clangd", "--clang-tidy" }, -- system clangd on linux
				root_markers = { "compile_commands.json", "compile_flags.txt", ".clangd", ".git" },
				filetypes = { "c", "cpp", "objc", "objcpp" },
			}

			vim.lsp.config.ocamllsp = {
				cmd = { "opam", "exec", "--", "ocamllsp" },
				root_markers = { "*.opam", "esy.json", "package.json", ".git", "dune-project", "dune-workspace" },
				filetypes = { "ocaml", "ocaml.menhir", "ocaml.interface", "ocaml.ocamllex", "reason", "dune" },
			}

			vim.lsp.config.cmake = {
				cmd = { "neocmakelsp", "--stdio" },
				filetypes = { "cmake" },
				root_markers = { ".git", "CMakeLists.txt", "build/", "build-*/" },
				init_options = {
					format = {
						enable = true,
					},
					lint = {
						enable = true,
					},
					scan_cmake_in_package = true,
				},
			}

			vim.lsp.config.rust_analyzer = {
				cmd = { "rust-analyzer" },
				root_markers = { "Cargo.toml", "rust-project.json", ".git" },
				filetypes = { "rust" },
			}

			-- enable the servers here
			vim.lsp.enable({ "lua_ls", "clangd", "cmake", "ocamllsp", "rust_analyzer" })

			-- set up keymaps on LSP attach
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

			-- set window borders for floating windows
			vim.o.winborder = "rounded"
		end,
	},
}
