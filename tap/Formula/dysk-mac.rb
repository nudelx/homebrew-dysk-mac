class DyskMac < Formula
  desc "A command-line disk utility for macOS that provides detailed information about mounted disks"
  homepage "https://github.com/nudelx/dysk-mac"
  url "https://github.com/nudelx/dysk-mac/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "2a8b121191c7a03154365524474398b5d774889456922d42ef64e6d0d838a91a"
  license "MIT"

  depends_on "node"

  def install
    # Install npm dependencies
    system "npm", "install"
    
    # Make the script executable
    chmod "+x", "index.js"
    
    # Install all required files to libexec
    libexec.install "index.js", "diskutil.js", "utils.js", "package.json", "node_modules"
    
    # Create a wrapper script
    (bin/"dysk-mac").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/index.js" "$@"
    EOS
    chmod "+x", bin/"dysk-mac"
  end

  test do
    # Test that the command works
    system "#{bin}/dysk-mac", "--help"
  end
end 