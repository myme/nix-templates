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

  };
}
