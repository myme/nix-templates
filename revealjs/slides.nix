{ emacs, revealjs, stdenv }:

stdenv.mkDerivation {
  name = "revealjs-org-mode-slides";
  src = builtins.path {
    path = ./.;
    name = "src";
  };
  PREFIX="$(out)";
  REVEALJS=revealjs;
  buildInputs = [
    emacs
  ];
}
