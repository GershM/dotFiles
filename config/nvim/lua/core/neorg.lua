require("neorg").setup {
    load = {
        ["core.defaults"] = {}, -- Load all the default modules
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

local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
parser_configs.norg = {
    install_info = {
        url = "https://github.com/vhyrro/tree-sitter-norg",
        files = { "src/parser.c" },
        branch = "main",
    },
}
