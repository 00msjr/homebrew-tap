class Shush < Formula
  desc "Utility for suppressing and managing output from commands and scripts"
  homepage "https://github.com/00msjr/shush"
  url "https://github.com/00msjr/shush/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "e736b06a16fa62c5b69fa3b75db001dd21f3c141ecb367ea3df973d1f895c1d8"
  license "MIT"

  def install
    bin.install "shush"
  end

  test do
    assert_match "Usage: shush", shell_output("#{bin}/shush --help")
  end
end
