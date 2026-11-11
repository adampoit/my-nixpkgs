{
  platformPackages = {
    aarch64-darwin = {
      hash = "sha256-EibhIAhlBdzVqRb8KgXlDKrjUfufCp6GWikjGNnovz0=";
      packageId = "aspire.cli.osx-arm64";
    };
    aarch64-linux = {
      hash = "sha256-0Lz+ltxnAOPJbPe7jd0vovlirwiNJ8aTldzSl6O3low=";
      packageId = "aspire.cli.linux-arm64";
    };
    x86_64-darwin = {
      hash = "sha256-aaAK0fT/ps+qeJ0HdmzkUzPv/oiRGTFyherJB4DVYLQ=";
      packageId = "aspire.cli.osx-x64";
    };
    x86_64-linux = {
      hash = "sha256-ORl3t70GDdV7Bb/4qUYJ8AkkIDyOD3p5+85PonyH2oY=";
      packageId = "aspire.cli.linux-x64";
    };
  };
  update = {
    packageId = "Aspire.Cli";
    strategy = "nuget-release";
  };
  version = "13.6.5";
}
