{
  description = "A collection of flake templates";

  outputs = { self }: {

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

  };
}
