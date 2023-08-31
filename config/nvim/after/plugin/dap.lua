local has_dap, dap = pcall(require, "dap")
if not has_dap then
    return
end

vim.fn.sign_define("DapBreakpoint", { text = "ß", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "ü", texthl = "", linehl = "", numhl = "" })
-- Setup cool Among Us as avatar
vim.fn.sign_define("DapStopped", { text = "ඞ", texthl = "Error" })

require("nvim-dap-virtual-text").setup {
    enabled = true,

    -- DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, DapVirtualTextForceRefresh
    enabled_commands = false,

    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
    highlight_changed_variables = true,
    highlight_new_as_changed = true,

    -- prefix virtual text with comment string
    commented = false,

    show_stop_reason = true,

    -- experimental features:
    virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
    all_frames = false,    -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
}

dap.adapters.nlua = function(callback, config)
    callback { type = "server", host = config.host, port = config.port }
end

dap.configurations.lua = {
    {
        type = "nlua",
        request = "attach",
        name = "Attach to running Neovim instance",
        host = function()
            return "127.0.0.1"
        end,
        port = function()
            -- local val = tonumber(vim.fn.input('Port: '))
            -- assert(val, "Please provide a port number")
            local val = 54231
            return val
        end,
    },
}

--  https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#go-using-delve-directly
dap.adapters.go = function(callback, _)
    local stdout = vim.loop.new_pipe(false)
    local handle, pid_or_err
    local port = 38697

    handle, pid_or_err = vim.loop.spawn("dlv", {
        stdio = { nil, stdout },
        args = { "dap", "-l", "127.0.0.1:" .. port },
        detached = true,
    }, function(code)
        stdout:close()
        handle:close()

        print("[delve] Exit Code:", code)
    end)

    assert(handle, "Error running dlv: " .. tostring(pid_or_err))

    stdout:read_start(function(err, chunk)
        assert(not err, err)

        if chunk then
            vim.schedule(function()
                require("dap.repl").append(chunk)
                print("[delve]", chunk)
            end)
        end
    end)

    -- Wait for delve to start
    vim.defer_fn(function()
        callback { type = "server", host = "127.0.0.1", port = port }
    end, 100)
end

dap.configurations.go = {
    {
        type = "go",
        name = "Debug (from vscode-go)",
        request = "launch",
        showLog = false,
        program = "${file}",
        dlvToolPath = vim.fn.exepath "dlv", -- Adjust to where delve is installed
    },
    {
        type = "go",
        name = "Debug (No File)",
        request = "launch",
        program = "",
    },
    {
        type = "go",
        name = "Debug",
        request = "launch",
        program = "${file}",
        showLog = true,
        -- console = "externalTerminal",
        -- dlvToolPath = vim.fn.exepath "dlv",
    },
    {
        name = "Test Current File",
        type = "go",
        request = "launch",
        showLog = true,
        mode = "test",
        program = ".",
        dlvToolPath = vim.fn.exepath "dlv",
    },
    {
        type = "go",
        name = "Run lsif-clang indexer",
        request = "launch",
        showLog = true,
        program = ".",
        args = {
            "--indexer",
            "lsif-clang compile_commands.json",
            "--dir",
            vim.fn.expand "~/sourcegraph/lsif-clang/functionaltest",
            "--debug",
        },
        dlvToolPath = vim.fn.exepath "dlv",
    },
    {
        type = "go",
        name = "Run lsif-go-imports in smol_go",
        request = "launch",
        showLog = true,
        program = "./cmd/lsif-go",
        args = {
            "--no-animation",
        },
        dlvToolPath = vim.fn.exepath "dlv",
    },
}

dap.adapters.php = {
    type = 'executable',
    command = 'php-debug-adapter',
}
local function setPhpEnvironments(php)
    local envsList = {
        ["root"] = "www",
        ["develop"] = "www_develop",
        ["switch"] = "www_switch",
        ["task"] = "www_task",
    }
    for key, value in pairs(envsList) do
        local item = {
            type = 'php',
            request = 'launch',
            name = 'Docker: API Debug - ' .. key,
            pathMappings = {
                ['/var/envs/' .. value] = "${workspaceFolder}",
            },
            cwd = "${workspaceFolder}",
            port = 9200,
        }
        table.insert(php, item)
    end
    return ret
end

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
setPhpEnvironments(dap.configurations.php)

local map = function(lhs, rhs, desc)
    if desc then
        desc = "[DAP] " .. desc
    end

    vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
end


map("<F1>", require("dap").step_back, "step_back")
map("<F2>", require("dap").step_into, "step_into")
map("<F3>", require("dap").step_over, "step_over")
map("<F4>", require("dap").step_out, "step_out")
map("<F5>", require("dap").continue, "continue")

-- TODO:
-- disconnect vs. terminate

map("<leader>dr", require("dap").repl.open)

map("<leader>db", require("dap").toggle_breakpoint)
map("<leader>dB", function()
    require("dap").set_breakpoint(vim.fn.input "[DAP] Condition > ")
end)

map("<leader>de", require("dapui").eval)
map("<leader>dE", function()
    require("dapui").eval(vim.fn.input "[DAP] Expression > ")
end)

-- You can set trigger characters OR it will default to '.'
-- You can also trigger with the omnifunc, <c-x><c-o>
vim.cmd [[
augroup DapRepl
  au!
  au FileType dap-repl lua require('dap.ext.autocompl').attach()
augroup END
]]

local dap_ui = require "dapui"

local _ = dap_ui.setup {
    layouts = {
        {
            elements = {
                "scopes",
                "breakpoints",
                "stacks",
                "watches",
            },
            size = 40,
            position = "left",
        },
        {
            elements = {
                "repl",
                "console",
            },
            size = 10,
            position = "bottom",
        },
    },
    -- -- You can change the order of elements in the sidebar
    -- sidebar = {
    --   elements = {
    --     -- Provide as ID strings or tables with "id" and "size" keys
    --     {
    --       id = "scopes",
    --       size = 0.75, -- Can be float or integer > 1
    --     },
    --     { id = "watches", size = 00.25 },
    --   },
    --   size = 50,
    --   position = "left", -- Can be "left" or "right"
    --
    --
    -- },
    --
    -- tray = {
    --   elements = {},
    --   size = 15,
    --   position = "bottom", -- Can be "bottom" or "top"
    -- },
}

local original = {}
local debug_map = function(lhs, rhs, desc)
    local keymaps = vim.api.nvim_get_keymap "n"
    original[lhs] = vim.tbl_filter(function(v)
        return v.lhs == lhs
    end, keymaps)[1] or true

    vim.keymap.set("n", lhs, rhs, { desc = desc })
end

local debug_unmap = function()
    for k, v in pairs(original) do
        if v == true then
            vim.keymap.del("n", k)
        else
            local rhs = v.rhs

            v.lhs = nil
            v.rhs = nil
            v.buffer = nil
            v.mode = nil
            v.sid = nil
            v.lnum = nil

            vim.keymap.set("n", k, rhs, v)
        end
    end

    original = {}
end

dap.listeners.after.event_initialized["dapui_config"] = function()
    debug_map("asdf", ":echo 'hello world<CR>", "showing things")

    dap_ui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
    debug_unmap()

    dap_ui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
    dap_ui.close()
end

local ok, dap_go = pcall(require, "dap-go")
if ok then
    dap_go.setup()
end
