local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Setup nvim-cmp.
local null_ls = require("null-ls")
local cmp = require("cmp")
local luasnip = require("luasnip")
local types = require("luasnip.util.types")
local navic = require("nvim-navic")

local source_mapping = {
    nvim_lsp = "[LSP]",
    nvim_lua = "[Lua]",
    path = "[Path]",
    buffer = "[Buffer]",
    neorg = "[Neorg]",
}

navic.setup {
    icons = {
        File = ' ',
        Module = ' ',
        Namespace = ' ',
        Package = ' ',
        Class = ' ',
        Method = ' ',
        Property = ' ',
        Field = ' ',
        Constructor = ' ',
        Enum = ' ',
        Interface = ' ',
        Function = ' ',
        Variable = ' ',
        Constant = ' ',
        String = ' ',
        Number = ' ',
        Boolean = ' ',
        Array = ' ',
        Object = ' ',
        Key = ' ',
        Null = ' ',
        EnumMember = ' ',
        Struct = ' ',
        Event = ' ',
        Operator = ' ',
        TypeParameter = ' '
    }
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
        ['<C-b>'] = cmp.mapping.scroll_docs( -4),
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
        { name = "luasnip",  option = { show_autosnippets = true } },
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
        on_attach = function(client, bufnr)
            navic.attach(client, bufnr)
            LspKeyMap()
        end
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
    ["rust-analyzer"] = {
        assist = {
            importEnforceGranularity = true,
            importPrefix = "crate"
        },
        cargo = {
            allFeatures = true
        },
        checkOnSave = {
            -- default: `cargo check`
            command = "clippy"
        },
    }
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

require("mason-lspconfig").setup({
    ensure_installed = { "tsserver", "intelephense" },
    automatic_installation = true
})

require("mason-lspconfig").setup_handlers({
    function(server_name)
        require("lspconfig")[server_name].setup(config(settings))
    end,
})

-- null_ls.setup({})
require("mason").setup()
-- require("mason-null-ls").setup({
--     automatic_setup = true,
--     debug = false,
-- })
--
-- require('mason-null-ls').setup_handlers()

vim.diagnostic.config({
    float = {
        border = "rounded",
    },
})

local Path = require('plenary.path')
require('cmake').setup({
    cmake_executable = 'cmake', -- CMake executable to run.
    save_before_build = true, -- Save all buffers before building.
    parameters_file = 'neovim.json', -- JSON file to store information about selected target, run arguments and build type.
    default_parameters = { args = {}, build_type = 'Debug' }, -- The default values in `parameters_file`. Can also optionally contain `run_dir` with the working directory for applications.
    build_dir = tostring(Path:new('{cwd}', 'build', '{os}-{build_type}')), -- Build directory. The expressions `{cwd}`, `{os}` and `{build_type}` will be expanded with the corresponding text values. Could be a function that return the path to the build directory.
    -- samples_path = tostring(script_path:parent():parent():parent() / 'samples'), -- Folder with samples. `samples` folder from the plugin directory is used by default.
    default_projects_path = tostring(Path:new(vim.loop.os_homedir(), 'myProjects')), -- Default folder for creating project.
    configure_args = { '-D', 'CMAKE_EXPORT_COMPILE_COMMANDS=1' }, -- Default arguments that will be always passed at cmake configure step. By default tells cmake to generate `compile_commands.json`.
    build_args = {}, -- Default arguments that will be always passed at cmake build step.
    on_build_output = nil, -- Callback that will be called each time data is received by the current process. Accepts the received data as an argument.
    quickfix = {
        pos = 'botright', -- Where to open quickfix
        height = 10, -- Height of the opened quickfix.
        only_on_error = false, -- Open quickfix window only if target build failed.
    },
    copy_compile_commands = true, -- Copy compile_commands.json to current working directory.
    -- dap_configurations = { -- Table of different DAP configurations.
    --     lldb_vscode = { type = 'lldb', request = 'launch' },
    --     cppdbg_vscode = { type = 'cppdbg', request = 'launch' },
    -- },
    dap_configuration = 'lldb_vscode', -- DAP configuration to use if the projects `parameters_file` does not specify one.
    dap_open_command = function(...) require('dap').repl.open(...) end, -- Command to run after starting DAP session. You can set it to `false` if you don't want to open anything or `require('dapui').open` if you are using https://github.com/rcarriga/nvim-dap-ui
})
