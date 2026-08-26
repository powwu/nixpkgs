
{
  lib,
  fetchFromGitHub,
  rustPlatform,
  makeDesktopItem,
  copyDesktopItems,
  pkg-config,
  gtk3,
  xdotool,
  libevdev,
  font-awesome,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "toonmux";
  version = "0.0.10-powwupatch";

  src = fetchFromGitHub {
    owner = "powwu";
    repo = "toonmux";
    rev = "37b757f0e8e1b894557bc10a40134733e400a783";
    hash = "sha256-Mv1gWmyMFz2OREIBEOvSQmliBqYAU5HBWU3Txj+Ha1A=";
  };

  nativeBuildInputs = [
    pkg-config
    copyDesktopItems
  ];

  buildInputs = [
    gtk3
    libevdev
    xdotool
    font-awesome
  ];

  postPatch = ''
    cp -L --no-preserve=mode ${./Cargo.lock} Cargo.lock
  '';

  cargoLock = {
    lockFile = ./Cargo.lock;
  };

  desktopItems = [
    (makeDesktopItem {
      name = "toonmux";
      desktopName = "toonmux";
      genericName = "Toontown Multicontroller";
      exec = "toonmux-pe";
      categories = [
        "Utility"
      ];
    })
  ];

  meta = {
    description = "Multi-toon controller for Toontown-based MMORPGs";
    homepage = "https://github.com/JonathanHelianthicusDoe/toonmux";
    license = lib.licenses.gpl3Plus;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ powwu ];
  };
})
