require("harpoon").setup({
	-- options
})

vim.keymap.set("n", "<leader>af", "<cmd>lua require('harpoon.mark').add_file()<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>am", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", { noremap = true, silent = true })
-- nav to marked files
vim.keymap.set("n", "<leader>a1", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>a2", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>a3", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>a4", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", { noremap = true, silent = true })
-- nav between files
vim.keymap.set("n", "<C-s>", "<cmd>lua require('harpoon.ui').nav_next()<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-d>", "<cmd>lua require('harpoon.ui').nav_prev()<cr>", { noremap = true, silent = true })
