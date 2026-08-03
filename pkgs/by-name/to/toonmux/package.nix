{
  lib,
  fetchFromGitHub,
  rustPlatform,
  makeDesktopItem,
  copyDesktopItems,
  pkg-config,
  gtk3,
  xdotool,
  font-awesome,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "toonmux";
  version = "0.0.10";

  src = fetchFromGitHub {
    owner = "powwu";
    repo = "toonmux";
    rev = "595642acea6f4b453c2899c29adaa826ba897f4c";
    hash = "sha256-/gBJWAXlY9DqpZvQKa2mEOlHMSVqH8HAX84u4VnEkLY=";
  };

  nativeBuildInputs = [
    pkg-config
    copyDesktopItems
    font-awesome
  ];

  buildInputs = [
    gtk3
    xdotool
    font-awesome
  ];

  postPatch = ''
    cp -L ${./Cargo.lock} Cargo.lock
  '';

  cargoLock = {
    lockFile = ./Cargo.lock;
  };

  desktopItems = [
    (makeDesktopItem {
      name = "toonmux";
      desktopName = "toonmux";
      genericName = "Toontown Multicontroller";
      exec = "toonmux";
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
