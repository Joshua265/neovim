local opt = { noremap = true }
local telescope = require("telescope")
telescope.setup({})
telescope.load_extension("recent_files")
vim.api.nvim_set_keymap("n", "<leader>ff", ":lua require('telescope.builtin').find_files()<CR>", opt)
vim.api.nvim_set_keymap("n", "<leader><leader>", ":lua require('telescope').extensions.recent_files.pick()<CR>", opt)
vim.api.nvim_set_keymap("n", "<C-p>", ":lua require('telescope.builtin').git_files()<CR>", opt
vim.api.nvim_set_keymap("n", "<leader>s", ":lua function() require('telescope.builtin').grep_string({ search = vim.fn.input('Grep > ') }) end()<CR>", opt)
