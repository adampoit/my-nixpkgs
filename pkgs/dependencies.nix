{
  apm = {
    source = {
      hash = "sha256-GpTWaG9n9LLtgge3i+ALt1aRnwLv8neMldnfUmjMkYI=";
      url = "https://files.pythonhosted.org/packages/01/16/6d18d52164ea5d2d296ae64ed489808e4ed4d166eb98b3d2f0ed95551d52/apm_cli-0.20.0.tar.gz";
    };
    update = {
      packageId = "apm-cli";
      strategy = "pypi-release";
    };
    version = "0.20.0";
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
      hash = "sha256-9pJHszURb1Rt0dk+o0dMQ/e76i0/tg77rC7a/6XgzaU=";
      url = "https://files.pythonhosted.org/packages/14/51/678a08b9fd0b7b45ea43081d969c4a52ee905f9ea60966af9a719a2a2ddc/cortexapps_cli-1.20.0.tar.gz";
    };
    update = {
      strategy = "pypi-release";
    };
    version = "1.20.0";
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
    nugetSha256 = "sha256-+E95J25gIQe4C9091BSu8ShQuHsFU5Qlugm8bM6PHm4=";
    update = {
      hashFields = [
        "nugetSha256"
      ];
      packageId = "Faithlife.FindReplaceCode.Tool";
      strategy = "nuget-release";
    };
    version = "1.4.1";
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
        hash = "sha256-Rhz9wiKC5i+/ZEXHJ1vMmJqmmBlMLGcCtgMlnKnbOZE=";
        url = "https://registry.npmjs.org/@github/copilot-darwin-arm64/-/copilot-darwin-arm64-1.0.63.tgz";
      };
      aarch64-linux = {
        hash = "sha256-fSbhiMINupwLnc57BTk9ISLny7il6dut4251hvZHYEk=";
        url = "https://registry.npmjs.org/@github/copilot-linux-arm64/-/copilot-linux-arm64-1.0.63.tgz";
      };
      x86_64-darwin = {
        hash = "sha256-GBsYPpdC7KKIgBL6wW4nNukXFZxT8d5O36JUjTGDx9s=";
        url = "https://registry.npmjs.org/@github/copilot-darwin-x64/-/copilot-darwin-x64-1.0.63.tgz";
      };
      x86_64-linux = {
        hash = "sha256-K1vtnD+KBj2qAfx5CtaEXu0maeTs5XXVeYmhizBVN6k=";
        url = "https://registry.npmjs.org/@github/copilot-linux-x64/-/copilot-linux-x64-1.0.63.tgz";
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
    version = "1.0.63";
  };
  jj-diffconflicts = {
    source = {
      hash = "sha256-MjacjGlBRwActBBGeBZDHz8jz5J3Mt6KoDsf8WKgUDA=";
      owner = "rafikdraoui";
      repo = "jj-diffconflicts";
      rev = "a2aa9a247b56d2c1a6f6be81bcf41c5450cc82ff";
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
    npmDepsHash = "sha256-0bvwryiyPskay+h8+0RiOmnamHkmcRRK00q7ZEPdj1g=";
    source = {
      hash = "sha256-wLE04sfPMh43IzIp6/HKBjloy3iSSanSYdYtklc6lQ4=";
      owner = "microsoft";
      repo = "playwright-cli";
      rev = "v0.1.14";
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
    version = "0.1.14";
  };
  repo-conventions = {
    nugetSha256 = "sha256-QAYM3z3ibiGf1JolX1OvnBcly5aJOnnftDg+XRcsQ+U=";
    update = {
      hashFields = [
        "nugetSha256"
      ];
      packageId = "repo-conventions";
      strategy = "nuget-release";
    };
    version = "1.1.0";
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
      hash = "sha256-pU5bVarvjeb/s2yJBQz+6UiUpXDQ3Widr7sZ5H2M5MA=";
      owner = "agentskills";
      repo = "agentskills";
      rev = "5d4c1fda3f786fff826c7f56b6cb3341e7f3a911";
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
