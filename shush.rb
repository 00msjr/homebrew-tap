class Shush < Formula
  desc "Utility for suppressing and managing output from commands and scripts"
  homepage "https://github.com/00msjr/shush"
  license "MIT"
  def install
    bin.install "shush"
  end
  
  test do
    # Test basic functionality
    assert_equal "0", shell_output("#{bin}/shush -r -- true").strip
    assert_equal "1", shell_output("#{bin}/shush -r -- false || echo 1").strip
    
    # Test output suppression
    output = shell_output("#{bin}/shush -- echo 'This should be suppressed'")
    assert_equal "", output.strip
    
    # Test logging
    system "#{bin}/shush", "-l", "test.log", "--", "echo", "test log"
    assert_predicate testpath/"test.log", :exist?
    assert_match "test log", File.read("test.log")
  end
end

