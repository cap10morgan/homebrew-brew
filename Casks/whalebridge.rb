cask "whalebridge" do
  version "0.2.0"
  sha256 "b5ffa7d27707c564399bed2ea3ce3b9cda092f97b7220087e81c90278a505967"

  url "https://github.com/cap10morgan/whalebridge/releases/download/v#{version}/Whalebridge-#{version}.zip"
  name "Whalebridge"
  desc "Docker API bridge for Apple's native container runtime"
  homepage "https://github.com/cap10morgan/whalebridge"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :tahoe
  depends_on arch: :arm64

  app "Whalebridge.app"

  zap trash: [
    "~/Library/Logs/Whalebridge",
    "~/Library/Preferences/me.wesmorgan.whalebridge.plist",
  ]

  # Whalebridge isn't notarized yet (no paid Apple Developer Program
  # enrollment), so Gatekeeper blocks the first launch of a freshly
  # downloaded copy as being from an "unidentified developer."
  caveats <<~EOS
    Whalebridge isn't notarized, so Gatekeeper will block its first launch.
    To get past that one-time block, either:
      - open it normally, then approve it via System Settings → Privacy &
        Security → "Open Anyway", or
      - run: xattr -cr #{appdir}/Whalebridge.app
  EOS
end
