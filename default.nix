{ system ? builtins.currentSystem }:

let
  flake = builtins.getFlake (toString ./.);
  pkgs = import flake.inputs.nixpkgs { inherit system; };
in
{
  depot = pkgs.callPackage ./packages/depot/package.nix { };
  dexter = pkgs.callPackage ./packages/dexter/package.nix { };
  honeybadger-cli = pkgs.callPackage ./packages/honeybadger-cli/package.nix { };
  playwright-cli = pkgs.callPackage ./packages/playwright-cli/package.nix { };
  tidewave-cli = pkgs.callPackage ./packages/tidewave-cli/package.nix { };
}
