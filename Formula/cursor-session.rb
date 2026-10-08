class CursorSession < Formula
  desc "List, show, search, and export Cursor IDE and Agent CLI chat sessions, and hand one off to another agent"
  homepage "https://github.com/julio-romero/cursor-session-rs"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/julio-romero/cursor-session-rs/releases/download/v0.4.0/cursor-session-aarch64-apple-darwin.tar.xz"
      sha256 "ae8ce806e44476289fb456ad811615d371375dfdfdfb7ac4cc0dc6e307c62e6c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/julio-romero/cursor-session-rs/releases/download/v0.4.0/cursor-session-x86_64-apple-darwin.tar.xz"
      sha256 "7641235c44feb730760b65d0a2792d0f1f61e5bf9036fb80679985d8c4d8257b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/julio-romero/cursor-session-rs/releases/download/v0.4.0/cursor-session-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "07d79aa780f951736b2f6f36a7cad405298a2fc0f7ee444fdab41f97f9b1d2dd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/julio-romero/cursor-session-rs/releases/download/v0.4.0/cursor-session-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fe7fe2c2e3ba2192d6541a12fe70a9e2d053522b207cc8a57182f504c5dee0cb"
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
