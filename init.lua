vim.wo.number = true
vim.wo.relativenumber = true
require("vim-cmd-options")

-- Rebuild treesitter parsers when the plugin itself is updated
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		if ev.data.spec.name == "nvim-treesitter" and ev.data.kind == "update" then
			vim.schedule(function()
				vim.cmd("TSUpdate")
			end)
		end
	end,
})

vim.pack.add({
	-- libs
	"https://github.com/nvim-lua/plenary.nvim", -- harpoon dependency
	-- icons / ui libs
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/echasnovski/mini.icons",
	"https://github.com/SmiteshP/nvim-navic",
	-- completion
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/saghen/blink.lib",
	"https://github.com/giuxtaposition/blink-cmp-copilot",
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
	"https://github.com/zbirenbaum/copilot.lua",
	-- lsp
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/j-hui/fidget.nvim",
	-- treesitter
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	"https://github.com/Wansmer/treesj",
	-- editing
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/kylechui/nvim-surround",
	"https://github.com/ThePrimeagen/harpoon",
	"https://github.com/stevearc/oil.nvim",
	-- git
	"https://github.com/tpope/vim-fugitive",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/sindrets/diffview.nvim",
	-- ui
	"https://github.com/utilyre/barbecue.nvim",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/folke/snacks.nvim",
	"https://github.com/folke/trouble.nvim",
	"https://github.com/folke/which-key.nvim",
	"https://github.com/folke/sidekick.nvim",
})

-- Plugin setup. blink must come before lsp-config (capabilities).
require("plugins.mini-icons")
require("plugins.nvim-webdev-icons")
require("plugins.blink")
require("plugins.copilot")
require("plugins.lsp-config")
require("plugins.fidget")
require("plugins.treesitter")
require("plugins.treesj")
require("plugins.formatting")
require("plugins.nvim-surround")
require("plugins.harpoon")
require("plugins.oil")
require("plugins.vim-fugitive")
require("plugins.barbecue")
require("plugins.lualine")
require("plugins.snacks")
require("plugins.trouble")
require("plugins.which-key")
require("plugins.sidekick")
