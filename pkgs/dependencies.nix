{
  dotnet-counters = {
    nugetSha256 = "sha256-gAexbRzKP/8VPhFy2OqnUCp6ze3CkcWLYR1nUqG71PI=";
    update = {
      hashFields = [
        "nugetSha256"
      ];
      packageId = "dotnet-counters";
      strategy = "nuget-release";
      version = {
        prefix = "8.0.";
      };
    };
    version = "8.0.510501";
  };
  dotnet-trace = {
    nugetSha256 = "sha256-Kt5x8n5Q0T+BaTVufhsyjXbi/BlGKidb97DWSbI6Iq8=";
    update = {
      hashFields = [
        "nugetSha256"
      ];
      packageId = "dotnet-trace";
      strategy = "nuget-release";
      version = {
        prefix = "8.0.";
      };
    };
    version = "8.0.510501";
  };
  findreplacecode = {
    nugetSha256 = "sha256-uaTsU2ZfUhHwVgPgeLn5DdQte2dqGOLC3SmQaH8B62c=";
    update = {
      hashFields = [
        "nugetSha256"
      ];
      packageId = "Faithlife.FindReplaceCode.Tool";
      strategy = "nuget-release";
    };
    version = "1.4.0";
  };
  github-copilot-cli = {
    source = {
      "aarch64-darwin" = {
        hash = "sha256-jc8Xffia3ziSLl6Jqnlcw96St8YnkSLG5gfB4YuXUo8=";
        url = "https://registry.npmjs.org/@github/copilot-darwin-arm64/-/copilot-darwin-arm64-1.0.11.tgz";
      };
      "aarch64-linux" = {
        hash = "sha256-ged8femY0dW08IHcr7SumtLlf5aqpWqQb9Z+6TDduyY=";
        url = "https://registry.npmjs.org/@github/copilot-linux-arm64/-/copilot-linux-arm64-1.0.11.tgz";
      };
      "x86_64-darwin" = {
        hash = "sha256-NjqmWe8OD9HLgfhXbOh6sydzL5RZ1bwogDoIF7Q7z7Y=";
        url = "https://registry.npmjs.org/@github/copilot-darwin-x64/-/copilot-darwin-x64-1.0.11.tgz";
      };
      "x86_64-linux" = {
        hash = "sha256-u63lQJ1v+AxG8ux6sCxxSm44VIY2SYU95B1pKgIf4Jg=";
        url = "https://registry.npmjs.org/@github/copilot-linux-x64/-/copilot-linux-x64-1.0.11.tgz";
      };
    };
    update = {
      packageId = "@github/copilot";
      sourcePackages = {
        "aarch64-darwin" = "@github/copilot-darwin-arm64";
        "aarch64-linux" = "@github/copilot-linux-arm64";
        "x86_64-darwin" = "@github/copilot-darwin-x64";
        "x86_64-linux" = "@github/copilot-linux-x64";
      };
      strategy = "npm-registry-release";
    };
    version = "1.0.11";
  };
  gh-workflow-stats = {
    source = {
      hash = "sha256-DTVthvrOKVJbEsL1fQd71vjHluxK6WadahlpPx/sfV4=";
      owner = "fchimpan";
      repo = "gh-workflow-stats";
      rev = "v0.4.1";
    };
    update = {
      hashFields = [
        "vendorHash"
      ];
      packageAttr = "gh-workflow-stats";
      strategy = "github-release";
      version = {
        stripPrefix = "v";
      };
    };
    vendorHash = "sha256-DuuS3VvKJwOJzBQ7cYlcYmqMbmMbiYHd7ZjhylhXnIg=";
    version = "0.4.1";
  };
  playwright-cli = {
    npmDepsHash = "sha256-4x3ozVrST6LtLoHl9KtmaOKrkYwCK84fwEREaoNaESc=";
    source = {
      hash = "sha256-Ao3phIPinliFDK04u/V3ouuOfwMDVf/qBUpQPESziFQ=";
      owner = "microsoft";
      repo = "playwright-cli";
      rev = "v0.1.1";
    };
    update = {
      hashFields = [
        "npmDepsHash"
      ];
      packageAttr = "playwright-cli";
      strategy = "github-release";
      version = {
        stripPrefix = "v";
      };
    };
    version = "0.1.1";
  };
  skills-ref = {
    source = {
      hash = "sha256-/eU1gsQjnpWdwl+h9NygGcWLX2JIJZWbRiWeHm55Gnw=";
      owner = "agentskills";
      repo = "agentskills";
      rev = "0c61f1efc081cbb1ffe3420f6bbcb5b08920e133";
    };
    sourceSubdir = "skills-ref";
    update = {
      branch = "main";
      strategy = "github-branch";
    };
    version = "0.1.0";
  };
  vscode-firefox-debug = {
    npmDepsHash = "sha256-Zy+ubEFL9e712bvDBf5MPF41qnynYUbcDoejW6O8+9Y=";
    source = {
      hash = "sha256-1Orqok33nwB/5ExEt3oMg+7MsYmWwgAXq0E1cWfuG54=";
      owner = "firefox-devtools";
      repo = "vscode-firefox-debug";
      rev = "2.9.8";
    };
    update = {
      hashFields = [
        "npmDepsHash"
      ];
      strategy = "github-release";
    };
    version = "2.9.8";
  };
  zsh-yarn-autocompletions = {
    source = {
      hash = "sha256-qeILNviMJA/6fDLN7uFzL4nLwDbvLx0EGxaH3yoUU7o=";
      owner = "g-plane";
      repo = "zsh-yarn-autocompletions";
      rev = "v2.0.2";
    };
    update = {
      strategy = "github-release";
      version = {
        stripPrefix = "v";
      };
    };
    version = "2.0.2";
  };
}
