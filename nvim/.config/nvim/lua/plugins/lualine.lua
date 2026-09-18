require("lualine").setup({
    -- options = {
    --     theme = "catppuccin-nvim",
    -- },
    sections = {
        lualine_x = {
            -- CLI session status
            {
                function()
                    local status = require("sidekick.status").cli()
                    return " " .. (#status > 1 and #status or "")
                end,
                cond = function()
                    return #require("sidekick.status").cli() > 0
                end,
                color = function()
                    return "Special"
                end,
            },
        },
    },
})
