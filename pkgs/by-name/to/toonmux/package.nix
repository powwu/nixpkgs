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
  version = "0.0.9-powwupatch";

  src = fetchFromGitHub {
    owner = "powwu";
    repo = "toonmux";
    rev = "f46b14ce79892c6ec0dff68e836c8b4cb38b91f0";
    hash = "sha256-kYffDGcFdnxsv6xpMS+f2+j/GwZ/EJDrxldwQjBYl8I=";
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
