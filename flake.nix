{
  description = "A basic flake with a shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-for-ghc.url = "github:NixOS/nixpkgs/ebe4301cbd8f81c4f8d3244b3632338bbeb6d49c";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { nixpkgs, nixpkgs-for-ghc, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
        ghcpkgs = import nixpkgs-for-ghc {
          inherit system;
        };
	ghcPackages = with ghcpkgs; [
          (haskell.compiler.ghc984.override { useLLVM = true; })
          (haskell-language-server.override { supportedGhcVersions = [ "984" ]; })
          haskell.packages.ghc984.cabal-fmt
          haskell.packages.ghc984.cabal-plan
          haskell.packages.ghc984.doctest
          haskell.packages.ghc984.implicit-hie
          haskell.packages.ghc984.hoogle
          haskell.packages.ghc984.ghcid
          haskell.packages.ghc984.ghcide
          haskell.packages.ghc984.ghci-dap
          haskell.packages.ghc984.haskell-dap
	];
      in
      {
        devShells.default =
          with pkgs;
          mkShell {
            buildInputs = [
              pkg-config
              stack
              cabal-install
              llvmPackages.bintools
            ];

            packages = ghcPackages ++ [
              hlint
              act
              action-validator
              actionlint
            ];
          };
      }
    );
}
