class DyskMac < Formula
  desc "A command-line disk utility for macOS that provides detailed information about mounted disks"
  homepage "https://github.com/yourusername/dysk-mac"
  url "https://github.com/yourusername/dysk-mac/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "YOUR_SHA256_HERE" # Calculate this after creating the release
  license "MIT"

  depends_on "node"

  def install
    # Install npm dependencies
    system "npm", "install"
    
    # Make the script executable
    chmod "+x", "index.js"
    
    # Install the binary
    bin.install "index.js" => "dysk-mac"
  end

  test do
    # Test that the command works
    system "#{bin}/dysk-mac", "--help"
  end
end 