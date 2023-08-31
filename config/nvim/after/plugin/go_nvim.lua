require("go").setup {
    verbose = true, -- output loginf in messages

    -- true: will use go.nvim on_attach if true
    -- nil/false do nothing
    -- lsp_diag_hdlr = true, -- hook lsp diag handler
    dap_debug = true,         -- set to true to enable dap
    dap_debug_keymap = false, -- set keymaps for debugger
    dap_debug_gui = true,     -- set to true to enable dap gui, highly recommand
    dap_debug_vt = true,      -- set to true to enable dap virtual text

    -- TODO: Test these out.
    -- goimport = "gofumports", -- goimport command
    -- gofmt = "gofumpt", --gofmt cmd,
    -- max_line_len = 120, -- max line length in goline format
    -- tag_transform = false, -- tag_transfer  check gomodifytags for details
    -- test_template = "", -- default to testify if not set; g:go_nvim_tests_template  check gotests for details
    -- test_template_dir = "", -- default to nil if not set; g:go_nvim_tests_template_dir  check gotests for details
    -- comment_placeholder = "", -- comment_placeholder your cool placeholder e.g. ﳑ       
    lsp_inlay_hints = {
        enable = true,

        -- Only show inlay hints for the current line
        only_current_line = false,

        -- Event which triggers a refresh of the inlay hints.
        -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
        -- not that this may cause higher CPU usage.
        -- This option is only respected when only_current_line and
        -- autoSetHints both are true.
        only_current_line_autocmd = 'CursorMoved',

        -- whether to show variable name before type hints with the inlay hints or not
        -- default: false
        show_variable_name = true,

        -- prefix for parameter hints
        parameter_hints_prefix = 'f ',
        show_parameter_hints = true,

        -- prefix for all the other hints (type, chaining)
        -- default: "=>"
        other_hints_prefix = '=> ',

        -- whether to align to the length of the longest line in the file
        max_len_align = false,

        -- padding from the left if max_len_align is true
        max_len_align_padding = 1,

        -- whether to align to the extreme right or not
        right_align = false,

        -- padding from the right if right_align is true
        right_align_padding = 10,

        -- The color of the hints
        highlight = 'Comment',
    },

    -- Disable everything for LSP
    lsp_cfg = false,       -- true: apply go.nvim non-default gopls setup
    lsp_gofumpt = false,   -- true: set default gofmt in gopls format to gofumpt
    lsp_on_attach = false, -- if a on_attach function provided:  attach on_attach function to gopls
    gopls_cmd = nil,       -- if you need to specify gopls path and cmd, e.g {"/home/user/lsp/gopls", "-logfile", "/var/log/gopls.log" }
}
