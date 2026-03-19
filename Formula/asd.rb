class Asd < Formula
  desc "A terminal-based side-by-side diff viewer with syntax highlighting"
  homepage "https://github.com/vdeantoni/asd"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/vdeantoni/asd/releases/download/v0.2.0/asd-aarch64-apple-darwin.tar.xz"
      sha256 "ce53fdb9978bc389cdf247a323551256eef60baa5bb757baaf53f2ead0e7f49b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vdeantoni/asd/releases/download/v0.2.0/asd-x86_64-apple-darwin.tar.xz"
      sha256 "efc7d8198ae108de6620f7696b602e38e71b204128d414c805a34a517b71f7c7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vdeantoni/asd/releases/download/v0.2.0/asd-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "077c3fc692f55edfb656a4d99ac9ff1bda7383956dc0562589a4d6d5045b69cf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vdeantoni/asd/releases/download/v0.2.0/asd-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5b988a3a044b426f18d9e0199e5b072c0722dd0ff36b28122e4f40ea5f941ffe"
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
