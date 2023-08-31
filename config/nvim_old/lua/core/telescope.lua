require("telescope").setup({
	defaults = {
		preview = true,
		file_ignore_patterns = { ".*node_modules/.*", ".*vendor/.*" },
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			},
		},
	},
	-- pickers = {
	-- 	find_files = {
	-- 		theme = "ivy",
	-- 	},
	-- 	live_grep = {
	-- 		theme = "ivy",
	-- 	},
	-- 	help_tags = {
	-- 		theme = "dropdown",
	-- 	},
	-- 	grep_string = {
	-- 		theme = "ivy",
	-- 	},
	-- 	oldfiles = {
	-- 		theme = "dropdown",
	-- 	},
	-- 	buffers = {
	-- 		theme = "ivy",
	-- 	},
	-- 	git_status = {
	-- 		theme = "dropdown",
	-- 	},
	-- 	git_branches = {
	-- 		theme = "ivy",
	-- 	},
	-- 	lsp_references = {
	-- 		theme = "dropdown",
	-- 	},
	-- 	diagnostics = {
	-- 		theme = "ivy",
	-- 	},
	-- 	lsp_document_symbols = {
	-- 		theme = "dropdown",
	-- 	},
	-- 	lsp_dynamic_workspace_symbols = {
	-- 		theme = "ivy",
	-- 	},
	-- },
	extensions = {
		project = {
			hidden_files = true, -- default: false
			theme = "dropdown",
			order_by = "asc",
			search_by = "title",
			sync_with_nvim_tree = true, -- default false
		},
		file_browser = {
			theme = "ivy",
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = false,
		},
	},
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("project")

--require("telescope").load_extension("git_worktree")
