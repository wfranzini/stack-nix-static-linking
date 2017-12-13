with (import <nixpkgs> {});


haskell.lib.buildStackProject {
  # use a version of ghc with integer-simple enabled to avoid using
  # gmp and related statically linking problems.
  ghc = haskell.compiler.integer-simple.ghc822;

  name = "stack-nix-static-linking";
  nativeBuildInputs = [
    glibc.static
 ];
}
