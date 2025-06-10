class Tilde < Formula
  desc "Manage your home directory dotfiles in a nice data format (EDN)"
  homepage "https://github.com/cap10morgan/tilde"
  url "https://github.com/cap10morgan/tilde"
  head "https://github.com/cap10morgan/tilde.git", branch: "main"
  version "0.0.1"
  license "EPL-1.0"

  depends_on "borkdude/brew/babashka"

  def install
    system "make"
    bin.install "target/tilde"
  end
end
