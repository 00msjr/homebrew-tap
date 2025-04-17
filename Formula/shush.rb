class Shush < Formula
  desc "Utility for suppressing and managing output from commands and scripts"
  homepage "https://github.com/00msjr/shush"
  url "https://github.com/00msjr/shush/archive/refs/tags/v1.0.4.tar.gz"
  sha256 "d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed"
  license "MIT"

  def install
    bin.install "shush"
  end

  test do
    assert_match "Usage: shush", shell_output("#{bin}/shush --help")
  end
end
