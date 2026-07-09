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
      hash = "sha256-kwFu8Ts0KgpvYRzkrXFfnqSrxp2SSZ4dmOW1MCa6DRY=";
      url = "https://files.pythonhosted.org/packages/e6/cb/db02cc352820f6d152006b8f624a90b8409de8aad9886f5a4f70fe331650/cortexapps_cli-1.21.0.tar.gz";
    };
    update = {
      strategy = "pypi-release";
    };
    version = "1.21.0";
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
  pi-coding-agent = {
    npmDepsHash = "sha256-UOSV4hQgnk6CDLz1TqXT4bUaGIdIj3He6snjGh+/KN4=";
    source = {
      hash = "sha256-deCpVdoLyhCXUHOJ6srBulrUBT/9tIaEhLVz2bFptXQ=";
      owner = "earendil-works";
      repo = "pi";
      rev = "v0.80.5";
    };
    update = {
      hashFields = [
        "npmDepsHash"
      ];
      npmDepsFetcherVersion = 2;
      strategy = "github-release";
      version = {
        stripPrefix = "v";
      };
    };
    version = "0.80.5";
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
      hash = "sha256-GkrmXlCR2BkMFH8O6M3bp1jy0dxxDz8bnpEjasxv80A=";
      owner = "agentskills";
      repo = "agentskills";
      rev = "0c0c5673846d0a1c983d910b189e329ef3ab8f2a";
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
