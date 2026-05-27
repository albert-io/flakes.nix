{
  description = "A collection of Nix flakes/packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
  };

  outputs =
    {
      self,
      nixpkgs,
      systems,
    }:
    let
      eachSystem = nixpkgs.lib.genAttrs (import systems);
      pkgsFor = system: import nixpkgs { inherit system; };
    in
    {
      packages = eachSystem (
        system:
        let
          pkgs = pkgsFor system;
        in
        {
          depot = pkgs.callPackage ./packages/depot/package.nix { };
          dexter = pkgs.callPackage ./packages/dexter/package.nix { };
          honeybadger-mcp-server = pkgs.callPackage ./packages/honeybadger-mcp-server/package.nix { };
        }
      );

      overlays.default = import ./overlays;
    };
}
