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
        use { "nvim-lua/plenary.nvim" }
        use { "wbthomason/packer.nvim" }

        -- Telescope
        use { 'nvim-telescope/telescope.nvim' }
        use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

        use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
        use { 'nvim-lualine/lualine.nvim' }

        use { 'kyazdani42/nvim-web-devicons' }
        use { 'mbbill/undotree' }
        use { 'nvim-tree/nvim-tree.lua', tag = "nightly" }

        -- Colore Schema
        use { "ellisonleao/gruvbox.nvim" }
        use { "norcalli/nvim-colorizer.lua" }
        use { "folke/tokyonight.nvim" }
        use { "p00f/nvim-ts-rainbow"}

        -- LSP
        use { 'neovim/nvim-lspconfig' }
        --use { 'williamboman/nvim-lsp-installer' }
        use { 'williamboman/mason.nvim' }
        use { 'williamboman/mason-lspconfig.nvim', requires = { 'williamboman/mason.nvim' } }

        use { "hrsh7th/cmp-nvim-lsp" }
        use { "hrsh7th/cmp-buffer" }
        use { "hrsh7th/nvim-cmp" }
        use { "hrsh7th/cmp-cmdline" }
        use { "hrsh7th/cmp-path" }

        use { "onsails/lspkind-nvim" }
        use { "L3MON4D3/LuaSnip" }
        use { "saadparwaiz1/cmp_luasnip" }

        use { "jose-elias-alvarez/null-ls.nvim" }

        -- nvim dev
        use { "folke/neodev.nvim" }

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

        -- Organization
        --use { 'nvim-orgmode/orgmode', config = function() require('orgmode').setup {} end }
        use { "nvim-neorg/neorg" }

        -- Comments
        use { "folke/todo-comments.nvim", config = function() require("todo-comments").setup {} end }
        use { "preservim/nerdcommenter" }

        -- Debugger
        use { "mfussenegger/nvim-dap" }
        use { "rcarriga/nvim-dap-ui" }
        use { "nvim-telescope/telescope-dap.nvim" }
        use { 'theHamsta/nvim-dap-virtual-text' }
        use { "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } }
        use { "microsoft/vscode-js-debug", opt = true, run = "npm install --legacy-peer-deps && npm run compile",
            tag = 'v1.74.1' }
        use { 'mfussenegger/nvim-dap-python' }

        -- Git
        use { 'f-person/git-blame.nvim' }
        use { 'lewis6991/gitsigns.nvim' }
        use { 'TimUntersberger/neogit' }
        use { 'sindrets/diffview.nvim' }
        --use { 'jesseduffield/lazygit' }
        use { 'kdheepak/lazygit.nvim' }


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
