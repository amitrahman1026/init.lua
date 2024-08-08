# Neovim Configuration

This repository contains my personal Neovim configuration, optimized for efficiency and ease of use. The configuration has recently been migrated from Packer to lazy.nvim for improved plugin management.

I can't promise that this will not break on your machine.


```
.
├── init.lua                 # Main configuration file
├── lazy-lock.json           # Lock file for lazy.nvim
└── lua
    ├── config
    │   ├── init.lua         # Initializes core configuration
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

The decision to migrate from Packer to lazy.nvim was made for several reasons:

- Improved Performance: lazy.nvim offers better startup times by lazy-loading plugins.
- Simpler Configuration: lazy.nvim provides a more streamlined and intuitive configuration syntax.
- Better Plugin Management: lazy.nvim offers improved dependency management and plugin organization.
- Active Development: lazy.nvim is actively maintained and regularly updated with new features.

### Plugin Overview

This configuration includes the following major components:

#### Package Manager

- lazy.nvim: Efficient plugin manager for Neovim

#### LSP (Language Server Protocol) Support:

- lsp-zero.nvim: Streamlined LSP setup
- mason.nvim: Portable package manager for Neovim
- mason-lspconfig.nvim: Bridge between mason.nvim and lspconfig
- nvim-lspconfig: Quickstart configurations for the Neovim LSP client

##### Completion and Snippets

nvim-cmp: Autocompletion plugin
LuaSnip: Snippet engine

##### Syntax and Highlighting

nvim-treesitter: Provides better syntax highlighting and text objects
nvim-treesitter-context: Shows code context

#### File Navigation and Search

- telescope.nvim: Highly extendable fuzzy finder
- harpoon: Quick file navigation

#### Git Integration

- vim-fugitive: Git wrapper for Vim

#### Code Formatting

- formatter.nvim: Async formatter plugin

#### Utility

- undotree: Visualizes the undo history
competitest.nvim: Competitive programming plugin

#### Aesthetics

- rose-pine: Color scheme

### Customization

Feel free to modify any of the configuration files to suit your needs. The modular structure makes it easy to add, remove, or modify plugins and settings.

### Contributing

Contributions are welcome! If you have any suggestions or improvements, feel free to open an issue or submit a pull request.
