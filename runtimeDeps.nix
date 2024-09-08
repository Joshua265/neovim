{pkgs}: {
  deps1 = with pkgs; [
    nodejs_20
    nodePackages.typescript
    nodePackages.typescript-language-server
    eslint

    vscode-langservers-extracted
    nixd
  ];
  deps2 = with pkgs; [lazygit ripgrep];
}
