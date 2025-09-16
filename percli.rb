class Percli < Formula
  desc 'Command line client for the CNCF sandbox for observability visualisation'
  homepage 'https://perses.dev'
  url 'https://github.com/perses/perses/archive/refs/tags/v0.52.0.tar.gz'
  sha256 '0a584c627b7c76b36883e77506359ccde52ed5e04592be4b8415ae85cd136061'
  license 'Apache-2.0'

  depends_on 'go' => :build

  def install
    inreplace 'Makefile', /\$\(GO\) build/, '$(GO) build ${GOARGS}'
    system 'make', 'build-cli', "GOARGS=#{std_go_args.join(' ')}"
    bin.install 'bin/percli'
  end

  test do
    assert_match "version: #{version}", shell_output("#{bin}/percli version")
  end
end
