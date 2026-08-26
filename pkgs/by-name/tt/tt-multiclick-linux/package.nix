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
    rev = "3f5514b001887afa3a81c33a6180522871427646";
    hash = "sha256-UcU7EsCNSKCMr1JbwVc7SGUMJB+DMJBb1Q1O0uzUxck=";
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
