{
  description = "A basic flake with a shell, make and latex support";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
  };

  outputs =
    { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        tex = (pkgs.texlive.combine {
          inherit (pkgs.texlive)
            scheme-basic
            xetex
            xetexref
            enumitem
            ragged2e
            geometry
            fancyhdr
            xcolor
            ifmtarg
            xkeyval
            tikzfill
            xifthen
            xstring
            etoolbox
            setspace
            fontspec
            unicode-math
            fontawesome5
            roboto
            sourcesanspro
            tcolorbox
            parskip
            hyperref
            bookmark
            ;
        });
        src = ./.;
        nativeBuildInputs = with pkgs; [
          coreutils
          bashInteractive
          gnumake
          tex
        ];
        buildInputs = with pkgs; [

        ];
      in
      {
        devShells.default = pkgs.mkShellNoCC {
          inherit buildInputs nativeBuildInputs;
        };
      }
    );
}
