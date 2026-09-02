{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:

# @playwright/cli is not in nixpkgs. Build it straight from its source repo,
# which ships a package-lock.json — so buildNpmPackage has a lockfile and
# nix-update can bump it by git tag (see nix-update-args for the version pin).
buildNpmPackage (finalAttrs: {
  pname = "playwright-cli";
  version = "0.1.19";

  src = fetchFromGitHub {
    owner = "microsoft";
    repo = "playwright-cli";
    tag = "v${finalAttrs.version}";
    hash = "sha256-pbv51ybubbjoIpKg0k7lfXfZ9Z+qdZI2lRhQeI+/mFA=";
  };

  npmDepsHash = "sha256-aY3i+sc2p8iQAEpfs+j/ifeBVmMpDDmwctEqOIDmCqI=";

  # Pure-JS CLI, no compile step — buildNpmPackage installs the package's
  # declared `playwright-cli` bin directly.
  dontNpmBuild = true;

  # Skip dependency install scripts. The one that matters is playwright-core's
  # postinstall browser download, which we don't want: consumers point Playwright
  # at a system browser at runtime via PLAYWRIGHT_LAUNCH_OPTIONS_EXECUTABLE_PATH.
  npmFlags = [ "--ignore-scripts" ];

  meta = {
    description = "Playwright agent CLI (@playwright/cli): drive a browser via per-command terminal calls";
    mainProgram = "playwright-cli";
    homepage = "https://github.com/microsoft/playwright-cli";
    license = lib.licenses.asl20;
    platforms = lib.platforms.all;
  };
})
