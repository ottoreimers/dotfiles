require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "eslint",
        "ts_ls",
        "pylsp", -- Python/Django
        -- "basedpyright", -- Python/Django
        "cssls",        -- CSS/SCSS/SASS/LESS
    },
})

local capabilities = require("blink.cmp").get_lsp_capabilities()

-- Global LSP keymaps (körs när LSP attached)
local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, silent = true }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    -- Formattering hanteras nu av conform.nvim istället
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
end

-- Server configs
vim.lsp.config("lua_ls", {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
})

vim.lsp.config("eslint", {
    capabilities = capabilities,
    on_attach = on_attach,
})

vim.lsp.config("ts_ls", {
    capabilities = capabilities,
    on_attach = on_attach,
})

-- Python LSP (pylsp är mindre strikt än basedpyright)
vim.lsp.config("pylsp", {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = { enabled = false }, -- Stäng av style checks
                mccabe = { enabled = false },       -- Stäng av complexity checks
                pyflakes = { enabled = true },      -- Basic error checking
                pylint = { enabled = false },       -- Stäng av pylint
            },
        },
    },
})

-- CSS/SCSS/SASS/LESS LSP
vim.lsp.config("cssls", {
    capabilities = capabilities,
    on_attach = on_attach,
})

-- Enable all configured LSP servers
vim.lsp.enable({ "lua_ls", "eslint", "ts_ls", "pylsp", "cssls" })

-- Diagnostic config
vim.diagnostic.config({
    virtual_text = {
        prefix = "●",
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
            [vim.diagnostic.severity.INFO] = " ",
        }
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})
