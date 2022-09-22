{ stdenv, postgresql }:

stdenv.mkDerivation {
  name = "pg_spi";

  buildInputs = [ postgresql ];

  src = ../../.;

  installPhase = ''
    install -D -t $out/share/postgresql/extension *.sql
    install -D -t $out/share/postgresql/extension *.control
    install -D *.so -t $out/lib
  '';
}
