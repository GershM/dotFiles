if vim.g.neovide then
	vim.g.neovide_cursor_trail_legnth = 0
	vim.g.neovide_cursor_animation_length = 0
	vim.o.guifont = "Jetbrains Mono"
end

-- Leader key -> ","
--
-- In general, it's a good idea to set this early in your config, because otherwise
-- if you have any mappings you set BEFORE doing this, they will be set to the OLD
-- leader.
vim.g.mapleader = ","
vim.g.maplocalleader = " "

-- vim.cmd('language en_US.utf8')
vim.opt.conceallevel = 2
vim.opt.concealcursor = 'nc'

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	}
end

vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup("plugins", {
	root = "~/plugins",
	ui = {
		icons = {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			source = "📄",
			start = "🚀",
			task = "📌",
		},
	},
})

require("core")
