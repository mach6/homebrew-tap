class GoCovercheck < Formula
  desc "Fast, flexible CLI tool for enforcing test coverage thresholds in Go projects"
  homepage "https://github.com/mach6/go-covercheck"
  url "https://github.com/mach6/go-covercheck/archive/refs/tags/v0.5.1-pre.tar.gz"
  sha256 "85829046fdf8bc23c45e8ba34d79e07bdd6cbfea69c4962dab5d71779132c278"
  license "MIT"

  depends_on "go" => :build

  def install
    # Set build variables to match the official releases
    ldflags = %W[
      -X github.com/mach6/go-covercheck/pkg/config.AppVersion=#{version}
      -X github.com/mach6/go-covercheck/pkg/config.AppName=go-covercheck
      -X github.com/mach6/go-covercheck/pkg/config.AppRevision=#{stable.specs[:revision] || "unknown"}
      -X github.com/mach6/go-covercheck/pkg/config.BuildTimeStamp=#{Time.now.utc.strftime("%Y-%m-%dT%H:%M:%SZ")}
      -X github.com/mach6/go-covercheck/pkg/config.BuiltBy=homebrew
    ]

    system "go", "build", "-trimpath", "-a", *std_go_args(ldflags: ldflags), "./cmd/go-covercheck"
  end

  test do
    system "#{bin}/go-covercheck", "--version"
    assert_match "go-covercheck version #{version}", shell_output("#{bin}/go-covercheck --version")
  end
end
