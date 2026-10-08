class CursorSession < Formula
  desc "List, show, and export Cursor IDE and Agent CLI chat sessions"
  homepage "https://github.com/julio-romero/cursor-session-rs"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/julio-romero/cursor-session-rs/releases/download/v0.3.0/cursor-session-aarch64-apple-darwin.tar.xz"
      sha256 "567756f140d74d3eccfa144964f9cd9db70b81e3ed2c97ca729413fdc72dc52e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/julio-romero/cursor-session-rs/releases/download/v0.3.0/cursor-session-x86_64-apple-darwin.tar.xz"
      sha256 "87b7f61acfba6cab5e2c4c52098300b05d50264cbaa8211caba642862bd6e81c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/julio-romero/cursor-session-rs/releases/download/v0.3.0/cursor-session-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b5b924e6ba269a49e31ded7defbefb426b2037a764b32d1ced72ab0ffe24f8ca"
    end
    if Hardware::CPU.intel?
      url "https://github.com/julio-romero/cursor-session-rs/releases/download/v0.3.0/cursor-session-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3652cbec461dc78e8955db25fda04e24504e0a5452f3d5b88381ebc13e33b9d0"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "cursor-session"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "cursor-session"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "cursor-session"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "cursor-session"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
