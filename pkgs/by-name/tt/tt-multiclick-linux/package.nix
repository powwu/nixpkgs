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
    rev = "9ada7e13d4a6c439308ecf1e8944d7746d7d468b";
    hash = "sha256-Q96b8f+fxGy/57Q3nYsCifTG1aIvK9XnaUcud+qHcyQ=";
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
