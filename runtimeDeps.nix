{pkgs}: {
  deps1 = with pkgs; [
    nodePackages.typescript
    nodePackages.typescript-language-server
    eslint
    vscode-langservers-extracted
  ];
  deps2 = with pkgs; [lazygit ripgrep];
}
