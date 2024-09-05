{
  description = "My own Neovim flake";
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-24.05";
    };
    neovim = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    telescope-recent-files-src = {
      url = "github:smartpde/telescope-recent-files";
      flake = false;
    };
  };
  outputs = {
    self,
    nixpkgs,
    neovim,
    telescope-recent-files-src,
  }: let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
      overlays = [overlayFlakeInputs overlayCustomNeovim];
    };
    overlayFlakeInputs = prev: final: {
      neovim = neovim.packages.x86_64-linux.neovim;

      vimPlugins =
        final.vimPlugins
        // {
          telescope-recent-files = import ./packages/vimPlugins/telescopeRecentFiles.nix {
            src = telescope-recent-files-src;
            pkgs = prev;
          };
        };
    };

    overlayCustomNeovim = prev: final: {
      customNeovim = import ./packages/customNeovim.nix {
        pkgs = pkgs;
      };
    };
  in {
    packages.x86_64-linux.default = pkgs.customNeovim;
    apps.x86_64-linux.default = {
      type = "app";
      program = "${pkgs.customNeovim}/bin/nvim";
    };
  };
}
