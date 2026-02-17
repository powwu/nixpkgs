{
  lib,
  fetchFromGitHub,
  rustPlatform,
  makeDesktopItem,
  copyDesktopItems,
  pkg-config,
  gtk3,
  xdotool,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "toonmux";
  version = "0.0.9";

  src = fetchFromGitHub {
    owner = "JonathanHelianthicusDoe";
    repo = "toonmux";
    rev = "4571c53dbcb46c2e27adb94612ab8052dbe9a324";
    hash = "sha256-GwpU/6JkCb11+FfgNUoFIXerwQSOexn/GlkESRzjKIA=";
  };

  nativeBuildInputs = [
    pkg-config
    copyDesktopItems
  ];

  buildInputs = [
    gtk3
    xdotool
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
      desktopName = "toonmux Multicontroller";
      genericName = "Toontown Multicontroller";
      exec = "toonmux";
      categories = [
        "Games"
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
