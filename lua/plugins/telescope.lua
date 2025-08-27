return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.3',
    dependencies = { 
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
      require('telescope').setup({
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          }
        }
      })
      
      require('telescope').load_extension('fzf')
      
      local builtin = require('telescope.builtin')
      
      -- Keymaps for Telescope
      vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = "Find files" })
      vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = "Find files in git repo" })
      vim.keymap.set('n', '<leader>ps', builtin.live_grep, { desc = "Live grep search" })
      vim.keymap.set('n', '<leader>vh', builtin.help_tags, { desc = "Search help tags" })
      
    end,
  }