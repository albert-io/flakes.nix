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
  version = "0.1.15";

  src = fetchFromGitHub {
    owner = "microsoft";
    repo = "playwright-cli";
    tag = "v${finalAttrs.version}";
    hash = "sha256-M0NZ7h1kSIsxktMWe5n75LDc+MHZvSq6b+iRx6opakU=";
  };

  npmDepsHash = "sha256-ZrO8yIqMYMQUlsQraejVgKRZ7klC5/8UsV3/H1EqYtA=";

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
