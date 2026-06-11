require("lualine").setup({
    -- options = {
    --     theme = "catppuccin-nvim",
    -- },
    sections = {
        lualine_c = {
            -- Copilot status
            {
                function()
                    return " "
                end,
                color = function()
                    local status = require("sidekick.status").get()
                    if status then
                        return status.kind == "Error" and "DiagnosticError" or status.busy and "DiagnosticWarn" or "Special"
                    end
                end,
                cond = function()
                    local status = require("sidekick.status")
                    return status.get() ~= nil
                end,
            },
        },
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
