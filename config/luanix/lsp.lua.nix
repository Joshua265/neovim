# vim: ft=lua
{
  pkgs
}:
''


local lsp = require("lsp-zero")

lsp.preset("recommended")

require('mason').setup({})
local nvim_lsp = require("mason-lspconfig")
nvim_lsp.tsserver.setup({
  init_options = {
    tsserver = {
      path = "${pkgs.nodePackages.typescript}/lib/node_modules/typescript/lib",
    },
  },
})

nvim_lsp.rust_analyzer.setup({})

nvim_lsp.eslint.setup({
  init_options = {
    nodePath = "${pkgs.nodejs_20}/bin/node",
  },
})

nvim_lsp.html.setup({
  init_options = {
    nodePath = "${pkgs.nodejs_20}/bin/node",
  },
})

nvim_lsp.jsonls.setup({
  init_options = {
    nodePath = "${pkgs.nodejs_20}/bin/node",
  },
})

nvim_lsp.lua_ls.setup({
  cmd = { "${pkgs.lua-language-server}/bin/lua-language-server" },
})

nvim_lsp.nixd.setup({
  cmd = { "${pkgs.nixd}/bin/nixd" },
})

#require('mason-lspconfig').setup({
#  -- Replace the language servers listed here
#  -- with the ones you want to install
#  ensure_installed = {'ts_ls', 'rust_analyzer', 'eslint', 'html', 'jsonls', 'lua_ls', 'markdown_oxide', 'nextls', 'nixd', 'pyright', 'terraformls'};
#  handlers = {
#    function(server_name)
#      require('lspconfig')[server_name].setup({})
#    end,
#  }
#})


local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<CR>'] = cmp.mapping.confirm({
      -- documentation says this is important.
      -- I don't know why.
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }),
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

cmp.setup({
  mapping = cmp_mappings,
  sources = {
    { name = 'nvim_lsp' },
    { name = 'copilot' },
    { name = 'buffer' },
  },
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = lsp.kind_icons[vim_item.kind]
      return vim_item
    end
  }
});

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
