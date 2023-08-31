return {
    { dir = '~/myProjects/deploy.nvim' },

    { "nvim-lua/plenary.nvim" },

    { 'nvim-lualine/lualine.nvim' },
    { 'nvim-tree/nvim-web-devicons' },
    { 'mbbill/undotree' },
    { "j-hui/fidget.nvim",              config = function() require("fidget").setup() end,  tag = "legacy" },

    -- Tests
    { "andythigpen/nvim-coverage",      config = function() require("coverage").setup() end },

    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
        ft = { "markdown" },
    },

    -- UI
    { "stevearc/dressing.nvim" },
    { "sidebar-nvim/sidebar.nvim" },
    -- use { 'nanozuki/tabby.nvim' }
    { "beauwilliams/focus.nvim",  config = function() require("focus").setup() end },
    { 'ray-x/guihua.lua',         build = 'cd lua/fzy && make' },

    -- Tests
    { "nvim-neotest/neotest" },
    -- use { "olimorris/neotest-phpunit" }
}
