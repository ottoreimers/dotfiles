require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        scss = { "prettierd", "prettier", stop_after_first = true },
        sass = { "prettierd", "prettier", stop_after_first = true },
        php = { "php_cs_fixer" },
        -- Django templates
        htmldjango = { "djlint" },
    },
    -- format_on_save = {
    --     timeout_ms = 500,
    --     lsp_fallback = true,
    -- },
    -- Installera formatters automatiskt via Mason
    formatters = {
        stylua = {
            command = "stylua",
            args = { "--stdin-filepath", "$FILENAME", "-" },
            stdin = true,
        },
    },
})

-- Keybinding för manuell formattering
vim.keymap.set({ "n", "v" }, "<leader>ff", function()
    require("conform").format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
    })
end, { desc = "Format file or range (in visual mode)" })
