-- Utilities for creating configurations
local util = require "formatter.util"

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup {
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
            return {
                exe = "clang-format",
                -- Defaults to base llvm style
                -- args = {"--style=file"},
                -- Example, just read clang-format --help for more tips
                -- args = {"--style='{BasedOnStyle: llvm,IndentWidth: 8}'"},
                -- What I usually use
                args = {"--style='{BasedOnStyle: llvm, IndentWidth: 4, TabWidth: 4, AccessModifierOffset: -4, AllowShortFunctionsOnASingleLine: All, AllowShortIfStatementsOnASingleLine: AllIfsAndElse}'"},
                stdin=true,
            }
        end
    },
    c = {
        function()
            return {
                exe = "clang-format",
                -- Defaults to base llvm style
                -- args = {"--style=file"},
                -- Example, just read clang-format --help for more tips
                -- args = {"--style='{BasedOnStyle: llvm,IndentWidth: 8}'"},
                -- What I usually use
                args = {"--style='{BasedOnStyle: llvm, IndentWidth: 4, TabWidth: 4, AccessModifierOffset: -4, AllowShortFunctionsOnASingleLine: All, AllowShortIfStatementsOnASingleLine: AllIfsAndElse}'"},
                stdin=true,
            }
        end
    },
    lua = {
      -- "formatter.filetypes.lua" defines default configurations for the
      -- "lua" filetype
      require("formatter.filetypes.lua").stylua,

      -- You can also define your own configuration
      function()
        -- Supports conditional formatting
        if util.get_current_buffer_file_name() == "special.lua" then
          return nil
        end

        -- Full specification of configurations is down below and in Vim help
        -- files
        return {
          exe = "stylua",
          args = {
            "--search-parent-directories",
            "--stdin-filepath",
            util.escape_path(util.get_current_buffer_file_path()),
            "--",
            "-",
          },
          stdin = true,
        }
      end
    },
    typescript = {
      function()
        return {
          exe = "prettier",
          args = {
            "--stdin-filepath",
            vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
            '--single-quote'
          },
          stdin = true,
        }
      end
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
      end
    },
    json = {
      function()
        return {
          exe = "prettier",
          args = {
            "--stdin-filepath",
            vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
            '--single-quote'
          },
          stdin = true,
        }
      end
    },
    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    ["*"] = {
      -- "formatter.filetypes.any" defines default configurations for any
      -- filetype
      require("formatter.filetypes.any").remove_trailing_whitespace
    }
  }
}
-- Key mapping to format code using formatter.nvim
vim.api.nvim_set_keymap('n', '<leader>f', ':Format<CR>', { noremap = true, silent = true })
