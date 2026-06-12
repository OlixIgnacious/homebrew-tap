cask "keyholdr" do
  version "1.1.0"
  sha256 "d92d9ca3910481712636fe82f4c70ec9f7de7adec1dd430253908f01898d90a3"

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

  zap trash: "~/Library/Application Support/com.olixstudios.Keyholdr"

  caveats <<~EOS
    Keyholdr is not yet notarized, so macOS will block the first launch.

    On macOS 15 (Sequoia) and later: open the app once, then allow it under
      System Settings → Privacy & Security → "Open Anyway"
    On macOS 13–14: right-click Keyholdr.app → Open

    Secrets live in the macOS Keychain and survive uninstalls by design;
    `brew uninstall --zap keyholdr` removes the metadata file but not the
    Keychain entries.
  EOS
end
