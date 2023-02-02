local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Setup nvim-cmp.
local null_ls = require("null-ls")
local cmp = require("cmp")
local luasnip = require("luasnip")
local types = require("luasnip.util.types")

local source_mapping = {
    nvim_lsp = "[LSP]",
    nvim_lua = "[Lua]",
    path = "[Path]",
    buffer = "[Buffer]",
    neorg = "[Neorg]",
}

local cmp_kinds = {
    Text = '  ',
    Method = '  ',
    Function = '  ',
    Constructor = '  ',
    Field = '  ',
    Variable = '  ',
    Class = '  ',
    Interface = '  ',
    Module = '  ',
    Property = '  ',
    Unit = '  ',
    Value = '  ',
    Enum = '  ',
    Keyword = '  ',
    Snippet = '  ',
    Color = '  ',
    File = '  ',
    Reference = '  ',
    Folder = '  ',
    EnumMember = '  ',
    Constant = '  ',
    Struct = '  ',
    Event = '  ',
    Operator = '  ',
    TypeParameter = '  ',
}

luasnip.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { " « ", "NonTest" } },
            },
        },
    },
})

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        -- ['<Tab>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm(), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind
            vim_item.menu = source_mapping[entry.source.name]

            return vim_item
        end,
    },
    -- Show borders like the LSP autocomplte
    window = {
        documentation = {
            border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
        },
    },
    sources = {
        --{ name = "orgmode" },
        { name = "neorg" },
        { name = "nvim_lsp", option = { show_autosnippets = true } },
        { name = "luasnip", option = { show_autosnippets = true } },
        { name = "buffer" },
    },
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

local function config(_config)
    return vim.tbl_deep_extend("force", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities),
        on_attach = function()
            LspKeyMap()
        end,
    }, _config or {})
end

-- Pass configurations settings to the different LSP's
local settings = {
    sumneko_lua = {
        Lua = {
            completion = {
                callSnippet = "Replace"
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim", "nvim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                },
            },
        },
    },
    intelephense = {
        stubs = {
            "apache", "bcmath", "bz2", "calendar", "com_dotnet", "Core", "ctype", "curl", "date", "dba", "dom", "enchant",
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
    },
    tsserver = {
        diagnostics = {
            enable = true,
        },
    },
    json = {
        schemas = {
            {
                description = "NPM configuration file",
                fileMatch = {
                    "package.json",
                },
                url = "https://json.schemastore.org/package.json",
            },
        },
    },
}
require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

require("mason-lspconfig").setup({})

require("mason-lspconfig").setup_handlers({
  function (server_name)
      require("lspconfig")[server_name].setup(config(settings))
  end,
})

null_ls.setup({ })

vim.diagnostic.config({
    float = {
        border = "rounded",
    },
})
