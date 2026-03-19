class Asd < Formula
  desc "A blazing-fast terminal diff viewer with split panes, syntax highlighting, and word-level change detection"
  homepage "https://github.com/vdeantoni/asd"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/vdeantoni/asd/releases/download/v0.3.0/asd-aarch64-apple-darwin.tar.xz"
      sha256 "caf5824ff7ebe408d1917407b66bb40a7e610424a2d1a69656a18f77697cc401"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vdeantoni/asd/releases/download/v0.3.0/asd-x86_64-apple-darwin.tar.xz"
      sha256 "0f9cb85794fd1fc613710e0931632cdb10fb4274db6bf436e626ee00abe7ac87"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vdeantoni/asd/releases/download/v0.3.0/asd-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "dba039a68e09cbb2b5f200da6db66a6dd95851ea1f00fab5289eaeab294eec4f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vdeantoni/asd/releases/download/v0.3.0/asd-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "156f881ff0224c0a49da372575169ea2452d658f58341fab1703c1b104eb0362"
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
