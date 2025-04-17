class Shush < Formula
  desc "Utility for suppressing and managing output from commands and scripts"
  homepage "https://github.com/00msjr/shush"
  url "https://github.com/00msjr/shush/archive/refs/tags/1.0.0.tar.gz"
  sha256 "bcf177fe56e5dcc6f3c58199a4b0dd289b0c65bfe5e9c4f9dd29c7bfab50cf2a"
  license "MIT"

  def install
    bin.install "shush"
  end

  test do
    assert_match "Usage: shush", shell_output("#{bin}/shush --help")
  end
end
