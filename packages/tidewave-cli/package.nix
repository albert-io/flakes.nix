{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "tidewave-cli";
  rev = "bd327bdb595bce3ef73d30c22bbdade6be48c17c";
  version = "unstable-${builtins.substring 0 7 rev}";

  src = fetchFromGitHub {
    owner = "simplyvirgo";
    repo = "tidewave_cli";
    inherit rev;
    hash = "sha256-yfTK9poc9Tqsc+KYSvMZdUlw9vkiueZZKCyhGugDLog=";
  };

  # Module has no dependencies (go.mod has no require block).
  vendorHash = null;

  # Tests are integration tests that require a live Tidewave server.
  doCheck = false;

  ldflags = [
    "-s"
    "-w"
  ];

  meta = {
    description = "Go CLI wrapping Tidewave's Elixir/Phoenix MCP tools as shell commands";
    mainProgram = "tidewave_cli";
    homepage = "https://github.com/simplyvirgo/tidewave_cli";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
  };
}
