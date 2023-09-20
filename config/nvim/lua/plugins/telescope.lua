return {
    -- Navigation
    {
        "nvim-telescope/telescope.nvim",
        priority = 100,
        config = function()
            require "core.telescope.setup"
            require "core.telescope.keys"
        end,
    },
    { 'nvim-telescope/telescope-project.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim',  build = 'make' },
    { "nvim-telescope/telescope-file-browser.nvim" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { 'nvim-tree/nvim-tree.lua',                   tag = "nightly" },
}
