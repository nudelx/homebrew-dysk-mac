class DyskMac < Formula
  desc "A command-line disk utility for macOS that provides detailed information about mounted disks"
  homepage "https://github.com/nudelx/dysk-mac"
  url "file://#{__dir__}/../../dysk-mac-1.0.2.tar.gz"
  sha256 "b904a869fe7ccc420032a216bd33a4fa4cdaaf5e305b1393b87b64224e83eb71"
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