final: prev: {
  depot = final.callPackage ../packages/depot/package.nix { };
  dexter = final.callPackage ../packages/dexter/package.nix { };
  honeybadger-mcp-server = final.callPackage ../packages/honeybadger-mcp-server/package.nix { };
  playwright-cli = final.callPackage ../packages/playwright-cli/package.nix { };
  tidewave-cli = final.callPackage ../packages/tidewave-cli/package.nix { };
}
