{
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
        hash = "sha256-cb+idpDMqDGmr3KJ/pHGDr7Kt+X0Vzd5ftEY3htP5k8=";
        url = "https://registry.npmjs.org/@github/copilot-darwin-arm64/-/copilot-darwin-arm64-1.0.14.tgz";
      };
      aarch64-linux = {
        hash = "sha256-Q+ghnlu9fWL5tTiZrHo9BmQezU3lL5jQ9Rt+hNZYAz4=";
        url = "https://registry.npmjs.org/@github/copilot-linux-arm64/-/copilot-linux-arm64-1.0.14.tgz";
      };
      x86_64-darwin = {
        hash = "sha256-+t2uFHR+4J9rPIaUjboqHHxC7bnFhaVFbQOoCZKqSBQ=";
        url = "https://registry.npmjs.org/@github/copilot-darwin-x64/-/copilot-darwin-x64-1.0.14.tgz";
      };
      x86_64-linux = {
        hash = "sha256-va970FAq/W9WBCFJQx9n7qVedZmT+bnzM+dD/Tj5YFI=";
        url = "https://registry.npmjs.org/@github/copilot-linux-x64/-/copilot-linux-x64-1.0.14.tgz";
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
    };
    version = "1.0.14";
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
    npmDepsHash = "sha256-MYUFGz+ZhlO6QYMQOwwEr1cJ+NvDvdkLKwZfJBvh6sI=";
    source = {
      hash = "sha256-ewydxWKXTZ6+NDaIH5krRcWYdLPsi8O3EEgfapasTXU=";
      owner = "microsoft";
      repo = "playwright-cli";
      rev = "v0.1.3";
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
    version = "0.1.3";
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
      hash = "sha256-NH2QFx0IKJlx5H6+Egwcb+ERAMTNHTv+bI+BHPZkWfE=";
      owner = "agentskills";
      repo = "agentskills";
      rev = "5e7f3e2c4c9f5464fe342bf2fea72367a914e9b4";
    };
    sourceSubdir = "skills-ref";
    update = {
      branch = "main";
      strategy = "github-branch";
    };
    version = "0.1.0";
  };
  tiny-inline-diagnostic = {
    source = {
      hash = "sha256-cIG8PPcYjJxsTbaeEN/P/D75wou1c1A2+2XkxN1aUPw=";
      owner = "rachartier";
      repo = "tiny-inline-diagnostic.nvim";
      rev = "ba133b3e932416e4b9507095731a6d7276878fe8";
    };
    update = {
      branch = "main";
      strategy = "github-branch";
    };
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
