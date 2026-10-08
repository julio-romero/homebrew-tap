class CursorSession < Formula
  desc "List, show, and export Cursor IDE and Agent CLI chat sessions"
  homepage "https://github.com/julio-romero/cursor-session-rs"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/julio-romero/cursor-session-rs/releases/download/v0.2.0/cursor-session-aarch64-apple-darwin.tar.xz"
      sha256 "131e17f3d0a0e4fbc453d73c6d9b477848d34811bfbc816b2ba6eb6617893ac0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/julio-romero/cursor-session-rs/releases/download/v0.2.0/cursor-session-x86_64-apple-darwin.tar.xz"
      sha256 "56fd45cfcd49e4ba9ba104f30d21af2dfda6532cbffe0cc26de804e3182ba115"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/julio-romero/cursor-session-rs/releases/download/v0.2.0/cursor-session-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "13971fc78ddb795e15ed9af9310cdb7b6bfc6da69d883fc74c6b7faa0e66d1cd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/julio-romero/cursor-session-rs/releases/download/v0.2.0/cursor-session-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cf561fcc7b80ab8fb272da1369ca6c75e7e451bea7a78671c9734c3128072cca"
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
