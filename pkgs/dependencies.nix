{
  aspire-cli = {
    platformPackages = {
      aarch64-darwin = {
        hash = "sha256-JLF4ZlHOrOfeMUUfKsosBO8pygYUzyNk+x3LbWjUIHQ=";
        packageId = "aspire.cli.osx-arm64";
      };
      aarch64-linux = {
        hash = "sha256-LQ8w04l1qP1xsDDOY8wgkIoD21xHVGJ5qWHuTI5qQxA=";
        packageId = "aspire.cli.linux-arm64";
      };
      x86_64-darwin = {
        hash = "sha256-FP64hZel1TnZNQA2CqpwieyfErtNcH6qRS3FMsb//Qw=";
        packageId = "aspire.cli.osx-x64";
      };
      x86_64-linux = {
        hash = "sha256-H8sU7LKX7yIXLyVzZIeo05UgKEqcIdpaZH8T5ISwVss=";
        packageId = "aspire.cli.linux-x64";
      };
    };
    update = {
      packageId = "Aspire.Cli";
      strategy = "nuget-release";
    };
    version = "13.4.6";
  };
  cortexapps-cli = {
    source = {
      hash = "sha256-M10F39C46hSqVwaQhHczKP18fKfGYs0C0gXpiWQPtoc=";
      url = "https://files.pythonhosted.org/packages/0f/24/7c4b23652719575537783dcad7a29b2463e9bee9a6c8b512f164f786dc38/cortexapps_cli-1.23.0.tar.gz";
    };
    update = {
      strategy = "pypi-release";
    };
    version = "1.23.0";
  };
  dev-wezterm = {
    source = {
      hash = "sha256-/bynntzQHwipNn4D+/GhWwHwLVJf52HpC7ZYUP1K0Gg=";
      owner = "chrisgve";
      repo = "dev.wezterm";
      rev = "40dea555a1112e1d353a61646647c739a3ce112f";
    };
    update = {
      branch = "main";
      strategy = "github-branch";
    };
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
  jj-navi = {
    source = {
      hash = "sha256-IRjQnEi32XBn/AH6vsH6DwMS/qiLsaOTOIIJb1l3XvY=";
      owner = "eersnington";
      repo = "jj-navi";
      rev = "v0.2.3";
    };
    update = {
      strategy = "github-release";
      version = {
        stripPrefix = "v";
      };
    };
    version = "0.2.3";
  };
  playwright-cli = {
    npmDepsHash = "sha256-u44jWprmr3RdzB3aDL3K0ShT5lLxr175z3C8pN43YFA=";
    source = {
      hash = "sha256-tc/2Qck3mm6BqWTu2lvvfsM0/BHO/Z0ZvCdFZ7QQqKI=";
      owner = "microsoft";
      repo = "playwright-cli";
      rev = "v0.1.17";
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
    version = "0.1.17";
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
  resurrect-wezterm = {
    source = {
      hash = "sha256-xjwOSRnwZ69x9NAumc6GovlzJ0iUPI3/t9wXPlD4nEs=";
      owner = "MLFlexer";
      repo = "resurrect.wezterm";
      rev = "65cbbbf6d2c76f3e36af7610a356fc190fcb6147";
    };
    update = {
      branch = "main";
      strategy = "github-branch";
    };
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
      hash = "sha256-Wcvw1TLXpj/Wlq/pxK3hKitn6QAVnGLHW6aZUVfABtM=";
      owner = "agentskills";
      repo = "agentskills";
      rev = "38a2ff82958afee88dadf4831509e6f7e9d8ef4e";
    };
    sourceSubdir = "skills-ref";
    update = {
      branch = "main";
      strategy = "github-branch";
    };
    version = "0.1.0";
  };
  smart-workspace-switcher-wezterm = {
    source = {
      hash = "sha256-af83PYDg3016uKSLd/IzFi2qV0Ouqjrv79CHZ1k2o+o=";
      owner = "MLFlexer";
      repo = "smart_workspace_switcher.wezterm";
      rev = "d502c8df682af072adc0555e9c41429b00934577";
    };
    update = {
      branch = "main";
      strategy = "github-branch";
    };
  };
  tabline-wez = {
    source = {
      hash = "sha256-NJ0pG+mkAEAtZmfqE/l/c9hnM1QBRHHlByW+tj01Kvk=";
      owner = "michaelbrusegard";
      repo = "tabline.wez";
      rev = "d0749dfae91c51e9dadfc6d58cbc6b39df0fe258";
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
