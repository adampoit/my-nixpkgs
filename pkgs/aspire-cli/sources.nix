{
  platformPackages = {
    aarch64-darwin = {
      hash = "sha256-Wc+tyas+D3q8d2XNNZUxYHO3ifqLrRBuEqeyIw62DfM=";
      packageId = "aspire.cli.osx-arm64";
    };
    aarch64-linux = {
      hash = "sha256-nBGAOgn2UpNJU6yk7fx25LXqjBgbZZOLoDaMqDuP5Rc=";
      packageId = "aspire.cli.linux-arm64";
    };
    x86_64-darwin = {
      hash = "sha256-LVfTculMJqDl+Bzsdxfg14wXHQ3vioO9SKgBhdqaz6Y=";
      packageId = "aspire.cli.osx-x64";
    };
    x86_64-linux = {
      hash = "sha256-e5D9i5LGFMssG1+Dod2OVQjxw6abUL1J2qbhT3bzl8M=";
      packageId = "aspire.cli.linux-x64";
    };
  };
  update = {
    packageId = "Aspire.Cli";
    strategy = "nuget-release";
  };
  version = "13.6.4";
}
