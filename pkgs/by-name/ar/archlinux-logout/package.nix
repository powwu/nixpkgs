{
  lib,
  fetchFromGitHub,
  stdenv,
  makeWrapper,
  wrapGAppsHook3,

  betterlockscreen,
  gobject-introspection,
  gtk3,
  libwnck,
  python3,
  python3Packages,
}:

let
  runtimeDeps = [
    betterlockscreen
    gobject-introspection
    gtk3
    libwnck
    (python3.withPackages (
      p: with p; [
        distro
        psutil
        pycairo
        pygobject3
      ]
    ))
  ];
in

stdenv.mkDerivation rec {
  pname = "archlinux-logout";
  version = "24.04-01";

  src = fetchFromGitHub {
    owner = "arcolinux";
    repo = "archlinux-logout";
    tag = version;
    hash = "sha256-zSsZsI6mPK7zzfHi00jahO4sAZ4bO2z13DjIom0ouQA=";
  };

  nativeBuildInputs = [
    makeWrapper
    wrapGAppsHook3
  ];

  buildInputs = runtimeDeps;

  buildPhase = ''
    runHook preBuild
    mkdir -p $out/bin
    mkdir -p $out/share/archlinux-logout
    cp usr/bin/archlinux-logout $out/bin/archlinux-logout
    cp -r usr/share/* $out/share/
    cp etc/archlinux-logout.conf $out/archlinux-logout.conf
    runHook postBuild
  '';

  preInstall = ''
    outTrimmed=$(basename "$out" | cut -d '/' -f4-)
    substituteInPlace $out/bin/archlinux-logout \
      --replace-fail "/usr/share/archlinux-logout/archlinux-logout.py" "$out/share/archlinux-logout/archlinux-logout.py"
    substituteInPlace $out/share/archlinux-logout/Functions.py \
      --replace-fail "/etc/archlinux-logout.conf" "/$outTrimmed/archlinux-logout.conf"
  '';

  installPhase = ''
    runHook preInstall
    wrapProgram "$out/bin/archlinux-logout" --prefix PATH : "${lib.makeBinPath runtimeDeps}"
    runHook postInstall
  '';

  meta = {
    description = "Widget displaying a transparent window allowing quick access to various power features";
    homepage = "https://github.com/arcolinux/archlinux-logout";
    license = lib.licenses.gpl3Plus;
    platforms = lib.platforms.linux;
    mainProgram = "archlinux-logout";
    maintainers = with lib.maintainers; [ powwu ];
  };
}
