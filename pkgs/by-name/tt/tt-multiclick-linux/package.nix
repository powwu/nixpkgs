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
    rev = "50a03f3c159805286c02227241cb33e596a21544";
    hash = "sha256-bvuyOEYtIMQJpzczn7CTyUIvX++f58UQgPnEEqJq4HM=";
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
