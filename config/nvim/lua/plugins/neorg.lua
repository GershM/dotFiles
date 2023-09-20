return {
    {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        dependencies = { { "nvim-lua/plenary.nvim" },
            {
                -- YOU ALMOST CERTAINLY WANT A MORE ROBUST nvim-treesitter SETUP
                -- see https://github.com/nvim-treesitter/nvim-treesitter
                "nvim-treesitter/nvim-treesitter",
                opts = {
                    auto_install = true,
                    highlight = {
                        enable = true,
                        additional_vim_regex_highlighting = false,
                    },
                },
                config = function(_, opts)
                    require('nvim-treesitter.configs').setup(opts)
                end
            },
        },
        config = function()
            require("core.neorg")
        end
    }
}
