# Nix Flakes Haskell Template

Hello! This aims to be a complete `nix flakes` Haskell template. It includes:

 - Basic Haskell toolchain (`ghc`, `cabal`, `hpack`, ++)
 - [Haskell language server](https://github.com/haskell/haskell-language-server) for [LSP](https://microsoft.github.io/language-server-protocol/)
 - Development tools (`hlint`, `ormolu`, `ghcid`)
 - Lots of love 💕 ... and rockets 🚀

## Getting started

Create a new Haskell project in a directory `./hello`:

```sh
nix flake new hello -t github:myme/nix-templates#haskell
```

## Setup

All remaining actions require the `nix` environment to be loaded. This can be
done either through using `nix develop` which loads a new `nix-shell`-like
environment where all dependencies are available. Or, it's possible to use the
[direnv](https://direnv.net/) tool which sources this environment directly into
the current shell.

### With `nix develop`

``` sh
cd hello
nix develop
```

### With `direnv`

``` sh
cd hello
direnv allow
```

### Build `hello.cabal`

In order to use `cabal` commands there must be a `.cabal` file. This is
generated using [hpack](https://github.com/sol/hpack). `hpack` provides a more
friendly interface to declaring packages and dependencies than the regular
`cabal` syntax.

``` sh
hpack
```

## Cabal commands

[Cabal](https://www.haskell.org/cabal/) is used as the main build tool for
Haskell. [Stack](https://docs.haskellstack.org/en/stable/) is another popular
alternative to `Cabal`. Using `nix` managing the Haskell package set you're much
less likely to end up in a
[Cabal-hell](https://stackoverflow.com/questions/25869041/whats-the-reason-behind-cabal-dependency-hell/25870174#25870174),
which makes `stack` [somewhat
redundant](https://github.com/Gabriella439/haskell-nix#background).

### Build project

``` sh
cabal build
```

### Run project

``` sh
cabal run
```

### Test project

For running tests a single time:

``` sh
cabal run
```

For TDD (Test-driven development) based workflow:

``` sh
tdd
```

This uses a small wrapper around `ghcid` which do continuous recompilation and
retesting for rapid feedback whenever something changes.

## Updates

### Nix

To update the `nix` lockfile, use:

``` sh
nix flake update
```

or e.g. just for a single flake input like `nixpkgs`:

``` sh
nix flake lock --update-input nixpkgs
```

### Nix develop

After making changes to dependencies in `package.yaml` it's necessary to reload
the nix environment. With `nix develop` that's just a matter of exiting and re-entering the `nix` shell:

``` sh
nix develop
```

### Direnv

With `direnv` reloading can be done like so:

``` sh
direnv reload
```

