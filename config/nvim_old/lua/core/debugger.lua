local dap    = require("dap")
local mdap   = require("mason-nvim-dap")
local dapui  = require("dapui")
local lspDir = os.getenv('HOME') .. "/lsp"


dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    --dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    --dapui.close()
end

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
                --"console", -- Not clear Y I need it.
            },
            size = 0.25, -- 25% of total lines
            position = "bottom",
        },
        {
            elements = {
                "stacks",
                "breakpoints",
            },
            size = 40,
            position = "left",
        },
        {
            elements = {
                { id = "scopes", size = 0.25 },
                "watches",
            },
            size = 40, -- 40 columns
            position = "right",
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
        max_height = nil,  -- These can be integers or a float between 0 and 1.
        max_width = nil,   -- Floats will be treated as percentage of your screen.
        border = "double", -- Border style. Can be "single", "double" or "rounded"
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
--
-- mdap.setup({
--     handlers = {
--         function(config)
--             -- all sources with no handler get passed here
--
--             -- Keep original functionality
--             mdap.default_setup(config)
--         end,
--         -- PHP Debugger
--         php = function()
--             dap.adapters.php = {
--                 type = 'executable',
--                 command = 'php-debug-adapter',
--             }
--
--             dap.configurations.php = {
--                 {
--                     type = 'php',
--                     request = 'launch',
--                     name = 'Local: File Debug',
--                     localSourceRoot = "${workspaceFolder}",
--                     port = 9003,
--                     program = "${file}"
--                 },
--                 {
--                     type = 'php',
--                     request = 'launch',
--                     name = 'Docker: API Debug',
--                     pathMappings = {
--                         ['/var/www'] = "${workspaceFolder}",
--                     },
--                     cwd = "${workspaceFolder}",
--                     port = 9200,
--                 },
--                 {
--                     type = 'php',
--                     request = 'launch',
--                     name = 'Remote Proxy: API Debug',
--                     serverSourceRoot = "/var/www_gena",
--                     localSourceRoot = "${workspaceFolder}",
--                     port = 9100,
--                     cwd = "${workspaceFolder}",
--                     proxy = {
--                         host = "192.168.30.250",
--                         port = 9101,
--                         allowMultipleSessions = false,
--                         enable = true,
--                         key = "gena_nvim",
--                     }
--                 }
--             }
--         end,
--         python = function()
--             dap.adapters.python = {
--                 type = 'executable',
--                 command = 'debugpy-adapter',
--             }
--         end
--     }
-- })
--

dap.adapters.php = {
    type = 'executable',
    command = 'php-debug-adapter',
}

dap.configurations.php = {
    {
        type = 'php',
        request = 'launch',
        name = 'Local: File Debug',
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
    {
        type = 'php',
        request = 'launch',
        name = 'Remote Proxy: API Debug',
        serverSourceRoot = "/var/www_gena",
        localSourceRoot = "${workspaceFolder}",
        port = 9100,
        cwd = "${workspaceFolder}",
        proxy = {
            host = "192.168.30.250",
            port = 9101,
            allowMultipleSessions = false,
            enable = true,
            key = "gena_nvim",
        }
    }
}

dap.adapters.lldb = {
    type = 'executable',
    command = 'lldb-vscode', -- adjust as needed, must be absolute path
    name = 'lldb'
}

dap.configurations.cpp = {
    {
        name = 'Launch Test',
        type = 'lldb',
        request = 'launch',
        program = function()
            vim.cmd("!cargo build")
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
    }
}
dap.configurations.rust = dap.configurations.cpp

require("dap-vscode-js").setup({
    adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
})

for _, language in ipairs({ "typescript", "javascript", "javascriptreact", "typescriptreact" }) do
    dap.configurations[language] = {
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            resolveSourceMapLocations = {
                "${workspaceFolder}/client/**",
                "!${workspaceFolder}/node_modules/**"
            },
        },
        {
            type = "pwa-chrome",
            name = "Chrome Launch",
            request = "launch",
            url = "https://localhost",
            sourceMaps = true,
            disableNetworkCache = true,
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
        }
    }
end

dap.adapters.delve = {
    type = "server",
    port = 38697,
    executable = {
        command = "/opt/homebrew/bin/dlv",
        args = { "dap", "-l", "127.0.0.1:38697" }
    }
}
-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
    {
        type = "delve",
        name = "Debug",
        request = "launch",
        program = "${file}"
    },
    {
        type = "delve",
        name = "Debug test", -- configuration for debugging test files
        request = "launch",
        mode = "test",
        program = "${file}"
    },
    -- works with go.mod packages and sub packages
    {
        type = "delve",
        name = "Debug test (go.mod)",
        request = "launch",
        mode = "test",
        program = "./${relativeFileDirname}"
    }
}

require("nvim-dap-virtual-text").setup({
    enabled = true,                     -- enable this plugin (the default)
    enabled_commands = true,            -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
    highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
    highlight_new_as_changed = true,    -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
    show_stop_reason = true,            -- show stop reason when stopped for exceptions
    commented = false,                  -- prefix virtual text with comment string
    only_first_definition = true,       -- only show virtual text at first definition (if there are multiple)
    all_references = true,              -- show virtual text on all all references of the variable (not only definitions)
    display_callback = function(variable, _buf, _stackframe, _node)
        return variable.name .. ' = ' .. variable.value .. " "
    end,
    virt_text_pos = 'right_align', -- position of virtual text, see `:h nvim_buf_set_extmark()`
    all_frames = false,            -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
    virt_lines = false,            -- show virtual lines instead of virtual text (will flicker!)
    --virt_text_win_col = 180 -- position the virtual text at a fixed window column (starting from the first text column) ,
    -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
})
