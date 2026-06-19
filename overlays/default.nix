final: prev: {
  depot = final.callPackage ../packages/depot/package.nix { };
  dexter = final.callPackage ../packages/dexter/package.nix { };
  honeybadger-cli = final.callPackage ../packages/honeybadger-cli/package.nix { };
  playwright-cli = final.callPackage ../packages/playwright-cli/package.nix { };
}
