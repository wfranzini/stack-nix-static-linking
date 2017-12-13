with (import <nixpkgs> {});


haskell.lib.buildStackProject {
  # NOTE: use a version of ghc with integer-simple enabled to avoid
  #       using gmp and related statically linking problems.
  ghc = haskell.compiler.integer-simple.ghc822;

  name = "stack-nix-static-linking";
  nativeBuildInputs = [
    # NOTE: the shared variant of glibc is REQUIRED in the
    #       nativeBuildingInputs since Setup.hs is compiled against
    #       it.  Failing to add it leads to segfaults from Setup.hs
    #       while compiling the project.
    glibc

    glibc.static
 ];
}
