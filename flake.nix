{
  description = "scanner-rs";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    naersk = {
      url = "github:nix-community/naersk";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, fenix, naersk, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; overlays = [ fenix.overlays.default ]; };
        rustToolchain = pkgs.fenix.stable.withComponents [
          "cargo"
          "clippy"
          "rust-src"
          "rustc"
          "rustfmt"
        ];
        naerskLib = naersk.lib.${system}.override {
          cargo = rustToolchain;
          rustc = rustToolchain;
        };
      in
      {
        packages.default = naerskLib.buildPackage { src = ./.; };

        devShells.default = pkgs.mkShell rec {
          name = "default";
          buildInputs = [
            rustToolchain
            pkgs.rust-analyzer
          ] ++ (with pkgs; [
            pkg-config
            libxkbcommon
            libGL

            wayland

            xorg.libXcursor
            xorg.libXrandr
            xorg.libXi
            xorg.libX11
          ]);
          LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath buildInputs}";
        };

        formatter = pkgs.nixpkgs-fmt;
      }
    );
}
