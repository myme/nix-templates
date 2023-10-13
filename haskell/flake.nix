{
  description = "A very basic Haskell flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    let
      name = "hello";
      overlay = (final: prev: {
        haskellPackages = prev.haskellPackages // {
          ${name} = prev.haskellPackages.callCabal2nix name ./. { };
        };
      });
    in {
      inherit overlay;
    } // utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ overlay ];
        };
      in {
        defaultPackage = pkgs.${name};

        devShell = pkgs.callPackage ./shell.nix {
          inherit name;
          package = pkgs.haskellPackages.${name};
        };
      });
}
