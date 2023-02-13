local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

require("packer").startup({
    function(use)
        -- My Projects
        --use { "~/myProjects/neotest-phpunit" }
        --use { "~/myProjects/phpunit.nvim" }
        use { "~/myProjects/deploy.nvim" }

        -- Deployment
        --use { 'GershM/deploy.nvim' }

        -- General
        use { "wbthomason/packer.nvim" }
        use { "nvim-lua/plenary.nvim" }
        use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
        use { 'nvim-lualine/lualine.nvim' }
        use { 'kyazdani42/nvim-web-devicons' }
        use { 'mbbill/undotree' }

        -- Navigation
        use { 'nvim-telescope/telescope.nvim' }
        use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
        use { "nvim-telescope/telescope-file-browser.nvim" }
        use { 'nvim-tree/nvim-tree.lua', tag = "nightly" }

        -- Colore Schema
        use { "ellisonleao/gruvbox.nvim" }
        use { "norcalli/nvim-colorizer.lua" }
        use { "folke/tokyonight.nvim" }
        use { "p00f/nvim-ts-rainbow" }

        -- LSP
        use { 'neovim/nvim-lspconfig' }
        use { 'williamboman/mason-lspconfig.nvim', requires = { 'williamboman/mason.nvim' } }
        use { "jay-babu/mason-null-ls.nvim" }

        use { "hrsh7th/cmp-nvim-lsp" }
        use { "hrsh7th/cmp-buffer" }
        use { "hrsh7th/nvim-cmp" }
        use { "hrsh7th/cmp-cmdline" }
        use { "hrsh7th/cmp-path" }

        use { "onsails/lspkind-nvim" }
        use { "L3MON4D3/LuaSnip" }
        use { "saadparwaiz1/cmp_luasnip" }

        use { "jose-elias-alvarez/null-ls.nvim" }
        use { "folke/neodev.nvim" }

        -- Organization
        --use { 'nvim-orgmode/orgmode', config = function() require('orgmode').setup {} end }
        use { "nvim-neorg/neorg" }

        -- Comments
        use { "folke/todo-comments.nvim" }

        -- Debugger
        use { "mfussenegger/nvim-dap" }
        use { "rcarriga/nvim-dap-ui" }
        use { "nvim-telescope/telescope-dap.nvim" }
        use { 'theHamsta/nvim-dap-virtual-text' }
        use { "mxsdev/nvim-dap-vscode-js" }
        use { "jay-babu/mason-nvim-dap.nvim" }
        use { "microsoft/vscode-js-debug", opt = true, run = "npm install --legacy-peer-deps && npm run compile",
        tag = 'v1.74.1' }

        -- Git
        use { 'f-person/git-blame.nvim' }
        use { 'lewis6991/gitsigns.nvim' }
        use { 'TimUntersberger/neogit' }
        use { 'sindrets/diffview.nvim' }

        -- Pugin Tests
        -- General
        use { 'glepnir/dashboard-nvim' }
        use { 'nvim-telescope/telescope-project.nvim' }
        use { 'numToStr/Comment.nvim' }

        --use {
        --"ahmedkhalf/project.nvim",
        --config = function()
        --require("project_nvim").setup {
        --{
        ---- Manual mode doesn't automatically change your root directory, so you have
        ---- the option to manually do so using `:ProjectRoot` command.
        --manual_mode = true,

        ---- Methods of detecting the root directory. **"lsp"** uses the native neovim
        ---- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
        ---- order matters: if one is not detected, the other is used as fallback. You
        ---- can also delete or rearangne the detection methods.
        --detection_methods = { "lsp", "pattern" },

        ---- All the patterns used to detect root dir, when **"pattern"** is in
        ---- detection_methods
        --patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },

        ---- Table of lsp clients to ignore by name
        ---- eg: { "efm", ... }
        --ignore_lsp = {},

        ---- Don't calculate root dir on specific directories
        ---- Ex: { "~/.cargo/*", ... }
        --exclude_dirs = {},

        ---- Show hidden files in telescope
        --show_hidden = false,

        ---- When set to false, you will get a message when project.nvim changes your
        ---- directory.
        --silent_chdir = true,

        ---- What scope to change the directory, valid options are
        ---- * global (default)
        ---- * tab
        ---- * win
        --scope_chdir = 'global',

        ---- Path where project.nvim will store the project history for use in
        ---- telescope
        --datapath = vim.fn.stdpath("data"),
        --}
        --}
        --end
        --}
        -- UI
        use { "stevearc/dressing.nvim" }
        -- use { "sidebar-nvim/sidebar.nvim" }

        -- Tests
        --use {
        --"nvim-neotest/neotest",
        --requires = {
        --"vim-test/vim-test",
        --"nvim-lua/plenary.nvim",
        --"nvim-treesitter/nvim-treesitter",
        --"antoinemadec/FixCursorHold.nvim",
        --}
        --}
        --use { "nvim-neotest/neotest-vim-test" }
        --use { "vim-test/vim-test" }
        --use { "folke/neodev.nvim" }
        --use { "olimorris/neotest-phpunit" }

        -- Git
        -- use { 'kdheepak/lazygit.nvim' }
        -- use { 'akinsho/git-conflict.nvim', tag = "*", config = function() require('git-conflict').setup() end }

        -- LSP
        use { "SmiteshP/nvim-navic", requires = "neovim/nvim-lspconfig" }

        --use {
        --'ldelossa/litee.nvim',
        --after = 'nvim-lspconfig',
        --config = function() require('litee.lib').setup({}) end
        --}
        --use {
        --'ldelossa/litee-symboltree.nvim',
        --after = { 'nvim-lspconfig', 'litee.nvim' },
        --config = function() require('litee.symboltree').setup({}) end
        --}
        --use {
        --'ldelossa/litee-calltree.nvim',
        --after = { 'nvim-lspconfig', 'litee.nvim' },
        --config = function() require('litee.calltree').setup({}) end
        --}
    end,
    config = {
        display = {
            open_fn = function()
                return require('packer.util').float({ border = 'single' })
            end
        }
    }
})


-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
    command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
    group = packer_group,
    pattern = vim.fn.expand '$MYVIMRC',
})
