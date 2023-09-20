require("neorg").setup {
    load = {
        ["core.defaults"] = {}, -- Load all the default modules
        ["core.export.markdown"] = {
            config = {          -- Note that this table is optional and doesn't need to be provided
                extension = "md",
                extensions = "all",
                -- Configuration here
            }
        },
        ["core.concealer"] = {
            config = {
                folds = false,
                icon_preset = "varied"
            },
        },                  -- Allows for use of icons
        ["core.dirman"] = { -- Manage your directories with Neorg
            config = {
                workspaces = {
                    notes = "~/notes",
                },
                default_workspace = "notes"
            },
        },
        ["core.keybinds"] = {
            config = {
                default_keybinds = true
            }
        }
    },
}

-- local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
-- parser_configs.norg = {
--     install_info = {
--         url = "https://github.com/vhyrro/tree-sitter-norg",
--         files = { "src/parser.c" },
--         branch = "main",
--     },
-- }
