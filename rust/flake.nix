{
  description = "A very basic Rust flake";

  inputs = {
    naersk.url = "github:nix-community/naersk";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, naersk, nixpkgs, utils, ... }:
    let
      hello = { naersk, nix-gitignore, openssl, pkg-config, sqlite }:
        let gitignore = nix-gitignore.gitignoreSourcePure [ ./.gitignore ];
        in naersk.buildPackage {
          src = gitignore ./.;
          # nativeBuildInputs = [];
          # buildInputs = [];
        };
      overlays.default = self: super: { hello = self.callPackage hello { }; };
    in {
      overlays = overlays;
    } // (utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ overlays.default naersk.overlay ];
        };
      in {
        packages = {
          default = pkgs.hello;
          hello = pkgs.hello;
        };

        devShells.default = pkgs.mkShell {
          buildInputs = [
            # Rust Toolchain
            pkgs.cargo
            pkgs.clippy
            pkgs.rust-analyzer
            pkgs.rustc
            pkgs.rustfmt
          ];
        };
      }));
}
