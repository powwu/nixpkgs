{
  stdenv,
  fetchFromGitHub,
  lib,
  llvm,
  clang_17,
}:

stdenv.mkDerivation rec {
  pname = "cmix";
  version = "21";

  src = fetchFromGitHub {
    owner = "byronknoll";
    repo = "cmix";
    rev = "v${version}";
    sha256 = "sha256-ZLUmNhLYTVskVBKeybH7SELPVK0Kz43+UR1aGFTckao=";
  };

  nativeBuildInputs = [
    llvm
    clang_17
  ];

  patchPhase = ''
    substituteInPlace makefile \
      --replace-fail "clang++-17" "clang++"
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin/
    mv cmix $out/bin/cmix
    mv enwik9-preproc $out/bin/enwik9-preproc
    # cp -r ./dictionary $out

    runHook postInstall
'';

  meta = {
    description = "An example project using clang_17 and LLVM";
    homepage = "https://github.com/example/example-project";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ powwu ];
    platforms = lib.platforms.all;
  };
}
