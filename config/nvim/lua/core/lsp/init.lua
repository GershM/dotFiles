local neodev = vim.F.npcall(require, "neodev")
if neodev then
    neodev.setup {
        override = function(_, library)
            library.enabled = true
            library.plugins = true
        end,
        lspconfig = true,
        pathStrict = true,
    }
end

local lspconfig = vim.F.npcall(require, "lspconfig")
if not lspconfig then
    return
end

local imap = require("core.keymap").imap
local nmap = require("core.keymap").nmap
local autocmd = require("core.auto").autocmd
local autocmd_clear = vim.api.nvim_clear_autocmds


local telescope_mapper = require "core.telescope.mappings"
local handlers = require "core.lsp.handlers"

-- local ts_util = require "nvim-lsp-ts-utils"

local custom_init = function(client)
    client.config.flags = client.config.flags or {}
    client.config.flags.allow_incremental_sync = true
end

local augroup_highlight = vim.api.nvim_create_augroup("custom-lsp-references", { clear = true })
local augroup_codelens = vim.api.nvim_create_augroup("custom-lsp-codelens", { clear = true })
local augroup_format = vim.api.nvim_create_augroup("custom-lsp-format", { clear = true })
-- local augroup_semantic = vim.api.nvim_create_augroup("custom-lsp-semantic", { clear = true })

local autocmd_format = function(async, filter)
    vim.api.nvim_clear_autocmds { buffer = 0, group = augroup_format }
    vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = 0,
        callback = function()
            vim.lsp.buf.format { async = async, filter = filter }
        end,
    })
end

local filetype_attach = setmetatable({
    typescript = function()
        autocmd_format(false, function(client)
            return client.name ~= "tsserver"
        end)
    end,

    javascript = function()
        autocmd_format(false, function(client)
            return client.name ~= "tsserver"
        end)
    end,
}, {
    __index = function()
        return function() end
    end,
})

local buf_nnoremap = function(opts)
    if opts[3] == nil then
        opts[3] = {}
    end
    opts[3].buffer = 0

    nmap(opts)
end

local buf_inoremap = function(opts)
    if opts[3] == nil then
        opts[3] = {}
    end
    opts[3].buffer = 0

    imap(opts)
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities.textDocument.completion.completionItem.snippetSupport = true
updated_capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

-- Completion configuration
vim.tbl_deep_extend("force", updated_capabilities, require("cmp_nvim_lsp").default_capabilities())
updated_capabilities.textDocument.completion.completionItem.insertReplaceSupport = false
local custom_attach = function(client, bufnr)
    local filetype = vim.api.nvim_buf_get_option(0, "filetype")

    local signature_setup = {
        bind = true,     -- This is mandatory, otherwise border config won't get registered.
        handler_opts = {
            border = "rounded"
        }
    }
    require "lsp_signature".on_attach(signature_setup, bufnr)     -- Note: add in lsp client on-attach
    

    buf_inoremap { "<c-s>", vim.lsp.buf.signature_help }

    buf_nnoremap { "<space>t", "<cmd>Lspsaga term_toggle<CR>"  }

    -- buf_nnoremap { "<space>cr", vim.lsp.buf.rename }
    -- buf_nnoremap { "<space>ca", vim.lsp.buf.code_action }
    
    buf_nnoremap { "<space>cr", "<cmd>Lspsaga rename<CR>"  }
    buf_nnoremap { "<space>ca", "<cmd>Lspsaga code_action<CR>"  }
    buf_nnoremap { "<space>ch", "<cmd>Lspsaga incoming_calls<CR>"  }

    buf_nnoremap { "gd", vim.lsp.buf.definition }
    buf_nnoremap { "gD", vim.lsp.buf.declaration }
    buf_nnoremap { "gT", vim.lsp.buf.type_definition }
    -- buf_nnoremap { "K", vim.lsp.buf.hover, { desc = "lsp:hover" } }
     buf_nnoremap { "K", "<cmd>Lspsaga hover_doc<CR>" , { desc = "lsp:hover" } }
    buf_nnoremap { "<space>k", "<cmd>Lspsaga peek_definition<CR>" }

    buf_nnoremap { "<space>gI", handlers.implementation }
    buf_nnoremap { "<space>lr", "<cmd>lua R('core.lsp.codelens').run()<CR>" }
    buf_nnoremap { "<space>rr", "LspRestart" }

    telescope_mapper("gr", "lsp_references", nil, true)
    telescope_mapper("gi", "lsp_implementations", nil, true)
    telescope_mapper("<space>wd", "lsp_document_symbols", { ignore_filename = true }, true)
    telescope_mapper("<space>ww", "lsp_dynamic_workspace_symbols", { ignore_filename = true }, true)

    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.documentHighlightProvider then
        autocmd_clear { group = augroup_highlight, buffer = bufnr }
        autocmd { "CursorHold", augroup_highlight, vim.lsp.buf.document_highlight, bufnr }
        autocmd { "CursorMoved", augroup_highlight, vim.lsp.buf.clear_references, bufnr }
    end

    if false and client.server_capabilities.codeLensProvider then
        if filetype ~= "elm" then
            autocmd_clear { group = augroup_codelens, buffer = bufnr }
            autocmd { "BufEnter", augroup_codelens, vim.lsp.codelens.refresh, bufnr, once = true }
            autocmd { { "BufWritePost", "CursorHold" }, augroup_codelens, vim.lsp.codelens.refresh, bufnr }
        end
    end

    if filetype == "typescript" or filetype == "lua" then
        client.server_capabilities.semanticTokensProvider = nil
    end

    -- Attach any filetype specific options to the client
    filetype_attach[filetype]()
