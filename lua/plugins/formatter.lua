return {
	"mhartington/formatter.nvim",
	keys = {
		{ "<leader>f", ":Format<CR>", desc = "Format code" },
	},
	config = function()
		-- Utilities for creating configurations
		local util = require("formatter.util")

		-- Helper function to check for configuration files
		local function config_exists(config_files)
			local cwd = vim.fn.getcwd()
			for _, file in ipairs(config_files) do
				if vim.fn.filereadable(cwd .. "/" .. file) == 1 then
					return true
				end
			end
			return false
		end

		-- Helper function to notify about missing config
		local function notify_missing_config(tool, default_style)
			vim.notify(tool .. " config not found, defaulting to: " .. default_style, vim.log.levels.WARN)
		end

		-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
		require("formatter").setup({
			-- Enable or disable logging
			logging = true,
			-- Set the log level
			log_level = vim.log.levels.WARN,
			-- All formatter configurations are opt-in
			filetype = {
				-- Formatter configurations for filetype "lua" go here
				-- and will be executed in order
				cpp = {
					function()
						if config_exists({ ".clang-format" }) then
							return {
								exe = "clang-format",
								args = { "--assume-filename", util.escape_path(util.get_current_buffer_file_path()) },
								stdin = true,
								try_node_modules = true,
							}
						else
							notify_missing_config("clang-format", "LLVM style")
							return {
								exe = "clang-format",
								args = {
									"--style='{BasedOnStyle: llvm, IndentWidth: 4, TabWidth: 4, AccessModifierOffset: -4, AllowShortFunctionsOnASingleLine: All, AllowShortIfStatementsOnASingleLine: AllIfsAndElse}'",
								},
								stdin = true,
							}
						end
					end,
				},
				c = {
					function()
						if config_exists({ ".clang-format" }) then
							return {
								exe = "clang-format",
								args = { "--assume-filename", util.escape_path(util.get_current_buffer_file_path()) },
								stdin = true,
								try_node_modules = true,
							}
						else
							notify_missing_config("clang-format", "LLVM style")
							return {
								exe = "clang-format",
								args = {
									"--style='{BasedOnStyle: llvm, IndentWidth: 4, TabWidth: 4, AccessModifierOffset: -4, AllowShortFunctionsOnASingleLine: All, AllowShortIfStatementsOnASingleLine: AllIfsAndElse}'",
								},
								stdin = true,
							}
						end
					end,
				},
				lua = {
					require("formatter.filetypes.lua").stylua,
				},
				typescript = {
					function()
						if config_exists({ ".prettierrc", ".prettierrc.js", ".prettierrc.json" }) then
							return {
								exe = "prettier",
								args = {
									"--stdin-filepath",
									util.escape_path(util.get_current_buffer_file_path()),
								},
								stdin = true,
								try_node_modules = true,
							}
						else
							notify_missing_config("prettier", "default style")
							return {
								exe = "prettier",
								args = {
									"--stdin-filepath",
									util.escape_path(util.get_current_buffer_file_path()),
									"--single-quote",
								},
								stdin = true,
							}
						end
					end,
				},
				rust = {
					function()
						return {
							exe = "rustfmt",
							args = {
								"--edition 2021",
							},
							stdin = true,
						}
					end,
				},
				json = {
					function()
						if config_exists({ ".prettierrc", ".prettierrc.js", ".prettierrc.json" }) then
							return {
								exe = "prettier",
								args = {
									"--stdin-filepath",
									util.escape_path(util.get_current_buffer_file_path()),
								},
								stdin = true,
								try_node_modules = true,
							}
						else
							notify_missing_config("prettier", "default style")
							return {
								exe = "prettier",
								args = {
									"--stdin-filepath",
									util.escape_path(util.get_current_buffer_file_path()),
									"--single-quote",
								},
								stdin = true,
							}
						end
					end,
				},
				ocaml = {
					function()
						if config_exists({ ".ocamlformat" }) then
							return {
								exe = "ocamlformat",
								args = {
									"--name",
									util.escape_path(util.get_current_buffer_file_path()),
									"--enable-outside-detected-project",
									"-",
								},
								stdin = true,
							}
						else
							notify_missing_config("ocamlformat", "default style")
							return {
								exe = "ocamlformat",
								args = {
									"--name",
									util.escape_path(util.get_current_buffer_file_path()),
									"--enable-outside-detected-project",
									"--profile=conventional",
									"-",
								},
								stdin = true,
							}
						end
					end,
				},
				markdown = {
					function()
						return {
							exe = "mdformat",
							args = {
								"--wrap",
								"80",
								"-",
							},
							stdin = true,
							format = function(executable, args, input)
								local output = vim.fn.system(executable .. " " .. table.concat(args, " "), input)
								if vim.v.shell_error ~= 0 then
									return nil, "mdformat failed to format the buffer"
								end
								return output
							end,
						}
					end,
				},
				-- Use the special "*" filetype for defining formatter configurations on
				-- any filetype
				["*"] = {
					require("formatter.filetypes.any").remove_trailing_whitespace,
				},
			},
		})
		-- Key mapping to format code using formatter.nvim
		vim.api.nvim_set_keymap("n", "<leader>f", ":Format<CR>", { noremap = true, silent = true })
	end,
}
