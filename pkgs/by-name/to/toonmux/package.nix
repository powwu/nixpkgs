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
  version = "0.0.10";

  src = fetchFromGitHub {
    owner = "powwu";
    repo = "toonmux";
    rev = "8a018b5f9e752cf5131be0ebec088c9a63abeb86";
    hash = "sha256-IgqJxjXvtd5mkqUK8gLJTdX9KxtZWNADHgZ78LFNOeM=";
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
