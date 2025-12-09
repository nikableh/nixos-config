{ pkgs }:
pkgs.stdenv.mkDerivation rec {
  name = "Kyocera_CS_2551ci-${version}";
  version = "1.0";

  src = ./.;

  installPhase = ''
    mkdir -p $out/share/cups/model/
    mkdir -p $out/lib/cups/filter/

    cp Kyocera_CS_2551ci.ppd $out/share/cups/model/
    cp kyofilter/* $out/lib/cups/filter/

    substituteInPlace $out/share/cups/model/Kyocera_CS_2551ci.ppd \
      --replace "/usr/lib/cups/filter/kyofilter_H" "$out/lib/cups/filter/kyofilter_H"
  '';
}
