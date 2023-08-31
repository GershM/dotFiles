require("core.set")
require("core.packer")
require("core.telescope")
require("core.lualine")
require("core.nvimtree")
require("core.debugger")
require("core.git")
require("core.colorizer")
require("core.neotest")
require("core.comment")
-- require("core.colors")
require("core.sidebar")
require("core.markdownPreview")

vim.cmd.colorscheme("tokyonight-moon")

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

local signs = { Error = "✗ ", Warning = " ", Hint = " ", Information = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
