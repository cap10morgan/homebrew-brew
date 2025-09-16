class Perses < Formula
  desc 'Server and web UI for the CNCF sandbox for observability visualisation'
  homepage 'https://perses.dev'
  url 'https://github.com/perses/perses/archive/refs/tags/v0.52.0.tar.gz'
  sha256 '0a584c627b7c76b36883e77506359ccde52ed5e04592be4b8415ae85cd136061'
  license 'Apache-2.0'

  depends_on 'go' => :build
  depends_on 'node@22'
  depends_on 'cap10morgan/brew/percli'

  def install
    chdir('ui') do
      system 'npm', 'install', *std_npm_args(prefix: false)
      bin.install_symlink Dir["#{libexec}/bin/*"]
      system 'npm', 'run', 'build'
    end
    inreplace 'Makefile', /\$\(GO\) build/, '$(GO) build ${GOARGS}'
    system 'make', 'build-api', "GOARGS=#{std_go_args.join(' ')}"
    bin.install 'bin/perses'
  end

  service do
    run opt_bin / 'perses'
  end

  test do
    # TODO: Update this to test the server installation
    assert_match "version: #{version}", shell_output("#{bin}/percli version")
  end
end
