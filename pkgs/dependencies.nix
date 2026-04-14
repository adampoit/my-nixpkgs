{
  cortexapps-cli = {
    source = {
      hash = "sha256-y+ZjCq+CCQ3Z8i1aG2X6kTPnH4GmZfy6niZAXbxmEuk=";
      url = "https://files.pythonhosted.org/packages/4f/bb/3d2f9d51a81de6a254667eca5a24881e909e8f6e3f2c84a1f54b1db9272c/cortexapps_cli-1.14.0.tar.gz";
    };
    update = {
      strategy = "pypi-release";
    };
    version = "1.14.0";
  };
  dotnet-counters = {
    nugetSha256 = "sha256-AYT06BqaY1IPA8YTlvLNdQQgmslKmZK6tS7s8Lm8Rss=";
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
    version = "8.0.547301";
  };
  dotnet-trace = {
    nugetSha256 = "sha256-de+w/XJ9zK8RAVKrdvKzuPv5GOhSH2WCanFGSgyWFuU=";
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
    version = "8.0.547301";
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
  github-copilot-cli = {
    source = {
      aarch64-darwin = {
        hash = "sha256-xIyNpN60dUkuI6Xgabu11IvZ/Lok1ZYubjGMast3tQ0=";
        url = "https://registry.npmjs.org/@github/copilot-darwin-arm64/-/copilot-darwin-arm64-1.0.25.tgz";
      };
      aarch64-linux = {
        hash = "sha256-KR78TINeA0i4s4fLyAOMoFAV2e4UNOS7PagPBVbzXi8=";
        url = "https://registry.npmjs.org/@github/copilot-linux-arm64/-/copilot-linux-arm64-1.0.25.tgz";
      };
      x86_64-darwin = {
        hash = "sha256-KIiCDc3iIekGJ5E4sZt3iORtRIN+My5ubm5AZE1gIxI=";
        url = "https://registry.npmjs.org/@github/copilot-darwin-x64/-/copilot-darwin-x64-1.0.25.tgz";
      };
      x86_64-linux = {
        hash = "sha256-twkZOTUGaPqEdA1CSTZfZZ3GlbGL4Sv655YWDBDjIqQ=";
        url = "https://registry.npmjs.org/@github/copilot-linux-x64/-/copilot-linux-x64-1.0.25.tgz";
      };
    };
    update = {
      packageId = "@github/copilot";
      sourcePackages = {
        aarch64-darwin = "@github/copilot-darwin-arm64";
        aarch64-linux = "@github/copilot-linux-arm64";
        x86_64-darwin = "@github/copilot-darwin-x64";
        x86_64-linux = "@github/copilot-linux-x64";
      };
      strategy = "npm-registry-release";
      upstream = {
        ignore = true;
      };
    };
    version = "1.0.25";
  };
  jj-diffconflicts = {
    source = {
      hash = "sha256-CDLOo07tGOg/7Sowb1d39k9Nq/RW50axGj8L1D3Be70=";
      owner = "rafikdraoui";
      repo = "jj-diffconflicts";
      rev = "58163ae8fe7646179dfd7741206dd9a2b4cdadc0";
    };
    update = {
      branch = "main";
      strategy = "github-branch";
    };
  };
  playwright-cli = {
    npmDepsHash = "sha256-J/d04hKNVl/azPaYgbGSqWbCBDxZwogmomk7lQ0t91I=";
    source = {
      hash = "sha256-6HAQi2P1ddEW5ubFc5pUtPpBSdnNRgfejFiCVBfvbJY=";
      owner = "microsoft";
      repo = "playwright-cli";
      rev = "0.1.7";
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
    version = "0.1.7";
  };
  screenkey = {
    source = {
      hash = "sha256-EGyIkWcQbCurkBbeHpXvQAKRTovUiNx1xqtXmQba8Gg=";
      owner = "NStefan002";
      repo = "screenkey.nvim";
      rev = "v2.4.2";
    };
    update = {
      strategy = "github-release";
      version = {
        stripPrefix = "v";
      };
    };
    version = "2.4.2";
  };
  skills-ref = {
    source = {
      hash = "sha256-DET/wxwykv4Qb7X6zd+mesVb+sHfxom5re/O/zQQchA=";
      owner = "agentskills";
      repo = "agentskills";
      rev = "b12d4f812cb347d6035efaa0b800691bf2dc0d55";
    };
    sourceSubdir = "skills-ref";
    update = {
      branch = "main";
      strategy = "github-branch";
    };
    version = "0.1.0";
  };
  ts-error-translator = {
    source = {
      hash = "sha256-/eLbUkjFpAneMoITdknATvpDjnA5XMUjEKaDq0CG+ys=";
      owner = "dmmulroy";
      repo = "ts-error-translator.nvim";
      rev = "v2.0.1";
    };
    update = {
      strategy = "github-release";
      version = {
        stripPrefix = "v";
      };
    };
    version = "2.0.1";
  };
  vscode-firefox-debug = {
    npmDepsHash = "sha256-Gqdj+i/4mQSURi3CmL4kYXaePEkYfZ0ZFVheY+STfz0=";
    source = {
      hash = "sha256-qHlp+V9ZR5yVby56WnSxpf0oWxJYK37Z3WVfv1UujzA=";
      owner = "firefox-devtools";
      repo = "vscode-firefox-debug";
      rev = "2.15.0";
    };
    update = {
      hashFields = [
        "npmDepsHash"
      ];
      strategy = "github-release";
    };
    version = "2.15.0";
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
