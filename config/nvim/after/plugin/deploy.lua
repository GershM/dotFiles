local ok, deploy = pcall(require, "deploy")
if not ok then
  return
end
deploy.setup()

local nmap = require("core.keymap").nmap

nmap{"<leader>uf", function() vim.cmd.Deploy("upload") end}
nmap{"<leader>uF", function() vim.cmd.Deploy("upload force") end}
nmap{"<leader>ud", function() vim.cmd.Deploy("download") end}
nmap{"<leader>uD", function() vim.cmd.Deploy("download force") end}
nmap{"<leader>us", function() vim.cmd.Deploy("remotesync") end}
nmap{"<leader>uS", function() vim.cmd.Deploy("remotesync force") end}
nmap{"<leader>ur", function() vim.cmd.Deploy("exec") end}
nmap{"<leader>uR", function() vim.cmd.Deploy("exec force") end}
nmap{"<leader>uc", function() vim.cmd.Deploy("connect") end}
nmap{"<leader>uC", function() vim.cmd.Deploy("connect force") end}
