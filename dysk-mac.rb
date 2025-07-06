class DyskMac < Formula
  desc "A command-line disk utility for macOS that provides detailed information about mounted disks"
  homepage "https://github.com/nudelx/dysk-mac"
  url "https://github.com/nudelx/dysk-mac/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "YOUR_SHA256_HERE" # You'll need to calculate this after creating the release
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
    
    # Create a wrapper script
    (bin/"dysk-mac").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/bin/dysk-mac" "$@"
    EOS
    chmod "+x", bin/"dysk-mac"
  end

  test do
    system "#{bin}/dysk-mac", "--help"
  end
end 