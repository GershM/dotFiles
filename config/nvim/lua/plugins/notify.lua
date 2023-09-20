return {
    {
        "rcarriga/nvim-notify",
        lazy = false,
        config = function()
            local n = require("notify")
            n.setup({
                background_colour = "#000000",
                fps = 30,
                icons = {
                    DEBUG = "",
                    ERROR = "",
                    INFO = "",
                    TRACE = "✎",
                    WARN = ""
                },
                level = 2,
                minimum_width = 50,
                max_width = 100,
                render = "wrapped-compact",
                stages = "slide",
                timeout = 5000,
                top_down = true
            })

            local log = require("plenary.log").new {
                plugin = "notify",
                level = "debug",
                use_console = false,
            }

            ---@diagnostic disable-next-line: duplicate-set-field
            vim.notify = function(msg, level, opts)
                log.info(msg, level, opts)
                if string.find(msg, "method .* is not supported") then
                    return
                end

                P(opts)
                opts = opts or {}
                msg = msg or {}

                local on_open = function(win)
                    local buf = vim.api.nvim_win_get_buf(win)
                    vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
                end

                table.insert(opts, on_open)
                n.notify(msg, level, opts)
            end
        end,
        cond = function()
            if not pcall(require, "plenary") then
                return false
            end
            return true
        end,
    }
}
