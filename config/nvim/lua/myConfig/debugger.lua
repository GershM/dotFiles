local dap, dapui = require("dap"), require("dapui")
local lspDir = "/Users/gershmirson/lsp"

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

-- Chrome Debugger
require("dap-vscode-js").setup({
    -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
    --debugger_path = lspDir .. "/vscode-js-debug", -- Path to vscode-js-debug installation.
    --debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
    adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
    -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
    -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
    --log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})
for _, language in ipairs({ "typescript", "javascript", "javascriptreact", "typescriptreact" }) do
    require("dap").configurations[language] = {
        {
            type = "pwa-chrome",
            name = "Chrome Launch",
            request = "launch",
            url = "https://localhost",
            sourceMaps = true,
            disableNetworkCache = true,
            log = true,
            userDataDir = false,
            webRoot = "${workspaceFolder}/client",
            resolveSourceMapLocations = {
                "${workspaceFolder}/client/**",
                "!${workspaceFolder}/node_modules/**"
            },
            sourceMapPathOverrides = {
                ["webpack:///./~/*"] = "${workspaceFolder}/node_modules/*",
                ["webpack:///*"] = "${webRoot}/*",
            },
            runtimeArgs = {
            }
        }
    }
end

--    PHP Debugger
dap.adapters.php = {
    type = 'executable',
    command = 'node',
    args = { lspDir .. '/vscode-php-debug/out/phpDebug.js' }
}

dap.configurations.php = {
    {
        type = 'php',
        request = 'launch',
        name = 'Local/Docker: File Debug',
        localSourceRoot = "${workspaceFolder}",
        port = 9003,
        program = "${file}"
    },
    {
        type = 'php',
        request = 'launch',
        name = 'Docker: API Debug',
        pathMappings = {
            ['/var/www'] = "${workspaceFolder}",
        },
        cwd = "${workspaceFolder}",
        port = 9200,
    },

    --{
    --type = 'php',
    --request = 'launch',
    --name = 'Remote: API Debug',
    --serverSourceRoot = "/var/www_gena",
    --localSourceRoot = "${workspaceFolder}",
    --port = 9100,
    --cwd = "${workspaceFolder}",
    --proxy = {
    --host = "192.168.30.250",
    --port = 9101,
    --allowMultipleSessions = false,
    --enable = true,
    --key = "gena_nvim",
    --}
    --}
}

dapui.setup({
    icons = { expanded = "", collapsed = "", current_frame = "" },
    mappings = {
        expand = { "<Tab>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
    },
    -- Use this to override mappings for specific elements
    element_mappings = {
        -- stacks = {
        --   open = "<CR>",
        --   expand = "o",
        -- }
    },
    expand_lines = vim.fn.has("nvim-0.7") == 1,
    layouts = {
        {
            elements = {
                "repl",
                "console",
            },
            size = 0.25, -- 25% of total lines
            position = "bottom",
        },
        {
            elements = {
                "breakpoints",
                "stacks",
            },
            size = 40, -- 40 columns
            position = "left",
        },
        {
            elements = {
                { id = "scopes", size = 0.25 },
                "watches",
            },
            size = 40, -- 40 columns
            position = "rigth",
        },
    },
    controls = {
        -- Requires Neovim nightly (or 0.8 when released)
        enabled = true,
        -- Display controls in this element
        element = "repl",
        icons = {
            pause = "",
            play = "",
            step_into = "",
            step_over = "",
            step_out = "",
            step_back = "",
            run_last = "",
            terminate = "",
        },
    },
    floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
    windows = { indent = 1 },
    render = {
        max_type_length = nil, -- Can be integer or nil.
        max_value_lines = 100, -- Can be integer or nil.
    }
})

require("nvim-dap-virtual-text").setup({
    enabled = true, -- enable this plugin (the default)
    enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
    highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
    highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
    show_stop_reason = true, -- show stop reason when stopped for exceptions
    commented = false, -- prefix virtual text with comment string
    only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
    all_references = false, -- show virtual text on all all references of the variable (not only definitions)
    display_callback = function(variable, _buf, _stackframe, _node)
        return variable.name .. ' = ' .. variable.value
    end,

    virt_text_pos = 'eol', -- position of virtual text, see `:h nvim_buf_set_extmark()`
    all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
    virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
    virt_text_win_col = nil -- position the virtual text at a fixed window column (starting from the first text column) ,
    -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
})
