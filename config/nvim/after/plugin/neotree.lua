
local nmap = require("core.keymap").nmap

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
        adaptive_size = true,
        mappings = {
            list = {
                { key = "u", action = "dir_up" },
                { key = "o", action = "cd" },
            },
        },
        -- side = "right"
    },
    renderer = {
        group_empty = false,
    },
    filters = {
        dotfiles = true,
    },
})

nmap { "<leader>nt", function() vim.cmd.NvimTreeToggle() end }
