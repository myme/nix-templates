{
  description = "Build presentations in Reveal.js using Emacs Org Mode";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, utils, ... }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        emacs-pkg = pkgs.emacsWithPackages (epkgs: [
          epkgs.doom-themes
          epkgs.htmlize
          epkgs.ob-mermaid
          epkgs.org-re-reveal
        ]);

        slixmacs = pkgs.writeShellScriptBin "slixmacs" ''
          ${emacs-pkg}/bin/emacs -Q "$@"
        '';

        # Reveal.js with "dracula" theme
        revealjs = pkgs.nodePackages."reveal.js";

        slides = pkgs.callPackage ./slides.nix {
          inherit revealjs;
          emacs = emacs-pkg;
        };

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
            pkgs.python3

            revealjs
            # Start a development server using `start`
            (pkgs.writeShellScriptBin "start" ''
              mkdir -p slides
              ${pkgs.hivemind}/bin/hivemind - <<EOF
              serve: ${pkgs.ran}/bin/ran --root ./slides
              watch: ${pkgs.watchexec}/bin/watchexec -e org make EMACS=${slixmacs}/bin/slixmacs
              EOF
            '')
          ];
        };
      });
}