end
updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }

local servers = {
    -- Also uses `shellcheck` and `explainshell`
    bashls = true,
    lua_ls = {
        settings = {
            completion = {
                callSnippet = "Replace"
            },
            Lua = {
                hint = {
                    enable = true,
                },
                diagnostics = {
                    globals = { 'vim', "nvim" }
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                    },
                },
            }
        }
    },

    eslint = true,
    gdscript = true,
    -- graphql = true,
    html = true,
    pyright = true,
    vimls = true,
    yamlls = true,

    -- Enable jsonls with json schemas
    jsonls = {
        settings = {
            json = {
                validate = { enable = true },
            },
        },
    },

    gopls = {
        on_attach = function(client, bufnr)
            custom_attach(client, bufnr)
        end,
        settings = {
            gopls = {
                codelenses = { test = true },
                hints = {
                    assignVariableTypes = true,
                    compositeLiteralFields = true,
                    compositeLiteralTypes = true,
                    constantValues = true,
                    functionTypeParameters = true,
                    parameterNames = true,
                    rangeVariableTypes = true,
                },
            },
        },

        flags = {
            debounce_text_changes = 200,
        },
    },

    cssls = true,

    tsserver = {
        filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
        },
        settings = {
            javascript = {
                inlayHints = {
                    includeInlayEnumMemberValueHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                    includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayVariableTypeHints = true,
                }
            },
            typescript = {
                inlayHints = {
                    includeInlayEnumMemberValueHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                    includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayVariableTypeHints = true,
                }
            }
        },
        on_attach = function(client, bufnr)
            custom_attach(client, bufnr)
        end,
    },
    intelephense = {
        on_attach = function(client, bufnr)
            custom_attach(client, bufnr)
        end,
        stubs = {
            "apache", "bcmath", "bz2", "calendar", "com_dotnet", "Core", "ctype", "curl", "date", "dba", "dom",
            "enchant",
            "exif", "FFI", "fileinfo", "filter", "fpm", "ftp", "gd", "gettext", "gmp", "hash", "iconv", "imap", "intl",
            "json", "ldap", "libxml", "mbstring", "meta", "mysqli", "oci8", "odbc", "openssl", "pcntl", "pcre", "PDO",
            "pdo_ibm", "pdo_mysql", "pdo_pgsql", "pdo_sqlite", "pgsql", "Phar", "posix", "pspell", "readline",
            "Reflection", "session", "shmop", "SimpleXML", "snmp", "soap", "sockets", "sodium", "SPL", "sqlite3",
            "standard", "superglobals", "sysvmsg", "sysvsem", "sysvshm", "tidy", "tokenizer", "xml", "xmlreader",
            "xmlrpc", "xmlwriter", "xsl", "ZendOPcache", "zip", "zlib"
        },
        environment = {
            shortOpenTag = true
        },
        completion = {
            fullyQualifyGlobalConstantsAndFunctions = true,
        },
        diagnostics = {
            enable = true,
        },
    }
}

-- Can remove later if not installed (TODO: enable for not linux)
if vim.fn.executable "tree-sitter-grammar-lsp-linux" == 1 then
    vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
        pattern = { "grammar.js", "*/corpus/*.txt" },
        callback = function()
            vim.lsp.start {
                name = "tree-sitter-grammar-lsp",
                cmd = { "tree-sitter-grammar-lsp-linux" },
                root_dir = "/",
                capabilities = updated_capabilities,
                on_attach = custom_attach,
            }
        end,
    })
end

require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "tsserver", "intelephense", "gopls", "jsonls" },
}

local setup_server = function(server, config)
    if not config then
        return
    end

    if type(config) ~= "table" then
        config = {}
    end

    config = vim.tbl_deep_extend("force", {
        on_init = custom_init,
        on_attach = custom_attach,
        capabilities = updated_capabilities,
    }, config)

    lspconfig[server].setup(config)
end

for server, config in pairs(servers) do
    setup_server(server, config)
end

require("null-ls").setup {
    sources = {
        -- require("null-ls").builtins.formatting.stylua,
        -- require("null-ls").builtins.diagnostics.eslint,
        -- require("null-ls").builtins.completion.spell,
        -- require("null-ls").builtins.diagnostics.selene,
        require("null-ls").builtins.formatting.prettierd,
        require("null-ls").builtins.formatting.isort,
        require("null-ls").builtins.formatting.black,
    },
}

nmap { "<leader>cf", function() vim.lsp.buf.format() end }

return {
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = updated_capabilities,
}
