class Asd < Formula
  desc "A blazing-fast terminal diff viewer with split panes, syntax highlighting, and word-level change detection"
  homepage "https://github.com/vdeantoni/asd"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/vdeantoni/asd/releases/download/v0.4.0/asd-aarch64-apple-darwin.tar.xz"
      sha256 "4d1abff12e4967684a956edc66da52f2681e07b1e1ced27b2343bf7fb7412510"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vdeantoni/asd/releases/download/v0.4.0/asd-x86_64-apple-darwin.tar.xz"
      sha256 "ae318d6d70af7bbef833c98318d2172fa552c4291c7edc3254b3ce2f3ecbf929"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vdeantoni/asd/releases/download/v0.4.0/asd-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a1c914bfedb289a87be170a3cd8221b88f9e7f759429fa626f7ad3b757a7b29c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vdeantoni/asd/releases/download/v0.4.0/asd-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2aa2956cd8eade67b800ebf3f40560e40ff9b7420e64fa16af1b5c68ca6a5352"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-unknown-linux-gnu": {}
  }

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
      bin.install "asd"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "asd"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "asd"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "asd"
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
