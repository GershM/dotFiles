--godot.lua
local ok, godot = pcall(require, "godot")
if not ok then
	return
end


-- default config
local config = {
-- 	bin = "godot",
-- 	gui = {
-- 		console_config = @config for vim.api.nvim_open_win
-- 	},
}

godot.setup(config)

local function map(m, k, v)
	vim.keymap.set(m, k, v, { silent = true })
end

map("n", "<leaderleader>dr", godot.debugger.debug)
map("n", "<leaderleader>dd", godot.debugger.debug_at_cursor)
map("n", "<leaderleader>dq", godot.debugger.quit)
map("n", "<leaderleader>dc", godot.debugger.continue)
map("n", "<leaderleader>ds", godot.debugger.step)
