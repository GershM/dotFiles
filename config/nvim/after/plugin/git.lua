local ok, neogit = pcall(require, "neogit")
if not ok then
    return
end

local nmap = require("core.keymap").nmap
local builtin = require('telescope.builtin')

neogit.setup {
    integrations = {
        diffview = true,
    },
}

nmap { "<space>vv", ":DiffviewOpen " }
nmap { "<leader>gs", neogit.open }
nmap { "<leader>gc", function() neogit.open { "commit" } end }
nmap { '<leader>gb', function() builtin.git_branches() end }
