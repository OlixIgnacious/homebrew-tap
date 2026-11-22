cask "keyholdr" do
  version "1.7.2"
  sha256 "1d0a6eb48bff75a965f4333d65b98d70d394df1d3ff6cdddef1568e0aef2f083"

  url "https://github.com/OlixIgnacious/keyholdr/releases/download/v#{version}/Keyholdr-macOS-v#{version}.zip",
      verified: "github.com/OlixIgnacious/keyholdr/"
  name "Keyholdr"
  desc "Native menu bar vault for API keys with Touch ID unlock"
  homepage "https://olixignacious.github.io/keyholdr-site/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura
  depends_on arch: :arm64

  app "Keyholdr.app"
  binary "#{appdir}/Keyholdr.app/Contents/MacOS/keyholdr-cli", target: "keyholdr"

  zap trash: "~/Library/Application Support/com.olixstudios.Keyholdr"

  caveats <<~EOS
    The `keyholdr` CLI is linked onto your PATH. The first read of each key
    shows a one-time macOS Keychain consent — choose "Always Allow".

    Secrets live in the macOS Keychain and survive uninstalls by design;
    `brew uninstall --zap keyholdr` removes the metadata file but not the
    Keychain entries.
  EOS
end
