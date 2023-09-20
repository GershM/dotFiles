return {
    -- LSP
    {
        'neovim/nvim-lspconfig',
        opts = { inlay_hints = { enabled = true }, },
        config = function()
            require("core.lsp")
        end
    },
    { 'williamboman/mason-lspconfig.nvim', dependencies = { 'williamboman/mason.nvim' } },

    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-cmdline" },
    { "hrsh7th/cmp-path" },

    { "onsails/lspkind-nvim" },
    { "L3MON4D3/LuaSnip" },
    { "saadparwaiz1/cmp_luasnip" },

    { "folke/neodev.nvim" },

    { "simrat39/inlay-hints.nvim",         config = function() require("core.lsp.inlay") end },
    {
        "glepnir/lspsaga.nvim",
        config = function()
            require("lspsaga").setup({})
        end,
        dependencies = {
            { "nvim-tree/nvim-web-devicons" },
            { "nvim-treesitter/nvim-treesitter" }
        }
    },
    { "SmiteshP/nvim-navic",   dependencies = "neovim/nvim-lspconfig" },
    { "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup {} end },
    {
        "ray-x/go.nvim",
        dependencies = { -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        event = { "CmdlineEnter" },
        ft = { "go", 'gomod' },
        build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    },
    { 'ray-x/lsp_signature.nvim' },

    { 'folke/lsp-colors.nvim' },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = require('core.trouble')
    }
}
