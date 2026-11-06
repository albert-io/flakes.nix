{
  lib,
  buildGo127Module,
  fetchFromGitHub,
}:

buildGo127Module rec {
  pname = "honeybadger-mcp-server";
  rev = "1473b9779ec628b4618d44c8e4ef6282b1471539";
  version = "unstable-${builtins.substring 0 7 rev}";

  src = fetchFromGitHub {
    owner = "honeybadger-io";
    repo = "honeybadger-mcp-server";
    inherit rev;
    hash = "sha256-xOPpZhKe5kbc/OjzGVJjOpJGpXznPhQ0KmBYz2ASTNM=";
  };

  subPackages = [ "cmd/honeybadger-mcp-server" ];

  vendorHash = "sha256-0hRcZ5HE92XqwfXjNFwcVgFNmUg6cvpbEPhjdbL/hNg=";

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
