final: prev: {
  dexter = final.callPackage ../packages/dexter/package.nix { };
  honeybadger-mcp-server = final.callPackage ../packages/honeybadger-mcp-server/package.nix { };
}
