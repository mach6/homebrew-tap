class Yore < Formula
  desc "Encrypted, searchable shell history synced across your machines"
  homepage "https://github.com/mach6/yore"
  url "https://github.com/mach6/yore/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "55ec3581a5b346b87e3807195dc83c82029d2d4f8a7a86df4d8763d407c471de"
  license "MIT"
  head "https://github.com/mach6/yore.git", branch: "main"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    ldflags = "-X github.com/mach6/yore/internal/cli.Version=v#{version}"
    system "go", "build", *std_go_args(ldflags:), "./cmd/yore"
  end

  def caveats
    <<~EOS
      Add one line to your shell config, after any HISTFILE settings:
        zsh:  eval "$(yore init zsh)"
        bash: eval "$(yore init bash)"
        fish: yore init fish | source
    EOS
  end

  test do
    assert_equal "yore v#{version}", shell_output("#{bin}/yore --version").strip
  end
end
