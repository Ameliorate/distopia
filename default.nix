let pkgs = import <nixpkgs> { }; in

let
  perl = pkgs.perl.withPackages (perl-packages: with perl-packages; [
    # perl packages
    FileSlurp
  ]); 
  distopia-pl = pkgs.stdenv.mkDerivation {
    name = "distopia-pl";
    src = ./.;

    buildPhase = "true";

    installPhase = ''
      mkdir -p $out/lib/distopia
      cp -r src $out/lib/distopia
      cp -r pipes $out/lib/distopia
    '';
  }; in 
pkgs.writeShellScriptBin "distopia" ''
  export PATH=$PATH:${pkgs.xsel}/bin:${pkgs.dmenu}/bin:${pkgs.libnotify}/bin:${pkgs.cowsay}/bin
  DISTOPIA_PWD="${distopia-pl}/lib/distopia"
  export DISTOPIA_PWD
  ${perl}/bin/perl ${distopia-pl}/lib/distopia/src/main.pl $1
''
