vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set textwidth=80")
vim.smartindent = true
vim.smarttab = true
vim.backspace = "indent,eol,start"
vim.g.mapleader = " "

vim.opt.mouse = "a"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = false

-- Paste and auto-reindent the pasted text to match surrounding code
vim.keymap.set("n", "p", "p`[v`]=")
vim.keymap.set("n", "P", "P`[v`]=")
