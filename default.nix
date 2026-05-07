{ system ? builtins.currentSystem }:

let
  flake = builtins.getFlake (toString ./.);
  pkgs = import flake.inputs.nixpkgs { inherit system; };
in
{
  dexter = pkgs.callPackage ./packages/dexter/package.nix { };
  honeybadger-mcp-server = pkgs.callPackage ./packages/honeybadger-mcp-server/package.nix { };
}
