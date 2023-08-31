require("core.require")
require("core.sets")
require("core.globals")
require("core.lualine")
--require("core.neotest")

-- vim.cmd.colorscheme("darksolar")
-- vim.cmd.colorscheme("mariana_lighter")
-- vim.cmd.colorscheme("dracula")
vim.cmd.colorscheme("moonlight")
-- 


-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`

local signs = { Error = "✗ ", Warning = " ", Hint = " ", Information = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
