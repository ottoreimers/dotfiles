require("blink.cmp").setup({
    keymap = {
        preset = "default",
        ['<CR>'] = { 'accept', 'fallback' },
        ["<Tab>"] = {
            "snippet_forward",
            function()
                return require("sidekick").nes_jump_or_apply()
            end,
            function()
                if vim.lsp.inline_completion then
                    return vim.lsp.inline_completion.get()
                end
            end,
            "fallback",
        },
    },
    appearance = {
        nerd_font_variant = "mono",
    },
    sources = {
        default = { "lsp", "path", "snippets", "buffer", "copilot" },
        providers = {
            copilot = {
                name = "copilot",
                module = "blink-cmp-copilot",
                score_offset = 100,
                async = true,
            },
        },
    },
    completion = {
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,
        },
        menu = {
            border = "rounded",
        },
    },
})
