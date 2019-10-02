let pkgs = import <nixpkgs> { }; in

pkgs.stdenv.mkDerivation {
  name = "distopia";

  buildInputs = let
    perl = pkgs.perl.withPackages (perl-packages: with perl-packages; [
      # perl packages
      FileSlurp

    ]); in [
      # use the perl we created above
      perl

      # runtime dependencies
      pkgs.xsel
      pkgs.dmenu
      pkgs.libnotify
      pkgs.cowsay
    ];
}
