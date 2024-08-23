return {
    "YannickFricke/codestats.nvim",
    lazy = false,
    config = function()
        require("codestats-nvim").setup({
            -- Code stats API key ... Yes, I know it's public, sue me. This has no use for you.
            token = "SFMyNTY.WVcxcGRISmhhRzFoYmpFd01qWT0jI01qSTVNamM9.a2xb3GC9EjYiceQM1NnoTKf8zljqCQtJe4yrEBydFxg",
            endpoint = "https://codestats.net",
            -- The interval in seconds for sending XP (default is 60)
            interval = 60
        })
    end,
    dependencies = {
        "nvim-lua/plenary.nvim"
    }
}
