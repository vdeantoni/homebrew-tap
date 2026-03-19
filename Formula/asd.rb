class Asd < Formula
  desc "A terminal-based side-by-side diff viewer with syntax highlighting"
  homepage "https://github.com/vdeantoni/asd"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/vdeantoni/asd/releases/download/v0.1.0/asd-aarch64-apple-darwin.tar.xz"
      sha256 "9df5003b2a3011be1b163a8bb5f5374120e0926afb217707acf820adfb82d99f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vdeantoni/asd/releases/download/v0.1.0/asd-x86_64-apple-darwin.tar.xz"
      sha256 "4ffb737f8b8f394213b0af5ea9dcb81d879f4c7e868b72461a8833fd1cf3e77d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vdeantoni/asd/releases/download/v0.1.0/asd-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "97dfc4f2cfa88795a923c15041e9ff4e4516ce1abdfedb2959bef2bb920f27cc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vdeantoni/asd/releases/download/v0.1.0/asd-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "156186b7b74822800fc3e472af205dbd6be8f88a306a3d632646abf75476e3b3"
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
