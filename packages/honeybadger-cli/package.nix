{
  lib,
  buildGoModule,
  fetchFromGitHub,
  installShellFiles,
  stdenv,
}:

buildGoModule rec {
  pname = "honeybadger-cli";
  version = "0.10.1";

  src = fetchFromGitHub {
    owner = "honeybadger-io";
    repo = "cli";
    tag = "v${version}";
    hash = "sha256-XSpl9r321TPOOgHwJhWZe9krcnDRj2OjWtMZtjDgU58=";
  };

  nativeBuildInputs = [ installShellFiles ];

  subPackages = [ "cmd/hb" ];

  vendorHash = "sha256-/s0i/AZLzjtBdQRZLAyHRr0dcVB1n2m1uzRrno9jVSQ=";

  ldflags = [
    "-s"
    "-w"
    "-X=github.com/honeybadger-io/cli/cmd.Version=${version}"
  ];

  postInstall = lib.optionalString (stdenv.buildPlatform.canExecute stdenv.hostPlatform) ''
    installShellCompletion --cmd hb \
      --bash <($out/bin/hb completion bash) \
      --fish <($out/bin/hb completion fish) \
      --zsh <($out/bin/hb completion zsh)
  '';

  meta = {
    description = "Official command line interface for the Honeybadger API";
    mainProgram = "hb";
    homepage = "https://github.com/honeybadger-io/cli";
    changelog = "https://github.com/honeybadger-io/cli/releases/tag/v${version}";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
  };
}
