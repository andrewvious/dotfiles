{ pkgs }:
let 
    version = "1.15.1";
in
pkgs.stdenv.mkDerivation {
    pname = "tiup";
    version = version;

    src = pkgs.fetchurl {
        url = 
        "https://github.com/pingcap/tiup/releases/download/v${version}/tiup-v${version}-linux-amd64.tar.gz";
        sha256 = "sha256-/WotonjrrucOO/u3+qA80pB2uQo4p+Kw7f6lDNyjtxc=";
    };

    installPhase = ''
        mkdir -p $out/bin
        cp tiup $out/bin
        '';
}