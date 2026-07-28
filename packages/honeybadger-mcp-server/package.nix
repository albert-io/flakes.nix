{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "honeybadger-mcp-server";
  rev = "7620ad7403b5b4a6a849fcb98038f1ed84c24f0b";
  version = "unstable-${builtins.substring 0 7 rev}";

  src = fetchFromGitHub {
    owner = "honeybadger-io";
    repo = "honeybadger-mcp-server";
    inherit rev;
    hash = "sha256-9/hZVqkXtMa1H8XXkQhy21HI5n9iVS08GUu5rAKYAwo=";
  };

  subPackages = [ "cmd/honeybadger-mcp-server" ];

  vendorHash = "sha256-N4SI14Hm0bdLMilyZwqR70KToD2Xiav/u1uNsZJAOuw=";

  ldflags = [
    "-s"
    "-w"
  ];

  meta = {
    description = "Honeybadger MCP Server";
    mainProgram = "honeybadger-mcp-server";
    homepage = "https://github.com/honeybadger-io/honeybadger-mcp-server";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
  };
}
