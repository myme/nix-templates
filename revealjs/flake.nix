{
  description = "Build presentations in Reveal.js using Emacs Org Mode";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        emacs = pkgs.emacsWithPackages (epkgs: [ epkgs.org-re-reveal ]);

        # Reveal.js with "dracula" theme
        revealjs = pkgs.nodePackages."reveal.js";

        slides = pkgs.callPackage ./slides.nix { inherit emacs revealjs; };

      in {
        # Build and serve slide: `nix run`
        apps.default = {
          type = "app";
          program = "${pkgs.writeShellScript "serve" ''
            ${pkgs.ran}/bin/ran --root ${slides}
          ''}";
        };

        # Build slides: `nix build`
        packages.default = slides;

        # Development shell
        devShells.default = pkgs.mkShell {
          REVEALJS = revealjs;
          buildInputs = [
            emacs
            revealjs
            # Start a development server using `start`
            (pkgs.writeShellScriptBin "start" ''
              mkdir -p slides
              ${pkgs.hivemind}/bin/hivemind - <<EOF
              serve: ${pkgs.ran}/bin/ran --root ./slides
              watch: ${pkgs.watchexec}/bin/watchexec -e org make
              EOF
            '')
          ];
        };
      });
}
