# vim: ft=lua

{pkgs}:
''
require("copilot").setup({
  suggestion = {enabled = false},
  panel = { enabled = false},
  copilot_node_command = '${pkgs.nodejs_20}/bin/node', 
})
require('copilot_cmp').setup()
''
