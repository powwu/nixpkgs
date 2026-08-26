{
  lib,
  stdenvNoCC,
  fetchurl,
  appimage-run,
  buildFHSEnv,
  makeDesktopItem,
  copyDesktopItems,
  makeWrapper,

  dotnet-runtime_10,
  fontconfig,
  libGL,
  icu,
  libx11,
  libxext,
  libxrandr,
  libxi,
  libxcursor,
  libice,
  libsm,
  libxcomposite,
  libxdamage,
  libxfixes,
  libxrender,
  libxtst,
  libxkbcommon,
  dbus,
  pulseaudio,
  alsa-lib,
  pipewire,
  bottles,
  winetricks,
  cabextract,
  xorgserver,
  gamescope,
}:

let
  appimage = fetchurl {
    url = "https://github.com/the-finest-noobs/ToonSuite-releases/releases/download/v1.1.0/Tunetoon-Linux.AppImage";
    hash = "sha256-GeLL7i2VzepDvCZG6DL27IHzJSkRDXS6DMvpBl4iRgg=";
  };

  fhs = buildFHSEnv {
    name = "tunetoon-fhs";

    targetPkgs = pkgs: [
      dotnet-runtime_10
      fontconfig
      libGL
      icu

      libx11
      libxext
      libxrandr
      libxi
      libxcursor
      libice
      libsm
      libxcomposite
      libxdamage
      libxfixes
      libxrender
      libxtst

      libxkbcommon
      dbus
      pulseaudio
      alsa-lib
      pipewire

      bottles
      winetricks
      cabextract
      xorgserver
      gamescope
    ];

    runScript = "${appimage-run}/bin/appimage-run";
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
    runHook preInstall

    install -Dm755 \
      $src \
      $out/share/tunetoon/Tunetoon-Linux.AppImage

    makeWrapper ${fhs}/bin/tunetoon-fhs $out/bin/tunetoon \
      --add-flags "$out/share/tunetoon/Tunetoon-Linux.AppImage" \
      --set DOTNET_ROOT "${dotnet-runtime_10}/share/dotnet"

    runHook postInstall
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "tunetoon";
      desktopName = "Tunetoon";
      genericName = "Multi-toon Launcher";
      exec = "tunetoon";
      categories = [ "Utility" ];
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
