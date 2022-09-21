{
  description = "A collection of flake templates";

  outputs = { self }: {

    nodejs = {
      path = ./nodejs;
      description = "NodeJS based project";
    };

  };
}
