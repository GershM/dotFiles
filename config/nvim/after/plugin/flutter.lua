local has_flutter_tools = pcall(require, "flutter-tools")
if not has_flutter_tools then
  return
end

local custom_lsp = require "core.lsp"

require("flutter-tools").setup {
  debugger = {
    enabled = true,
  },

  widget_guides = {
    enabled = true,
  },

  closing_tags = {
    enabled = true,
    -- format = " </%s>",
    -- prefix = "~~ "
  },

  lsp = {
    on_attach = custom_lsp.on_attach,
    capabilities = custom_lsp.capabilities,
  },
}
