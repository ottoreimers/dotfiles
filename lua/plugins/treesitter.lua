local ts = require("nvim-treesitter")
ts.setup({})

local languages = { "lua", "javascript", "typescript" }
ts.install(languages)

-- Enable treesitter highlighting for the installed languages
vim.api.nvim_create_autocmd("FileType", {
	pattern = languages,
	callback = function(ev)
		pcall(vim.treesitter.start, ev.buf)
	end,
})
