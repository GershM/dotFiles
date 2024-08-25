return {
    -- Colore Schema
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            -- set termguicolors to enable highlight groups
            vim.opt.termguicolors = true
            require('colorizer').setup()
        end
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            require("tokyonight").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                style = "moon",         -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
                light_style = "day",    -- The theme is used when the background is set to light
                transparent = true,     -- Enable this to disable setting the background color
                terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
                styles = {
                    -- Style to be applied to different syntax groups
                    -- Value is any valid attr-list value for `:help nvim_set_hl`
                    comments = { italic = true },
                    keywords = { italic = true },
                    functions = {},
                    variables = {},
                    -- Background styles. Can be "dark", "transparent" or "normal"
                    sidebars = "dark",            -- style for sidebars, see below
                    floats = "dark",              -- style for floating windows
                },
                sidebars = { "qf", "help" },      -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
                day_brightness = 0.3,             -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
                hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
                dim_inactive = false,             -- dims inactive windows
                lualine_bold = false,             -- When `true`, section headers in the lualine theme will be bold

                --- You can override specific color groups to use other groups or a hex color
                --- function will be called with a ColorScheme table
                ---@param colors ColorScheme
                on_colors = function(colors) end,

                --- You can override specific highlights to use other groups or a hex color
                --- function will be called with a Highlights and ColorScheme table
                ---@param highlights Highlights
                ---@param colors ColorScheme
                on_highlights = function(highlights, colors) end,
            })
        end
    },
    {
        "ray-x/starry.nvim",
        config = function()
            local config = {
                border = false,        -- Split window borders
                italics = {
                    comments = true,   -- Italic comments
                    strings = false,   -- Italic strings
                    keywords = false,  -- Italic keywords
                    functions = false, -- Italic functions
                    variables = false  -- Italic variables
                },

                contrast = {         -- Select which windows get the contrast background
                    enable = true,   -- Enable contrast
                    terminal = true, -- Darker terminal
                    filetypes = {},  -- Which filetypes get darker? e.g. *.vim, *.cpp, etc.
                },

                text_contrast = {
                    lighter = false, -- Higher contrast text for lighter style
                    darker = true    -- Higher contrast text for darker style
                },

                disable = {
                    background = true,   -- true: transparent background
                    term_colors = false, -- Disable setting the terminal colors
                    eob_lines = false    -- Make end-of-buffer lines invisible
                },

                style = {
                    name = 'moonlight',      -- Theme style name (moonlight, earliestsummer, etc.)
                    -- " other themes: dracula, oceanic, dracula_blood, 'deep ocean', darker, palenight, monokai, mariana, emerald, middlenight_blue
                    disable = {},            -- a list of styles to disable, e.g. {'bold', 'underline'}
                    fix = true,
                    darker_contrast = false, -- More contrast for darker style
                    daylight_swith = false,  -- Enable day and night style switching
                    deep_black = false,      -- Enable a deeper black background
                },

                custom_colors = {
                    variable = '#f797d7',
                },
                custom_highlights = {
                    LineNr = { fg = '#777777' },
                    Idnetifier = { fg = '#ff4797' },
                }
            }
            require('starry').setup(config)
        end
    },
    { "p00f/nvim-ts-rainbow" },
    {
        "HiPhish/rainbow-delimiters.nvim",
        config = function()
            -- This module contains a number of default definitions
            local rainbow_delimiters = require 'rainbow-delimiters'

            vim.g.rainbow_delimiters = {
                strategy = {
                    [''] = rainbow_delimiters.strategy['global'],
                    vim = rainbow_delimiters.strategy['local'],
                },
                query = {
                    [''] = 'rainbow-delimiters',
                    lua = 'rainbow-blocks',
                },
                highlight = {
                    'RainbowDelimiterRed',
                    'RainbowDelimiterYellow',
                    'RainbowDelimiterBlue',
                    'RainbowDelimiterOrange',
                    'RainbowDelimiterGreen',
                    'RainbowDelimiterViolet',
                    'RainbowDelimiterCyan',
                },
            }
        end
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
        config = function()
            local highlight = {
                "RainbowRed",
                "RainbowYellow",
                "RainbowBlue",
                "RainbowOrange",
                "RainbowGreen",
                "RainbowViolet",
                "RainbowCyan",
            }
            local hooks = require "ibl.hooks"
            -- create the highlight groups in the highlight setup hook, so they are reset
            -- every time the colorscheme changes
            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
                vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
                vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
                vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
                vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
                vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
                vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
            end)

            vim.g.rainbow_delimiters = { highlight = highlight }
            require("ibl").setup({
                scope = {
                    char = "┃",
                    show_start = true,
                    show_end = true,
                    show_exact_scope = false,
                    injected_languages = true,
                },
                indent = { highlight = { "CursorColumn", "Whitespace" }, char = "" },
                -- show_end_of_line = true,
                -- show_current_context = true,
                -- show_current_context_start = true,
                -- show_trailing_blankline_indent = true,
            })
            hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
        end
    },
}
