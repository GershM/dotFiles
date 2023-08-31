local nmap = require("core.keymap").nmap
nmap { "<leader>nu", function() vim.cmd.UndotreeToggle() end }
