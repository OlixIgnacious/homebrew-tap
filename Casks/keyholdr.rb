cask "keyholdr" do
  version "1.3.0"
  sha256 "7e52cc815dc625aaae9d8add16aba35e2cbf755b65f5c1c188f9753d9de758a3"

  url "https://github.com/OlixIgnacious/keyholdr/releases/download/v#{version}/Keyholdr-macOS-v#{version}.zip",
      verified: "github.com/OlixIgnacious/keyholdr/"
  name "Keyholdr"
  desc "Native menu bar vault for API keys with Touch ID unlock"
  homepage "https://olixignacious.github.io/keyholdr/"

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
    Keyholdr is not yet notarized, so Gatekeeper blocks both the app and the
    bundled CLI until you clear the quarantine flag once:

      xattr -dr com.apple.quarantine "#{appdir}/Keyholdr.app"

    (Or per binary: app → System Settings → Privacy & Security → "Open
    Anyway"; the CLI is killed on launch until allowed the same way.)

    The `keyholdr` CLI is linked onto your PATH. The first read of each key
    shows a one-time macOS Keychain consent — choose "Always Allow".

    Secrets live in the macOS Keychain and survive uninstalls by design;
    `brew uninstall --zap keyholdr` removes the metadata file but not the
    Keychain entries.
  EOS
end
