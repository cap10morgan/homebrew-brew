class Perses < Formula
  desc "CNCF sandbox for observability visualisation"
  homepage "https://perses.dev"
  url "https://github.com/perses/perses/archive/refs/tags/v0.52.0-rc.1.tar.gz"
  sha256 "4c2bc2dbb612b239114741a2fc9f1dd4a134b7da9d7e8a458c9695a21a772238"
  license "Apache-2.0"

  depends_on "go" => :build
  depends_on "node@22"

  def install
    chdir("ui") do
      system "npm", "install", *std_npm_args(prefix: false)
      bin.install_symlink Dir["#{libexec}/bin/*"]
      system "npm", "run", "build"
    end
    inreplace "Makefile", /\$\(GO\) build/, "$(GO) build ${GOARGS}"
    system "make", "build-api", "GOARGS=#{std_go_args.join(' ')}"
    bin.install "bin/perses"
    system "make", "build-cli", "GOARGS=#{std_go_args.join(' ')}"
    bin.install "bin/percli"
  end

  service do
    run opt_bin/"perses"
  end

  test do
    assert_match "version: #{version}", shell_output("#{bin}/percli version")
  end
end
