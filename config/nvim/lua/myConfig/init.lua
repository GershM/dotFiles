require("myConfig.set")
require("myConfig.packer")
require("myConfig.telescope")
require("myConfig.lualine")
require("myConfig.nvimtree")
require("myConfig.debugger")
require("myConfig.git")
require("myConfig.colorizer")
require("myConfig.neotest")
require("myConfig.neorg")
require("myConfig.comment")
require("myConfig.dashboard")
require("myConfig.colors")
require("myConfig.sidebar")


--vim.cmd.colorscheme("tokyonight-moon")

require("deploy").setup()
-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
