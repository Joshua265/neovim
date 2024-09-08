# vim: ft=lua
{
  pkgs
}:
''

local lsp = require("lsp-zero")

lsp.preset("recommended")

local nvim_lsp = require("lspconfig")

nvim_lsp.tsserver.setup({
  init_options = {
    tsserver = {
      path = "${pkgs.nodePackages.typescript}/lib/node_modules/typescript/lib",
    },
  },
})

nvim_lsp.rust_analyzer.setup{}

nvim_lsp.html.setup({
  init_options = {
    nodePath = "${pkgs.nodejs_20}/bin/node",
  },
})

nvim_lsp.jsonls.setup{
  init_options = {
    nodePath = "${pkgs.nodejs_20}/bin/node",
  },
}

nvim_lsp.lua_ls.setup{
  cmd = { "${pkgs.lua-language-server}/bin/lua-language-server" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
  }


nvim_lsp.nixd.setup{
  cmd = { "${pkgs.nixd}/bin/nixd" },
}

lsp.format_on_save()

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  lsp.buffer_autoformat()

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

''
