# Neovim Configuration

This repository contains my personal Neovim configuration, optimized for ease of use and minimalistic. The configuration has recently been migrated from Packer to lazy.nvim for improved plugin management.

I can't promise that this will not break on your machine.


```
.
├── init.lua                 # Main configuration file
├── lazy-lock.json           # Lock file for lazy.nvim
└── lua
    ├── config
    │   ├── init.lua         # Initializes core configuration, e.g. editor settings, remaps etc.
    │   ├── keymaps.lua      # Custom keybindings
    │   └── options.lua      # Neovim options and settings
    └── plugins
        ├── colors.lua       # Color scheme configuration
        ├── competitest.lua  # Competitive programming plugin
        ├── formatter.lua    # Code formatting plugin
        ├── fugitive.lua     # Git integration
        ├── harpoon.lua      # Quick file navigation
        ├── lsp.lua          # Language Server Protocol setup
        ├── telescope.lua    # Fuzzy finder
        ├── treesitter.lua   # Syntax highlighting and parsing
        └── undootree.lua    # Undo history visualizer
```

## Migration from Packer to lazy.nvim

The decision to migrate from Packer to [lazy.nvim](https://lazy.folke.io/) was made for a few reasons:

- Improved Performance: lazy.nvim offers some nice insights and [profiling](https://lazy.folke.io/usage/profiling) on top of the lazy loading.
- Simpler Configuration: The switch let me move to keeping each plugin + config in one file is great. I didn't have to dig through which `after` file I configured which plugin in.
- Better Plugin Management: The `.lock` file is great because I literally kept forgetting how to use packer when set up new machines.

### Plugin Overview

This configuration includes the following major components:

#### Package Manager

- lazy.nvim

#### LSP (Language Server Protocol) Support:

- [lsp-zero.nvim](https://lsp-zero.netlify.app/v4.x/): Streamlined LSP setup
- [mason.nvim](https://github.com/williamboman/mason.nvim): Portable package manager for Neovim

##### Completion and Snippets

[nvim-cmp](https://github.com/hrsh7th/nvim-cmp): Autocompletion plugin
[LuaSnip](https://github.com/L3MON4D3/LuaSnip): Snippet engine

##### Syntax and Highlighting

[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter): Provides better syntax highlighting and text objects

#### File Navigation and Search

- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim): Highly extendable fuzzy finder
- [harpoon](https://github.com/ThePrimeagen/harpoon): Quick file navigation, shoutout to theprimeagen.

#### Git Integration

- [vim-fugitive](https://github.com/tpope/vim-fugitive): Git wrapper for Vim

#### Code Formatting

- [formatter.nvim](https://github.com/mhartington/formatter.nvim): Async formatter plugin

#### Utility

- [undotree](https://github.com/mbbill/undotree): Visualizes the undo history

#### Aesthetics

- [rose-pine](https://github.com/rose-pine/neovim): Color scheme

### Customization

Feel free to modify any of the configuration files to suit your needs. The modular structure makes it easy to add, remove, or modify plugins and settings.

Typically what you would want to do is follow 

### Contributing

Contributions are welcome! If you have any suggestions or improvements, feel free to open an issue or submit a pull request.
