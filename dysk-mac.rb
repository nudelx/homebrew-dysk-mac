class DyskMac < Formula
  desc "A command-line disk utility for macOS that provides detailed information about mounted disks"
  homepage "https://github.com/nudelx/homebrew-dysk-mac"
  url "https://github.com/nudelx/homebrew-dysk-mac/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "cbd3aeb1956ced02361575cbc223453aa18745f63eea5810f79e1eb70ebdec65" # You'll need to calculate this after creating the release
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
