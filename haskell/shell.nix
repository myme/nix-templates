{ haskellPackages, package, cabal-install, haskell-language-server, hlint, hpack
}:

haskellPackages.shellFor {
  packages = (_: [ package ]);
  buildInputs = ([ cabal-install haskell-language-server hlint hpack ])
    ++ (with haskellPackages; [ ghcid ormolu ]);
}
