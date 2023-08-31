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
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        { "nvim-telescope/telescope-file-browser.nvim" },
        { "nvim-telescope/telescope-ui-select.nvim" },
        { 'nvim-tree/nvim-tree.lua', tag = "nightly" },
 { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  {
    "ThePrimeagen/git-worktree.nvim",
    config = function()
      require("git-worktree").setup {}
    end,
  },
  {
    "AckslD/nvim-neoclip.lua",
    config = function()
      require("neoclip").setup()
    end,
  },

}
