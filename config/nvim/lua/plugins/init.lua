return {
    { dir = '~/myProjects/deploy.nvim' },
    { dir = '~/myProjects/workingHours.nvim' },

    { "nvim-lua/plenary.nvim" },

    { 'nvim-lualine/lualine.nvim' },
    { 'nvim-tree/nvim-web-devicons' },
    {
        "m4xshen/hardtime.nvim",
        dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
        opts = {}
    },
    {
        'phaazon/hop.nvim',
        branch = 'v2', -- optional but strongly recommended
        config = function()
            -- you can configure Hop the way you like here; see :h hop-config
            require 'hop'.setup {}
            local hop = require('hop')
            local directions = require('hop.hint').HintDirection
            vim.keymap.set('', 'f', function()
                hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
            end, { remap = true })
            vim.keymap.set('', 'F', function()
                hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
            end, { remap = true })
            vim.keymap.set('', 't', function()
                hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
            end, { remap = true })
            vim.keymap.set('', 'T', function()
                hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
            end, { remap = true })
        end
    },

    -- UI
    -- { "stevearc/dressing.nvim" },
    {
        "beauwilliams/focus.nvim",
        config = function()
            require("focus").setup({
                enable = true,            -- Enable module
                commands = true,          -- Create Focus commands
                autoresize = {
                    enable = true,        -- Enable or disable auto-resizing of splits
                    width = 0,            -- Force width for the focused window
                    height = 0,           -- Force height for the focused window
                    minwidth = 0,         -- Force minimum width for the unfocused window
                    minheight = 0,        -- Force minimum height for the unfocused window
                    height_quickfix = 10, -- Set the height of quickfix panel
                },
                split = {
                    bufnew = false, -- Create blank buffer for new split windows
                    tmux = true,    -- Create tmux splits instead of neovim splits
                },
                ui = {
                    number = false,                    -- Display line numbers in the focussed window only
                    relativenumber = false,            -- Display relative line numbers in the focussed window only
                    hybridnumber = false,              -- Display hybrid line numbers in the focussed window only
                    absolutenumber_unfocussed = false, -- Preserve absolute numbers in the unfocussed windows

                    cursorline = true,                 -- Display a cursorline in the focussed window only
                    cursorcolumn = false,              -- Display cursorcolumn in the focussed window only
                    colorcolumn = {
                        enable = false,                -- Display colorcolumn in the foccused window only
                        list = '+1',                   -- Set the comma-saperated list for the colorcolumn
                    },
                    signcolumn = true,                 -- Display signcolumn in the focussed window only
                    winhighlight = false,              -- Auto highlighting for focussed/unfocussed windows
                }
            })
        end
    },
    { 'ray-x/guihua.lua', build = 'cd lua/fzy && make' },
}
