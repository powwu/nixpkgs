{
  lib,
  stdenvNoCC,
  fetchurl,
  appimage-run,
  makeDesktopItem,
  copyDesktopItems,
  makeWrapper,
}:
let
  appimage = fetchurl {
    url = "https://github.com/the-finest-noobs/ToonSuite-releases/releases/download/v1.1.0/Tunetoon-Linux.AppImage";
    hash = "sha256-GeLL7i2VzepDvCZG6DL27IHzJSkRDXS6DMvpBl4iRgg=";
  };
in
stdenvNoCC.mkDerivation {
  pname = "tunetoon";
  version = "1.1.0";

  src = appimage;

  dontUnpack = true;

  nativeBuildInputs = [
    copyDesktopItems
    makeWrapper
  ];

  installPhase = ''
    install -Dm755 $src $out/share/tunetoon/Tunetoon-Linux.AppImage
    makeWrapper ${appimage-run}/bin/appimage-run $out/bin/tunetoon \
      --add-flags "$out/share/tunetoon/Tunetoon-Linux.AppImage"
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "tunetoon";
      desktopName = "Tunetoon";
      genericName = "Multi-toon Launcher";
      exec = "tunetoon";
      categories = [ "Game" ];
    })
  ];

  meta = {
    description = "Multi-toon launcher for Toontown-based MMORPGs";
    homepage = "https://github.com/the-finest-noobs/ToonSuite-releases";
    license = lib.licenses.unfree;
    platforms = lib.platforms.linux;
    maintainers = [ ];
  };
}
