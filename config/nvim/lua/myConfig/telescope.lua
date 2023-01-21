require("telescope").setup({
    defaults = {
        preview = true,
        file_ignore_patterns = { ".*node_modules/.*", ".*vendor/.*" },
        extensions = {
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            }
        },
    },
    pickers = {
        find_files                    = {
            theme = "dropdown",
        },
        live_grep                     = {
            theme = "dropdown",
        },
        help_tags                     = {
            theme = "dropdown",
        },
        grep_string                   = {
            theme = "dropdown",
        },
        oldfiles                      = {
            theme = "dropdown",
        },
        buffers                       = {
            theme = "dropdown",
        },
        git_status                    = {
            theme = "dropdown",
        },
        git_branches                  = {
            theme = "dropdown",
        },
        lsp_references                = {
            theme = "dropdown",
        },
        diagnostics                   = {
            theme = "dropdown",
        },
        lsp_document_symbols          = {
            theme = "dropdown",
        },
        lsp_dynamic_workspace_symbols = {
            theme = "dropdown",
        },

    },
})

require('telescope').load_extension('fzf')

--require("telescope").load_extension("git_worktree")
