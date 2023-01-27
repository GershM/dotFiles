require('neorg').setup(
{
    run = ":Neorg sync-parsers",
    load = {
        ["core.ui"] = {},
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.integrations.treesitter"] = { },
        ["core.neorgcmd"] = {},
        ["core.norg.completion"] = {
            config = { engine = "nvim-cmp" }
        },
        ["core.norg.journal"] = {
            config = {
                workspace = "work"
            }
       },
        ["core.norg.dirman"] = {
            config = {
                default_workspace = 'work',
                workspaces = {
                    work = "~/org/work",
                    home = "~/org/home",
                },
            },
        },
    },
}
)
