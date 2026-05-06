{
  apm = {
    source = {
      hash = "sha256-SB1lYVImadqo740weUDAXYDlcLdI5LOGpG62H5JxTos=";
      url = "https://files.pythonhosted.org/packages/17/c4/7a64c2524da6ab36299a120f95ff725dbcadba9d05c345c0747e2dcf9e3b/apm_cli-0.12.1.tar.gz";
    };
    update = {
      packageId = "apm-cli";
      strategy = "pypi-release";
    };
    version = "0.12.1";
  };
  azure-ai-inference = {
    source = {
      hash = "sha256-SYI3MuZ0CS2tg7uLDRtlqnMRH6uSTWE0nrKozcBJOZA=";
      url = "https://files.pythonhosted.org/packages/4f/0f/27520da74769db6e58327d96c98e7b9a07ce686dff582c9a5ec60b03f9dd/azure_ai_inference-1.0.0b9-py3-none-any.whl";
    };
    update = {
      packageId = "azure-ai-inference";
      packageType = "bdist_wheel";
      strategy = "pypi-release";
    };
    version = "1.0.0b9";
  };
  cortexapps-cli = {
    source = {
      hash = "sha256-/FdwUjhJBJrJ3w5d6RB++xbsQ80dXuzVWPyT8ge3z8E=";
      url = "https://files.pythonhosted.org/packages/f4/d5/69f42fa0232c9885ef6fac2d60e8f6d4d7b257bfef554c9a5c44ef4e6e7c/cortexapps_cli-1.15.0.tar.gz";
    };
    update = {
      strategy = "pypi-release";
    };
    version = "1.15.0";
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
        hash = "sha256-NOigBg6XOH/XiZ41euTdyHzKXzajW9PeR2NHvpe0P04=";
        url = "https://registry.npmjs.org/@github/copilot-darwin-arm64/-/copilot-darwin-arm64-1.0.40.tgz";
      };
      aarch64-linux = {
        hash = "sha256-ijzEoTdZCPRjBEytlQsVpB+yWJEUWhgWEG0sh9RpZcY=";
        url = "https://registry.npmjs.org/@github/copilot-linux-arm64/-/copilot-linux-arm64-1.0.40.tgz";
      };
      x86_64-darwin = {
        hash = "sha256-/49IW3ujFR3+unU/Rgx2N+UUuOAu6LuYrdQ2EqoUVrY=";
        url = "https://registry.npmjs.org/@github/copilot-darwin-x64/-/copilot-darwin-x64-1.0.40.tgz";
      };
      x86_64-linux = {
        hash = "sha256-cVtcN3q8kbTUHR53zBdJHVxKXtluKsHSDSNNsqivYUI=";
        url = "https://registry.npmjs.org/@github/copilot-linux-x64/-/copilot-linux-x64-1.0.40.tgz";
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
    version = "1.0.40";
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
  llm-github-models = {
    source = {
      hash = "sha256-t3iqb6Q+U+yzuGj8+YdbwOdgp3Sh+tduqQeiaVgqIEM=";
      url = "https://files.pythonhosted.org/packages/2c/b5/714d6c7683cf5ffcf0352951a83ea9d952bd6052900b9e7ccb2a3b09ce0a/llm_github_models-0.18.0.tar.gz";
    };
    update = {
      packageId = "llm-github-models";
      strategy = "pypi-release";
    };
    version = "0.18.0";
  };
  playwright-cli = {
    npmDepsHash = "sha256-vt/dQU3DPN+2U73KJQVJCBoqC1XLxdCDaUPUO9092Ok=";
    source = {
      hash = "sha256-tmFXB4c3EXh6GLVphiQUbaUEjf2e0CI9k1YI9a2Yn2w=";
      owner = "microsoft";
      repo = "playwright-cli";
      rev = "v0.1.11";
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
    version = "0.1.11";
  };
  repo-conventions = {
    nugetSha256 = "sha256-bZ2Huzd6mhDjUfntEg3JbJCIm0zI1m1mPgto7pwHBwg=";
    update = {
      hashFields = [
        "nugetSha256"
      ];
      packageId = "repo-conventions";
      strategy = "nuget-release";
    };
    version = "0.1.29";
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
      hash = "sha256-ulh77OnTtEP2zEIw9wvuajh89Okg8ekI/7OE7ZKQ1Uk=";
      owner = "agentskills";
      repo = "agentskills";
      rev = "2d3e01f590f68bee2cb76a3200823e93b2cc9eaa";
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
