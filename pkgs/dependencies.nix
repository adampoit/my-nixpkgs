{
  aspire-cli = {
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
  };
  cortexapps-cli = {
    source = {
      hash = "sha256-p5Z5F7Bg3IPikwQigs9LVhF3er58SXk1arj1D1SDbO8=";
      url = "https://files.pythonhosted.org/packages/a3/3a/8d607d73f16c5a1e3b323ce6e0298962a9df71fae28e4232e694893dc23a/cortexapps_cli-1.39.0.tar.gz";
    };
    update = {
      strategy = "pypi-release";
    };
    version = "1.39.0";
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
    nugetSha256 = "sha256-ns9h+lJzxz1ly+I1aJ0SxKpr46as/so5mGy9m+2WHtw=";
    update = {
      hashFields = [
        "nugetSha256"
      ];
      packageId = "Faithlife.FindReplaceCode.Tool";
      strategy = "nuget-release";
    };
    version = "1.4.2";
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
  octoscope = {
    source = {
      hash = "sha256-Voi/ItNT/rxyY0CtocKbeMI6fdvVX4nd8FoLzwsrPg4=";
      owner = "gfazioli";
      repo = "octoscope";
      rev = "v0.31.0";
    };
    update = {
      hashFields = [
        "vendorHash"
      ];
      strategy = "github-release";
      version = {
        stripPrefix = "v";
      };
    };
    vendorHash = "sha256-DIVqbNjYbrssX22Htk9Mhc8fv8M8lS+LKo070EbcsCE=";
    version = "0.31.0";
  };
  playwright-cli = {
    npmDepsHash = "sha256-aY3i+sc2p8iQAEpfs+j/ifeBVmMpDDmwctEqOIDmCqI=";
    source = {
      hash = "sha256-pbv51ybubbjoIpKg0k7lfXfZ9Z+qdZI2lRhQeI+/mFA=";
      owner = "microsoft";
      repo = "playwright-cli";
      rev = "v0.1.19";
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
    version = "0.1.19";
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
      hash = "sha256-9coLvkonrdbkIAf6DVvCH6rfjPuyaCA/eb1RsFBMiSg=";
      owner = "agentskills";
      repo = "agentskills";
      rev = "69ef37e9424c0a7ea9dd2293b559e43ec8176379";
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
      hash = "sha256-QER46p4HoLyAqsRzNT7rDKgdi6JFChkTxW3w9XIi+4I=";
      owner = "michaelbrusegard";
      repo = "tabline.wez";
      rev = "dc2ddbe6c466502ae25345ff63d6f4b8c7cb8772";
    };
    update = {
      branch = "main";
      strategy = "github-branch";
    };
  };
  taskwarrior-tui = {
    cargoHash = "sha256-IMttQNm/3WzVf5DAaDsXvK+C2JvTeF4VTDtALToHVQo=";
    source = {
      hash = "sha256-AaTs+ytDb0qaqXL28eBbd8AezQtB80Lphe0QN3Ua/c0=";
      owner = "adampoit";
      repo = "taskwarrior-tui";
      rev = "eb4b2bddfc94ede7ceafba2cac7b73ca2666bcbd";
    };
    update = {
      hashFields = [
        "cargoHash"
      ];
      strategy = "manual";
      upstream = {
        ignore = true;
      };
    };
    version = "0.27.0-fork";
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
