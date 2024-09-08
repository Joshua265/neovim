require("cyberdream").setup({
    -- Enable transparent background
    transparent = false,

    -- Enable italics comments
    italic_comments = true,

    -- Replace all fillchars with ' ' for the ultimate clean look
    hide_fillchars = false,

    -- Modern borderless telescope theme - also applies to fzf-lua
    borderless_telescope = true,

    -- Set terminal colors used in `:terminal`
    terminal_colors = true,

    -- Use caching to improve performance - WARNING: experimental feature - expect the unexpected!
    -- Early testing shows a 60-70% improvement in startup time. YMMV. Disables dynamic light/dark theme switching.
    cache = false,

    -- Disable or enable colorscheme extensions
    extensions = {
        telescope = true,
	cmp = true
    },
})

vim.cmd("colorscheme cyberdream")
