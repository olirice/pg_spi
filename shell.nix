let
  nixpkgs = builtins.fetchTarball {
    name = "2021-12";
    url = "https://github.com/NixOS/nixpkgs/archive/5f8babdd259d68ff8052dfc8d650ebdf9cc3bd75.tar.gz";
  };
in with import nixpkgs {};
mkShell {
  buildInputs =
    let
      pgWithExt = { pg }: pg.withPackages (p: [ (callPackage ./nix/pg_spi { postgresql = pg; }) ]);
      pg_14_w_pg_spi = callPackage ./nix/pg_spi/pgScript.nix { postgresql = pgWithExt { pg = postgresql_14; }; };
    in
    [ pg_14_w_pg_spi ];
}
