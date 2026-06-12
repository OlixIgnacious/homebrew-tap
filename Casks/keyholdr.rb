cask "keyholdr" do
  version "1.2.0"
  sha256 "823dbc90fd0fb38c8573e4de35576bf8253a0718d44151795f3b41a06e33326c"

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
    Keyholdr is not yet notarized, so macOS will block the first launch.

    On macOS 15 (Sequoia) and later: open the app once, then allow it under
      System Settings → Privacy & Security → "Open Anyway"
    On macOS 13–14: right-click Keyholdr.app → Open

    The `keyholdr` CLI is linked onto your PATH. The first read of each key
    shows a one-time macOS Keychain consent — choose "Always Allow".

    Secrets live in the macOS Keychain and survive uninstalls by design;
    `brew uninstall --zap keyholdr` removes the metadata file but not the
    Keychain entries.
  EOS
end
