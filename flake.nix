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

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        tex = pkgs.texlive.combine {
          inherit (pkgs.texlive.pkgs)
            xetex
            xetexref
            scheme-minimal
            mathtools
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
        };

        src = ./.;
        nativeBuildInputs = with pkgs; [
          coreutils
          bashInteractive
          gnumake
          tex
          line-awesome
          fontconfig
          poppler-utils # for pdffonts
        ];
        buildInputs = with pkgs; [ ];

        systemfontdirs = with pkgs; map toString [
          line-awesome
        ];

        # used by xetex and mtx-fonts (context)
        generatedFontsConf = pkgs.makeFontsConf {
          fontDirectories = systemfontdirs ++ [ tex.fonts ];
        };

        customFontConf = pkgs.writeText "custom-fonts.conf" ''
          <?xml version="1.0"?>
          <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
          <fontconfig/>
        '';

        fontsConf = pkgs.writeText "fonts.conf" ''
          <?xml version="1.0"?>
          <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
          <fontconfig>
            <include>${customFontConf}</include>
            <include>${generatedFontsConf}</include>
            <include ignore_missing="yes">/etc/fonts/fonts.conf</include>
          </fontconfig>
        '';

        FONTCONFIG_FILE = fontsConf;
      in
      {
        devShells.default = pkgs.mkShellNoCC {
          inherit buildInputs nativeBuildInputs FONTCONFIG_FILE;
        };
      }
    );
}
