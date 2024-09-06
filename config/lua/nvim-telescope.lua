local opt = { noremap = true }
local telescope = require("telescope")
telescope.setup({})
telescope.load_extension("recent_files")
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>pf", builtin.find_files, opt)
vim.keymap.set("n", "<leader>pg", builtin.live_grep, opt)
vim.keymap.set("n", "<C-p>", builtin.git_files, opt)
vim.keymap.set("n", "<leader>ps", function()
  builtin.grep_string({
    search = vim.fn.input("Grep string > "),
  })
end, opt)
