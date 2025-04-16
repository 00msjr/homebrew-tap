class Makedir < Formula
  desc "A better mkdir command: Create directories with predefined setups"
  homepage "https://github.com/soup-ms/makedir"
  url "https://github.com/soup-ms/makedir/archive/refs/tags/v0.2.2.tar.gz"
  sha256 "74e317d7dc190e80f021242d0a1138600b09580e3a6e89bc39671ce65cf67211"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system "#{bin}/makedir", "--help"
  end
end
