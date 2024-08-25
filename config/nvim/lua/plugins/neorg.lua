return {
	-- {
	-- 	"nvim-neorg/neorg",
	-- 	build = ":Neorg sync-parsers",
	-- 	dependencies = {
	-- 		{ "nvim-lua/plenary.nvim" },
	-- 		{ "luarocks.nvim" },
	-- 		{
	-- 			-- YOU ALMOST CERTAINLY WANT A MORE ROBUST nvim-treesitter SETUP
	-- 			-- see https://github.com/nvim-treesitter/nvim-treesitter
	-- 			"nvim-treesitter/nvim-treesitter",
	-- 			opts = {
	-- 				auto_install = true,
	-- 				highlight = {
	-- 					enable = true,
	-- 					additional_vim_regex_highlighting = false,
	-- 				},
	-- 			},
	-- 			config = function(_, opts)
	-- 				require("nvim-treesitter.configs").setup(opts)
	-- 			end,
	-- 		},
	-- 	},
	-- 	config = function()
	-- 		require("core.neorg")
	--
	-- 		vim.wo.foldlevel = 99
	-- 		vim.wo.conceallevel = 2
	-- 	end,
	-- },
	--
	-- {
	-- 	"rebelot/kanagawa.nvim", -- neorg needs a colorscheme with treesitter support
	-- 	config = function()
	-- 		vim.cmd.colorscheme("kanagawa")
	-- 	end,
	-- },
	{
		"lukas-reineke/headlines.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = true, -- or `opts = {}`
	},
	{
		"akinsho/org-bullets.nvim",
		config = function()
			require("org-bullets").setup({
				concealcursor = false, -- If false then when the cursor is on a line underlying characters are visible
				symbols = {
					-- list symbol
					list = "•",
					-- headlines can be a list
					headlines = { "◉", "○", "✸", "✿" },
					-- or a function that receives the defaults and returns a list
					-- headlines = function(default_list)
					-- 	table.insert(default_list, "♥")
					-- 	return default_list
					-- end,
					-- or false to disable the symbol. Works for all symbols
					-- headlines = false,
					checkboxes = {
						half = { "", "OrgTSCheckboxHalfChecked" },
						done = { "✓", "OrgDone" },
						todo = { "˟", "OrgTODO" },
					},
				},
			})
		end,
	},
	{
		"nvim-orgmode/orgmode",
		event = "VeryLazy",
		ft = { "org" },
		config = function()
			require("orgmode").setup({})

			-- Tree-sitter configuration
			require("nvim-treesitter.configs").setup({
				-- If TS highlights are not enabled at all, or disabled via ``disable`` prop, highlighting will fallback to default Vim syntax highlighting
				highlight = {
					enable = true,
					disable = { "org" }, -- Remove this to use TS highlighter for some of the highlights (Experimental)
					additional_vim_regex_highlighting = { "org" }, -- Required since TS highlighter doesn't support all syntax features (conceal)
				},
				ensure_installed = { "org" }, -- Or run :TSUpdate org
			})

			require("orgmode").setup({
				org_todo_keywords = { "TODO", "WAITING", "|", "DONE", "DELEGATED" },
				org_todo_keyword_faces = {
					WAITING = ":foreground blue :weight bold",
					DELEGATED = ":background #FFFFFF :slant italic :underline on",
					TODO = ":background #000000 :foreground red", -- overrides builtin color for `TODO` keyword
				},
				org_agenda_files = { "~/notes/agenda/**/*" },
				org_default_notes_file = "~/note/file.org",
				org_hide_leading_stars = true,
				org_hide_emphasis_markers = true,
				win_split_mode = "vsplit",
			})
		end,
	},
}
