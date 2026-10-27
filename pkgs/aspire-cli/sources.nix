{
  platformPackages = {
    aarch64-darwin = {
      hash = "sha256-JiBnDCCD99E5lhUC7+UCbyGyO/q4NocVlZfm9NOO96w=";
      packageId = "aspire.cli.osx-arm64";
    };
    aarch64-linux = {
      hash = "sha256-fPbnIoS5NrMB89NScr0R9qHIgP9RD4Vpm+CSvLQJJIQ=";
      packageId = "aspire.cli.linux-arm64";
    };
    x86_64-darwin = {
      hash = "sha256-ZDuJ9pO7QMWGaLqc7xaN2mh+pH+hUIpNhk5Emh/HW5k=";
      packageId = "aspire.cli.osx-x64";
    };
    x86_64-linux = {
      hash = "sha256-Nizy0TwMEWUKBHN1PeoVbWGjZi03Vb/Vx0+Bb42vy8k=";
      packageId = "aspire.cli.linux-x64";
    };
  };
  update = {
    packageId = "Aspire.Cli";
    strategy = "nuget-release";
  };
  version = "13.5.3";
}
