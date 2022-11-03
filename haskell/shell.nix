{ haskellPackages, name, package, cabal-install, haskell-language-server, hlint
, hpack, writeShellScriptBin }:

let
  tdd = writeShellScriptBin "tdd" ''
    # This hacky thing runs nested ghcid's (yes, really) which allows fast
    # recompilation and running tests whenever *both* the library and the tests change.
    #
    # See: https://stackoverflow.com/a/74276514
    ghcid --target=${name} --run=":! ghcid --target=${name}-test --run"
  '';

in haskellPackages.shellFor {
  packages = (_: [ package ]);
  buildInputs = ([ cabal-install haskell-language-server hlint hpack tdd ])
    ++ (with haskellPackages; [ ghcid ormolu ]);
}
