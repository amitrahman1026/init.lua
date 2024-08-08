return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.3',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      
      -- Keymaps for Telescope
      vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = "Find files" })
      vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = "Find files in git repo" })
      vim.keymap.set('n', '<leader>ps', function()
        builtin.grep_string({ search = vim.fn.input("Grep > ") })
      end, { desc = "Grep search" })
      vim.keymap.set('n', '<leader>vh', builtin.help_tags, { desc = "Search help tags" })
      
    end,
  }