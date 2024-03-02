{
  description = "A collection of flake templates";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { utils, ... }@inputs:
    {
      templates = {
        haskell = {
          path = ./haskell;
          description = "Haskell based project";
        };

        nodejs = {
          path = ./nodejs;
          description = "NodeJS based project";
        };

        python = {
          path = ./python;
          description = "Python based project";
        };

        revealjs = {
          path = ./revealjs;
          description = "Build presentations in Reveal.js using Emacs Org Mode";
        };

        rust = {
          path = ./rust;
          description = "Rust base project";
        };
      };
    } // utils.lib.eachDefaultSystem (system: {
      # Expose the various devShells
      devShells = {
        haskell =
          ((import ./haskell/flake.nix).outputs inputs).devShell.${system};
        nodejs =
          ((import ./nodejs/flake.nix).outputs inputs).devShell.${system};
        python =
          ((import ./python/flake.nix).outputs inputs).devShell.${system};
        revealjs =
          ((import ./revealjs/flake.nix).outputs inputs).devShells.${system}.default;
        rust =
          ((import ./rust/flake.nix).outputs inputs).devShells.${system}.default;
      };
    });
}
