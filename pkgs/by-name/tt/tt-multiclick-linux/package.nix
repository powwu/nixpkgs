{
  lib,
  stdenv,
  fetchFromGitHub,
  meson,
  ninja,
  pkg-config,
  gtk3,
  libevdev,
  xorg,
  libei,
  makeDesktopItem,
  copyDesktopItems,
}:
stdenv.mkDerivation {
  pname = "tt-multiclick-linux";
  version = "0-unstable-2025-08-04";

  src = fetchFromGitHub {
    owner = "powwu";
    repo = "tt-multiclick-linux";
    rev = "93415cce60bce0a44339bc983d80d3e202f9490a";
    hash = "sha256-qOF4EE2rMn5tf5MUdXcursdNV0pEDHsL8+W8WRPefjo=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    copyDesktopItems
  ];

  buildInputs = [
    gtk3
    libevdev
    xorg.libX11
    xorg.libXtst
    xorg.libXi
    libei
  ];

  postPatch = ''
    substituteInPlace meson.build \
      --replace-fail \
        "dependencies: [gtk, evdev, x11, xtst, xi, ei, thread])" \
        "dependencies: [gtk, evdev, x11, xtst, xi, ei, thread], install: true)"
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "tt-multiclick-linux";
      desktopName = "tt-multiclick";
      genericName = "Multi-toon Clicker";
      exec = "tt-multiclick";
      categories = [ "Utility" ];
    })
  ];

  meta = {
    description = "Multi-toon clicker for Toontown-based MMORPGs";
    homepage = "https://github.com/powwu/tt-multiclick-linux";
    license = lib.licenses.unfree;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ powwu ];
  };
}
