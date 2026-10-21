{
  lib,
  buildGoModule,
  fetchFromGitHub,
  installShellFiles,
  stdenv,
}:

buildGoModule rec {
  pname = "depot";
  version = "2.102.25";

  src = fetchFromGitHub {
    owner = "depot";
    repo = "cli";
    tag = "v${version}";
    hash = "sha256-i/4DkT+0ed3JBEsqQECp/1A3aXsQP+xc45+mIgtuVUw=";
  };

  nativeBuildInputs = [ installShellFiles ];

  subPackages = [ "cmd/depot" ];

  vendorHash = "sha256-t6e8RDRKnY6gAwEsBePoBHOw6Q1hJuvBAdJqrEktFYE=";

  ldflags = [
    "-s"
    "-w"
    "-X=github.com/depot/cli/internal/build.Version=${version}"
  ];

  postInstall = lib.optionalString (stdenv.buildPlatform.canExecute stdenv.hostPlatform) ''
    installShellCompletion --cmd depot \
      --bash <($out/bin/depot completion bash) \
      --fish <($out/bin/depot completion fish) \
      --zsh <($out/bin/depot completion zsh)
  '';

  meta = {
    description = "Official command line interface for the Depot API";
    mainProgram = "depot";
    homepage = "https://github.com/depot/cli";
    changelog = "https://github.com/depot/cli/releases/tag/v${version}";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
  };
}
